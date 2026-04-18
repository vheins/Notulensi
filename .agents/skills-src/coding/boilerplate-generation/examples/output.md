# Example Output: boilerplate-generation

### Example 1: Node.js + TypeScript + Express REST API

**Expected Output:**
```
Directory Structure:
my-api/
├── src/
│   ├── routes/          # Express route handlers
│   ├── middleware/      # Auth, error handling, logging middleware
│   ├── services/        # Business logic layer
│   ├── repositories/    # Database access layer (Prisma)
│   ├── types/           # TypeScript type definitions
│   └── index.ts         # Application entry point
├── prisma/
│   └── schema.prisma    # Database schema
├── tests/               # Jest test files
├── .env.example         # Environment variable template
├── Dockerfile
├── docker-compose.yml
├── tsconfig.json
├── package.json
└── README.md

Key config files generated:
- package.json with scripts: dev, build, start, test, db:migrate
- tsconfig.json with strict mode, path aliases
- .env.example: DATABASE_URL, JWT_SECRET, PORT, LOG_LEVEL
- .gitignore: node_modules, dist, .env, *.log

Entry point (src/index.ts):
import express from 'express';
import { logger } from './middleware/logger';
import { errorHandler } from './middleware/errorHandler';
import { healthRouter } from './routes/health';

const app = express();
app.use(express.json());
app.use(logger);
app.use('/health', healthRouter);
app.use(errorHandler);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
```

---

### Example 2: Python + FastAPI + SQLAlchemy

**Expected Output:**
```
Directory Structure:
my-service/
├── app/
│   ├── api/             # FastAPI routers
│   ├── core/            # Config, database, logging setup
│   ├── models/          # SQLAlchemy ORM models
│   ├── schemas/         # Pydantic request/response schemas
│   └── main.py          # FastAPI application entry point
├── alembic/             # Database migration files
├── tests/               # pytest test files
├── .env.example
├── Dockerfile
├── docker-compose.yml
├── pyproject.toml
└── README.md

Key config files:
- pyproject.toml: dependencies, pytest config, mypy config
- .env.example: DATABASE_URL, SECRET_KEY, ENVIRONMENT, LOG_LEVEL
- alembic.ini: migration configuration

Entry point (app/main.py):
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api import health
from app.core.config import settings

app = FastAPI(title=settings.PROJECT_NAME)
app.add_middleware(CORSMiddleware, allow_origins=settings.CORS_ORIGINS, ...)
app.include_router(health.router, prefix="/health")
```
