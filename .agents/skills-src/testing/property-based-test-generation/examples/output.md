# Example Output: property-based-test-generation

## Example 1: JSON serializer roundtrip

```typescript
import * as fc from 'fast-check';
import { serialize, deserialize } from '../src/serializer';

describe('Serializer — property-based tests', () => {
  // Property 1: Roundtrip — deserialize(serialize(x)) deep equals x
  it('roundtrip: deserialize(serialize(x)) === x for any JSON-safe object', () => {
    fc.assert(
      fc.property(
        fc.jsonValue(), // generates any JSON-safe value
        (value) => {
          const obj = typeof value === 'object' && value !== null ? value as Record<string, unknown> : { value };
          expect(deserialize(serialize(obj))).toEqual(obj);
        }
      ),
      { numRuns: 1000 }
    );
  });

  // Property 2: Idempotency — serialize(deserialize(serialize(x))) === serialize(x)
  it('idempotency: serializing twice produces same result', () => {
    fc.assert(
      fc.property(
        fc.dictionary(fc.string(), fc.jsonValue()),
        (obj) => {
          const once = serialize(obj);
          const twice = serialize(deserialize(once));
          expect(twice).toBe(once);
        }
      )
    );
  });

  // Property 3: No data loss — all keys preserved
  it('no key loss: all keys present after roundtrip', () => {
    fc.assert(
      fc.property(
        fc.dictionary(fc.string({ minLength: 1 }), fc.string()),
        (obj) => {
          const result = deserialize(serialize(obj));
          expect(Object.keys(result).sort()).toEqual(Object.keys(obj).sort());
        }
      )
    );
  });

  // Property 4: Output is always a valid string
  it('serialize always returns a non-empty string', () => {
    fc.assert(
      fc.property(
        fc.dictionary(fc.string(), fc.jsonValue()),
        (obj) => {
          const result = serialize(obj);
          expect(typeof result).toBe('string');
          expect(result.length).toBeGreaterThan(0);
        }
      )
    );
  });
});
```
