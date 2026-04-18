# References: brainstorm-feature

## Technical Design Brief Structure

A good design brief answers:
1. **What** — what problem does this solve?
2. **How** — what components are needed?
3. **Where** — what data model changes are required?
4. **Risk** — what can go wrong and how is it mitigated?
5. **Order** — in what sequence should it be built?

## Component Decomposition Heuristics

- One component = one responsibility
- If a component needs to know too much about another → extract an interface
- Prefer composition over inheritance
- Keep components stateless where possible

## Data Model Change Checklist

- [ ] Is the change backward-compatible?
- [ ] Does it require a migration?
- [ ] Are foreign keys indexed?
- [ ] Are monetary values stored as `decimal(15,2)`?
- [ ] Are UUIDs used as primary keys?

See `.agents/rules/database-standards.md` for full database standards.
