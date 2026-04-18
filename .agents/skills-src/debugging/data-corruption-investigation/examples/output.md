# Example Output: data-corruption-investigation

**Expected Output Shape:**
```
1. Corruption Pattern Analysis
Type: duplicate records — identical orders created within the same second.
Scope: 2,847 duplicate pairs across 1,203 users.
Timing: started 3 days ago, correlates with retry logic deployment 4 days ago.
Pattern: systematic — affects users who experienced network timeouts during checkout.

2. Corruption Source Identification
Race condition from non-idempotent retry logic — when a checkout request times out, the retry logic submits the order again. The original request may have succeeded (order created) but the response was lost. The retry creates a second identical order.

3. Audit Trail Analysis
PostgreSQL WAL shows two INSERT statements for the same user within 1ms — confirms double-submit.
Git history: retry logic added in commit abc1234 on 2025-01-09.

4. Remediation Plan
Step 1: Identify all duplicates:
  SELECT user_id, total, created_at, COUNT(*) as cnt
  FROM orders GROUP BY user_id, total, created_at HAVING COUNT(*) > 1;

Step 2: Backup affected records:
  CREATE TABLE orders_backup_20250115 AS SELECT * FROM orders WHERE id IN (duplicate_ids);

Step 3: Remove duplicates (keep lowest id):
  DELETE FROM orders WHERE id IN (
    SELECT MAX(id) FROM orders
    GROUP BY user_id, total, created_at HAVING COUNT(*) > 1
  );

Step 4: Add idempotency key to prevent recurrence:
  ALTER TABLE orders ADD COLUMN idempotency_key VARCHAR(64) UNIQUE;
  -- Client sends idempotency_key with each request; duplicate requests return existing order

5. Prevention
- Add UNIQUE constraint on idempotency_key
- Implement idempotency key pattern: client generates UUID per checkout attempt
- Add database-level constraint: UNIQUE(user_id, idempotency_key)
```


**Expected Output Shape:**
```
1. Corruption Pattern Analysis
Type: field overwrite — email field set to null for 15,000 documents.
Scope: all documents processed by the bulk update script.
Timing: started exactly when the bulk update script ran 2 days ago.
Pattern: systematic — all affected documents have null email, suggesting the script overwrote the field.

2. Corruption Source Identification
Incorrect $set usage — the bulk update script used $set with a partial document object that did not include the email field. MongoDB's $set with a field set to undefined/null overwrites the existing value with null.

3. Audit Trail Analysis
MongoDB oplog shows $set operations with {preferences: {...}, email: null} — confirms the script set email to null.
Python script review: document = {"preferences": new_prefs}; collection.update_many({}, {"$set": document}) — email not included, defaults to None in Python dict.

4. Remediation Plan
Step 1: Identify scope:
  db.users.countDocuments({email: null})  # should return ~15,000

Step 2: Backup:
  db.users.aggregate([{$match: {email: null}}, {$out: "users_backup_20250115"}])

Step 3: Restore from backup or source of truth:
  # If email is in another collection or backup:
  db.users_backup.find({email: {$ne: null}}).forEach(doc => {
    db.users.updateOne({_id: doc._id}, {$set: {email: doc.email}})
  })

Step 4: Fix the update script:
  # Before: {"$set": document}  (overwrites all fields in document)
  # After:  {"$set": {"preferences": new_prefs}}  (only sets the new field)

5. Prevention
- Never use $set with a full document object — always specify exact fields
- Add a pre-update validation: assert all required fields are present before bulk operations
- Run bulk updates on a staging copy first
- Add MongoDB schema validation: db.createCollection with jsonSchema validator
```
