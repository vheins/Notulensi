# Example Output: dependency-conflict-resolution

**Expected Output Shape:**
```
1. Conflict Identification
react-beautiful-dnd@13.1.1 requires react@^16.8.0 (supports React 16/17)
@tanstack/react-query@5.0.0 requires react@^18.0.0
Current react@16.14.0 satisfies react-beautiful-dnd but not react-query v5.

2. Compatibility Matrix
| react-query | react-beautiful-dnd | React version | Compatible? |
|-------------|---------------------|---------------|-------------|
| v5.x        | v13.x               | 18.x          | ❌ (dnd doesn't support 18) |
| v4.x        | v13.x               | 16.x/17.x     | ✅ |
| v5.x        | @hello-pangea/dnd   | 18.x          | ✅ (fork with React 18 support) |

3. Resolution Strategy
Option A (recommended): Replace react-beautiful-dnd with @hello-pangea/dnd (maintained fork with React 18 support) + upgrade React to 18 + use react-query v5
Option B: Stay on react-query v4 + keep react-beautiful-dnd + React 16/17

4. Lock File Fix
# Option A:
npm uninstall react-beautiful-dnd
npm install @hello-pangea/dnd react@^18.0.0 react-dom@^18.0.0 @tanstack/react-query@^5.0.0
# Update imports: 'react-beautiful-dnd' → '@hello-pangea/dnd' (API is identical)

5. Prevention
Use npm-check-updates to preview upgrades before applying. Add peer dependency checks to CI: npx check-peer-dependencies
```


**Expected Output Shape:**
```
1. Conflict Identification
fastapi@0.104.0 requires pydantic>=2.0.0
my-legacy-lib@1.2.0 requires pydantic<2.0.0
No version of pydantic satisfies both constraints simultaneously.

2. Compatibility Matrix
| FastAPI version | my-legacy-lib | Pydantic version | Compatible? |
|----------------|---------------|------------------|-------------|
| 0.104.0        | 1.2.0         | 2.x              | ❌ |
| 0.95.x         | 1.2.0         | 1.x              | ✅ |
| 0.104.0        | 2.0.0 (if exists) | 2.x           | ✅ (if updated) |

3. Resolution Strategy
Option A: Downgrade FastAPI to 0.95.x (last version supporting Pydantic v1)
  poetry add fastapi@^0.95.0

Option B: Fork/patch my-legacy-lib to support Pydantic v2 (if you own it)
  # Update model definitions: BaseModel fields, validators, Config class

Option C: Use pydantic v1 compatibility layer
  pip install pydantic[v1]  # pydantic v2 includes v1 compat module

4. Lock File Fix
# Option A:
poetry add fastapi@^0.95.0
poetry lock --no-update  # regenerate lock file

5. Prevention
Add dependency constraint tests to CI: poetry check
Use poetry show --tree to visualize the full dependency tree before adding new packages.
```
