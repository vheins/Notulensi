# Example Input: infinite-loop-detection

### Example 1: JavaScript + Node.js — Linked List Traversal
**Input:**
- `{{tech_stack}}`: JavaScript + Node.js
- `{{code}}`: `function findTail(node) { while (node.next !== null) { node = node.next; } return node; }`
- `{{symptoms}}`: Process hangs at 100% CPU when processing certain user-submitted linked lists
- `{{context}}`: User-submitted data can contain circular linked lists; no cycle detection implemented


### Example 2: Python — Recursive Function Without Base Case
**Input:**
- `{{tech_stack}}`: Python
- `{{code}}`: `def flatten(data):\n    result = []\n    for item in data:\n        if isinstance(item, list):\n            result.extend(flatten(item))\n        else:\n            result.append(item)\n    return result`
- `{{symptoms}}`: RecursionError: maximum recursion depth exceeded when processing deeply nested lists
- `{{context}}`: Input data can be arbitrarily deeply nested; Python default recursion limit is 1000
