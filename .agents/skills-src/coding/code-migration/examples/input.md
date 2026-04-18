# Example Input: code-migration

### Example 1: JavaScript + Express 4 → TypeScript + Express 5

**Input:**
- `{{source_stack}}`: JavaScript + Express 4 + Mongoose
- `{{target_stack}}`: TypeScript + Express 5 + Mongoose 8
- `{{code}}`:
```javascript
const express = require('express');
const User = require('./models/User');
const router = express.Router();

router.get('/users/:id', function(req, res, next) {
  User.findById(req.params.id, function(err, user) {
    if (err) return next(err);
    if (!user) return res.status(404).json({ message: 'Not found' });
    res.json(user);
  });
});

module.exports = router;
```
- `{{migration_scope}}`: "Single route handler"

---

### Example 2: Python 2.7 + Flask → Python 3.11 + FastAPI

**Input:**
- `{{source_stack}}`: Python 2.7 + Flask 0.12
- `{{target_stack}}`: Python 3.11 + FastAPI 0.110
- `{{code}}`:
```python
from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/calculate', methods=['POST'])
def calculate():
    data = request.get_json()
    a = data.get('a')
    b = data.get('b')
    if a is None or b is None:
        return jsonify({'error': 'Missing parameters'}), 400
    result = a / b
    return jsonify({'result': result})
```
- `{{migration_scope}}`: "Single endpoint"
