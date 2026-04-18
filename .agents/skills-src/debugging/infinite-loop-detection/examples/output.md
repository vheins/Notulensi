# Example Output: infinite-loop-detection

**Expected Output Shape:**
```
1. Loop Structure Analysis
Type: while loop
Condition: node.next !== null
Update: node = node.next
Termination invariant: requires the list to be acyclic (no node points back to a previous node)

2. Termination Failure
If the list contains a cycle (node A → node B → node A), node.next is never null. The loop traverses the cycle indefinitely.

3. Fix with Loop Invariant (Floyd's Cycle Detection)
function findTail(node) {
  const visited = new Set();
  while (node.next !== null) {
    if (visited.has(node)) throw new Error('Circular linked list detected');  // cycle guard
    visited.add(node);
    node = node.next;
  }
  return node;
}
// Invariant: at each iteration, node has not been visited before
// Terminates because: either node.next is null (acyclic) or cycle is detected (throws)

4. Defensive Guard
Already included via the visited Set. For memory-constrained environments, use Floyd's two-pointer algorithm instead.

5. Test Case
it('throws on circular linked list', () => {
  const a = { next: null }; const b = { next: a }; a.next = b;  // cycle
  expect(() => findTail(a)).toThrow('Circular linked list detected');
});
it('returns tail for acyclic list', () => {
  const list = { next: { next: { next: null } } };
  expect(findTail(list)).toEqual({ next: null });
});
```


**Expected Output Shape:**
```
1. Loop Structure Analysis
Type: recursive function
Base case: item is not a list (appends to result)
Recursive case: item is a list (calls flatten recursively)
Termination invariant: requires finite nesting depth < Python recursion limit

2. Termination Failure
Not a true infinite loop — Python raises RecursionError at depth 1000. The function is correct for shallow nesting but fails for deeply nested structures (depth > 1000).

3. Fix: Iterative Flatten with Explicit Stack
def flatten(data):
    result = []
    stack = [data]  # explicit stack replaces call stack
    while stack:
        item = stack.pop()
        if isinstance(item, list):
            stack.extend(reversed(item))  # push items in order
        else:
            result.append(item)
    return result
# Invariant: stack contains all unprocessed items
# Terminates because: each iteration removes one item from stack; no item is re-added

4. Defensive Guard
MAX_DEPTH = 100
def flatten(data, depth=0):
    if depth > MAX_DEPTH: raise ValueError(f'Nesting depth exceeds {MAX_DEPTH}')
    ...

5. Test Case
def test_deeply_nested():
    deep = [1]
    for _ in range(2000): deep = [deep]
    assert flatten(deep) == [1]  # would fail with recursive version
```
