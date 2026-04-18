# Example Input: dependency-conflict-resolution

### Example 1: Node.js + npm — React Version Conflict
**Input:**
- `{{tech_stack}}`: Node.js + npm
- `{{error_message}}`: `npm ERR! peer react@"^16.8.0" from react-beautiful-dnd@13.1.1\nnpm ERR! peer react@"^18.0.0" from @tanstack/react-query@5.0.0\nnpm ERR! Conflicting peer dependency: react@16.14.0`
- `{{package_file}}`: `{ "dependencies": { "react": "^16.14.0", "react-beautiful-dnd": "^13.1.1", "@tanstack/react-query": "^5.0.0" } }`
- `{{context}}`: Upgrading @tanstack/react-query from v4 to v5; react-beautiful-dnd has not been updated for React 18


### Example 2: Python + Poetry — Conflicting Transitive Dependencies
**Input:**
- `{{tech_stack}}`: Python + Poetry
- `{{error_message}}`: `SolverProblemError: Because fastapi 0.104.0 depends on pydantic (>=2.0.0) and my-legacy-lib 1.2.0 depends on pydantic (<2.0.0), fastapi 0.104.0 is incompatible with my-legacy-lib 1.2.0`
- `{{package_file}}`: `[tool.poetry.dependencies]\npython = "^3.11"\nfastapi = "^0.104.0"\nmy-legacy-lib = "^1.2.0"`
- `{{context}}`: Upgrading FastAPI to 0.104.0 which requires Pydantic v2; my-legacy-lib was written for Pydantic v1
