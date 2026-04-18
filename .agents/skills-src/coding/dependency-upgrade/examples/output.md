# Example Output: dependency-upgrade

### Example 1: Node.js + React 17 → React 18

**Expected Output:**
```
Breaking Change Analysis:
1. ReactDOM.render() removed → replaced by createRoot()
   - All entry points using ReactDOM.render() must be updated
2. Automatic batching: state updates in async functions now batch (was React 17 behavior only in event handlers)
   - May change rendering behavior in components with multiple setState calls in async code
3. Strict Mode double-invocation: effects now mount/unmount/remount in development
   - Effects with non-idempotent setup (e.g., subscriptions) may behave differently in dev

Impact Assessment: MEDIUM — entry point change required, async batching may affect 2–5 components

Step-by-Step Migration:
1. Update packages:
   npm install react@18.3.0 react-dom@18.3.0 @types/react@18 @types/react-dom@18

2. Update entry point (src/index.tsx):
   // Before:
   ReactDOM.render(<App />, document.getElementById('root'));
   // After:
   import { createRoot } from 'react-dom/client';
   const root = createRoot(document.getElementById('root')!);
   root.render(<App />);

3. Search for other ReactDOM.render() calls:
   grep -r "ReactDOM.render" src/

4. Run tests: npm test
5. Check for batching-related issues in async event handlers

Rollback Plan:
npm install react@17.0.2 react-dom@17.0.2 @types/react@17 @types/react-dom@17
Revert src/index.tsx to ReactDOM.render() pattern.

Post-Upgrade Checklist:
- [ ] All tests pass
- [ ] Entry point renders correctly
- [ ] No console warnings about deprecated APIs
- [ ] Check React DevTools for unexpected re-renders
```

---

### Example 2: Python + Django 3.2 → Django 4.2

**Expected Output:**
```
Breaking Change Analysis:
1. DEFAULT_AUTO_FIELD: Must be set explicitly (was implicitly BigAutoField in 3.2)
   - Add to settings.py: DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
2. CSRF_TRUSTED_ORIGINS: Now requires scheme (https://example.com, not example.com)
3. django.utils.encoding.force_text() removed → use force_str()
4. django.utils.translation.ugettext() removed → use gettext()

Impact Assessment: LOW-MEDIUM — settings changes + search for removed utility functions

Step-by-Step Migration:
1. pip install Django==4.2.0 djangorestframework==3.14.0
2. Run: python manage.py check --deploy
3. Update settings.py: add DEFAULT_AUTO_FIELD, fix CSRF_TRUSTED_ORIGINS
4. Search and replace: grep -r "force_text\|ugettext" . --include="*.py"
5. Run migrations: python manage.py migrate
6. Run test suite: python manage.py test

Rollback Plan:
pip install Django==3.2.18 djangorestframework==3.13.1
If migrations were run: restore database from pre-upgrade backup.

Post-Upgrade Checklist:
- [ ] python manage.py check returns no errors
- [ ] All existing tests pass
- [ ] Admin interface loads correctly
- [ ] API endpoints return expected responses
- [ ] Check Django security release notes for 4.x
```
