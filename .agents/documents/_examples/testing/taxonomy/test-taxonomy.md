# Test Scenarios: Taxonomy

## Navigation
- [Overview](../../modules/taxonomy/overview.md) | [Feature](../../modules/taxonomy/taxonomy-management.md) | [API](../../api/taxonomy/api-taxonomy.md)

## 1. Functional

### Happy Path
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| TAX-001 | US-TAX-01 | Create tax. | Admin token | 201 Created |
| TAX-002 | US-TAX-02 | Create term | Taxonomy ID | 201 Created |
| TAX-003 | US-TAX-03 | Attach term | Entity + Term | 201 Created |
| TAX-004 | US-TAX-04 | Hierarchy | `?hierarchy=true` | 200 OK, nested JSON |

### Edge Cases
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| TAX-010 | US-TAX-01 | Duplicate slug | Existing slug | 409 Conflict |
| TAX-011 | US-TAX-02 | Circular parent | B as parent of A | 400 Bad Request |
| TAX-012 | US-TAX-03 | Missing term | "unknown" | 404 Not Found |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | User | No-admin create | POST /taxonomies | 403 Forbidden |
