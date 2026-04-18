# Example Input: changelog-generation

### Example 1: TypeScript Library with Semantic Versioning
**Input:**
- `{{project_name}}`: "json-schema-validator"
- `{{commit_history}}`:
  ```
  feat: add support for draft-2020-12 keywords
  fix: resolve incorrect error path for nested $ref
  chore: upgrade ajv to 8.12.0
  feat: expose validateAsync() method on Validator class
  fix: handle null values in additionalProperties check
  security: patch ReDoS vulnerability in pattern keyword
  v1.2.0
  feat: add JSON Schema draft-07 support
  fix: correct error message for enum validation
  chore: migrate build to esbuild
  v1.1.0
  feat: initial release with draft-04 support
  v1.0.0
  ```
- `{{current_version}}`: "1.3.0"
- `{{repo_url}}`: "https://github.com/org/json-schema-validator"


### Example 2: Python CLI Tool — v2.0.0 Major Release
**Input:**
- `{{project_name}}`: "dbmigrate-cli"
- `{{version}}`: "2.0.0"
- `{{release_date}}`: "2024-03-15"
- `{{changes}}`: "Breaking: removed --legacy flag; Added: parallel migration support, dry-run mode; Fixed: rollback on partial failure; Deprecated: --verbose (use --log-level instead)"
