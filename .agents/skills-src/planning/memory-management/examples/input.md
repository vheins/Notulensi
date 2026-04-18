# Example Input: memory-management

## Example 1: New architectural decision

| Variable | Value |
|----------|-------|
| `{{memory_file_path}}` | `.agents/memory.md` |
| `{{change_type}}` | `decision_made` |
| `{{change_description}}` | `Decided to use CQRS pattern for the reporting module. Read models are separate from write models. Reason: reporting queries were causing lock contention on the main orders table.` |

---

## Example 2: New coding pattern established

| Variable | Value |
|----------|-------|
| `{{memory_file_path}}` | `.agents/memory.md` |
| `{{change_type}}` | `new_pattern` |
| `{{change_description}}` | `All background jobs must extend BaseJob and implement handle(). Jobs must be idempotent — safe to retry on failure. Established after a double-charge incident in production.` |
