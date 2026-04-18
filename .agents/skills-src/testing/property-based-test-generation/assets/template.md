# Property-Based Test Specification Template

> Fill in all fields before activating the `property-based-test-generation` skill.

---

## Function to Test

**Name:** `{{e.g. calculateDiscount, parseDate, sortItems}}`

**Description:** {{what it does}}

**Tech Stack:** {{e.g. TypeScript + fast-check, Python + Hypothesis, Haskell + QuickCheck, Go + gopter}}

---

## Function Signature

```{{language}}
{{paste function signature}}
```

---

## Properties to Verify

> A "property" is an invariant that must hold for ALL valid inputs.

| Property | Description | Example |
|----------|-------------|---------|
| {{e.g. Idempotency}} | `f(f(x)) === f(x)` | {{e.g. sorting twice = sorting once}} |
| {{e.g. Commutativity}} | `f(a, b) === f(b, a)` | {{e.g. add(1,2) === add(2,1)}} |
| {{e.g. Roundtrip}} | `decode(encode(x)) === x` | {{e.g. parse(serialize(obj)) deep equals obj}} |
| {{e.g. Monotonicity}} | larger input → larger output | {{e.g. higher quantity → higher total}} |
| {{e.g. Boundary}} | output always within range | {{e.g. discount always 0–100%}} |
| {{e.g. Non-null}} | never returns null for valid input | |

---

## Input Generators

| Parameter | Type | Generator / Constraints |
|-----------|------|------------------------|
| `{{param}}` | {{type}} | {{e.g. arbitrary integer 1–1000, non-empty string, valid email}} |
| `{{param}}` | {{type}} | {{e.g. array of 1–100 items}} |

---

## Known Invariants / Business Rules

- {{e.g. result is always non-negative}}
- {{e.g. output length equals input length}}
- {{e.g. no items are lost during transformation}}

---

## Framework Config

**Library:** {{e.g. fast-check, Hypothesis, QuickCheck}}

**Number of runs:** {{e.g. 100 (default), 1000 for critical functions}}

**Seed (for reproducibility):** {{e.g. fixed seed in CI}}
