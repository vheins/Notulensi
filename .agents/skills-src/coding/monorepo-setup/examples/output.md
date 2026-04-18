# Example Output: monorepo-setup

**Expected Output Shape:**
```
Directory Structure:
my-monorepo/
├── apps/
│   ├── web/          # React SPA (Vite)
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── src/
│   └── api/          # Express API
│       ├── package.json
│       ├── tsconfig.json
│       └── src/
├── packages/
│   ├── ui/           # Shared React components
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── src/
│   ├── utils/        # Shared utilities (date, string, validation)
│   │   └── ...
│   └── types/        # Shared TypeScript types/interfaces
│       └── ...
├── turbo.json
├── pnpm-workspace.yaml
├── package.json      # Root (no code, only tooling)
├── tsconfig.base.json
└── .eslintrc.js
```

```yaml
# pnpm-workspace.yaml
packages:
  - 'apps/*'
  - 'packages/*'
```

```json
// turbo.json
{
  "$schema": "https://turbo.build/schema.json",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**", "build/**"]
    },
    "test": {
      "dependsOn": ["^build"],
      "outputs": ["coverage/**"]
    },
    "lint": {},
    "dev": {
      "cache": false,
      "persistent": true
    }
  }
}
```

```json
// packages/types/package.json
{
  "name": "@myapp/types",
  "version": "0.0.0",
  "private": true,
  "exports": {
    ".": {
      "types": "./src/index.ts",
      "import": "./dist/index.mjs",
      "require": "./dist/index.js"
    }
  },
  "scripts": {
    "build": "tsup src/index.ts --format esm,cjs --dts",
    "dev": "tsup src/index.ts --format esm,cjs --dts --watch"
  }
}
```

```json
// apps/api/package.json — consuming shared package
{
  "name": "@myapp/api",
  "dependencies": {
    "@myapp/types": "workspace:*",
    "@myapp/utils": "workspace:*"
  }
}
```

CI (GitHub Actions with Turborepo remote cache):
```yaml
- run: pnpm turbo build --filter='[HEAD^1]'  # Only build changed packages
  env:
    TURBO_TOKEN: ${{ secrets.TURBO_TOKEN }}
    TURBO_TEAM: ${{ vars.TURBO_TEAM }}
```


**Expected Output Shape:**
```
Directory Structure:
nx-monorepo/
├── apps/
│   ├── dashboard/    # Angular app
│   ├── admin/        # Angular app
│   └── backend/      # NestJS app
├── libs/
│   ├── shared-ui/    # Angular component library
│   ├── data-access/  # NgRx store + API services
│   └── feature-auth/ # Auth feature module (shared between apps)
├── nx.json
├── tsconfig.base.json
└── package.json
```

```json
// nx.json
{
  "targetDefaults": {
    "build": { "dependsOn": ["^build"], "cache": true },
    "test": { "cache": true },
    "lint": { "cache": true }
  },
  "affected": { "defaultBase": "main" }
}
```

CI optimization:
```bash
# Only test/build affected projects
npx nx affected --target=test --base=origin/main
npx nx affected --target=build --base=origin/main
```
