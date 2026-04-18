# Example Output: configuration-management

### Example 1: Node.js + TypeScript

**Expected Output:**
```typescript
// config/schema.ts — defines all config with types and validation
import { z } from 'zod';

const configSchema = z.object({
  NODE_ENV: z.enum(['development', 'staging', 'production']).default('development'),
  PORT: z.coerce.number().int().min(1).max(65535).default(3000),
  DATABASE_URL: z.string().url(),
  REDIS_URL: z.string().url(),
  JWT_SECRET: z.string().min(32, 'JWT_SECRET must be at least 32 characters'),
  LOG_LEVEL: z.enum(['debug', 'info', 'warn', 'error']).default('info'),
  STRIPE_API_KEY: z.string().optional(),
  FEATURE_NEW_CHECKOUT: z.coerce.boolean().default(false),
});

// Startup validation — fails fast with all errors listed
const parsed = configSchema.safeParse(process.env);
if (!parsed.success) {
  console.error('❌ Invalid configuration:');
  parsed.error.issues.forEach(issue => console.error(`  ${issue.path.join('.')}: ${issue.message}`));
  process.exit(1);
}

export const config = parsed.data;

// Redacted view for health endpoints — never expose secrets
export const configSummary = {
  NODE_ENV: config.NODE_ENV,
  PORT: config.PORT,
  LOG_LEVEL: config.LOG_LEVEL,
  DATABASE_URL: config.DATABASE_URL.replace(/:\/\/.*@/, '://***@'), // mask credentials
  JWT_SECRET: '[REDACTED]',
  STRIPE_API_KEY: config.STRIPE_API_KEY ? '[SET]' : '[NOT SET]',
};
```

.env.example:
```
# Application
NODE_ENV=development
PORT=3000
LOG_LEVEL=info

# Database (required)
DATABASE_URL=postgresql://user:password@localhost:5432/mydb

# Redis (required)
REDIS_URL=redis://localhost:6379

# Auth (required, min 32 chars)
JWT_SECRET=change-me-to-a-secure-random-string-in-production

# Payments (required in production)
STRIPE_API_KEY=sk_test_...

# Feature flags
FEATURE_NEW_CHECKOUT=false
```

---

### Example 2: Python + FastAPI

**Expected Output:**
```python
# core/config.py
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import AnyUrl, field_validator
from typing import List
import json

class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    # Application
    DEBUG: bool = False
    SECRET_KEY: str
    ALLOWED_ORIGINS: List[str] = []

    # Database
    DATABASE_URL: AnyUrl

    # Email
    SMTP_HOST: str
    SMTP_PORT: int = 587
    SMTP_USER: str
    SMTP_PASS: str  # secret

    # Limits
    MAX_UPLOAD_SIZE_MB: int = 10

    @field_validator("SECRET_KEY")
    @classmethod
    def secret_key_min_length(cls, v: str) -> str:
        if len(v) < 32:
            raise ValueError("SECRET_KEY must be at least 32 characters")
        return v

    @property
    def safe_dict(self) -> dict:
        """Config summary safe for logging — secrets redacted."""
        return {
            "DEBUG": self.DEBUG,
            "DATABASE_URL": str(self.DATABASE_URL).replace(self.DATABASE_URL.password or "", "***"),
            "SMTP_HOST": self.SMTP_HOST,
            "SMTP_PASS": "[REDACTED]",
            "SECRET_KEY": "[REDACTED]",
        }

# Singleton — validated at import time (startup validation)
settings = Settings()
```
