# Example Input: data-corruption-investigation

### Example 1: PostgreSQL + Node.js — Duplicate Order Records
**Input:**
- `{{tech_stack}}`: PostgreSQL + Node.js + Express
- `{{corruption_symptoms}}`: Some users have duplicate orders in the database; orders table has 2,847 duplicate pairs; started appearing 3 days ago
- `{{data_samples}}`: `id:1001, user_id:42, total:99.99, created_at:2025-01-12 14:23:01\nid:1002, user_id:42, total:99.99, created_at:2025-01-12 14:23:01` (identical except id)
- `{{context}}`: Checkout endpoint; no unique constraint on (user_id, created_at, total); retry logic added 4 days ago to handle network timeouts


### Example 2: MongoDB + Python — Partial Update Corruption
**Input:**
- `{{tech_stack}}`: MongoDB + Python + FastAPI
- `{{corruption_symptoms}}`: User profile documents have missing fields (email or phone_number is null) after a bulk update operation; affects 15,000 documents
- `{{data_samples}}`: `{"_id": "abc", "name": "Alice", "email": null, "phone": "+1234567890"}` (email should be "alice@example.com")
- `{{context}}`: Bulk update script ran 2 days ago to add a new `preferences` field; script used $set with the full document instead of just the new field
