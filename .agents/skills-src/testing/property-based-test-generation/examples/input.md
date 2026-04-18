# Example Input: property-based-test-generation

## Example 1: JSON serializer roundtrip

| Variable | Value |
|----------|-------|
| `{{code_context}}` | `serialize(obj: Record<string, unknown>): string` and `deserialize(str: string): Record<string, unknown>` — custom JSON-like serializer |
| `{{tech_stack}}` | TypeScript + fast-check + Jest |
| `{{properties}}` | roundtrip (deserialize(serialize(x)) deep equals x), no data loss, handles all JSON-safe values |
