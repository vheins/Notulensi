# Project Boilerplate Specification Template

> Fill in all fields before activating the `boilerplate-generation` skill.

---

## Project Info

**Project Name:** `{{project-name}}`

**Tech Stack:** {{e.g. Node.js 20 + TypeScript 5 + Express + Prisma + PostgreSQL}}

**Project Type:** {{REST API / GraphQL API / CLI tool / React SPA / microservice / npm library}}

---

## Features to Include

| Feature | Include? | Notes |
|---------|----------|-------|
| Authentication (JWT) | {{yes/no}} | {{e.g. access + refresh tokens}} |
| Database ORM | {{yes/no}} | {{e.g. Prisma, TypeORM, SQLAlchemy}} |
| Input validation | {{yes/no}} | {{e.g. Zod, Joi, Pydantic}} |
| Structured logging | {{yes/no}} | {{e.g. pino, winston}} |
| Error handling middleware | {{yes/no}} | |
| Docker + docker-compose | {{yes/no}} | |
| Testing setup | {{yes/no}} | {{e.g. Jest, Vitest, pytest}} |
| CI/CD config | {{yes/no}} | {{e.g. GitHub Actions}} |
| Environment config | {{yes/no}} | {{e.g. dotenv, .env.example}} |
| Linting + formatting | {{yes/no}} | {{e.g. ESLint + Prettier}} |
| API documentation | {{yes/no}} | {{e.g. Swagger/OpenAPI}} |

---

## Directory Structure Preferences

**Preferred pattern:** {{e.g. feature-based, layer-based (controllers/services/repos)}}

**Test location:** {{e.g. co-located __tests__/, separate tests/ directory}}

---

## Environment Variables Needed

| Variable | Example Value | Description |
|----------|---------------|-------------|
| `DATABASE_URL` | `postgresql://...` | Database connection string |
| `JWT_SECRET` | `changeme` | JWT signing secret |
| `PORT` | `3000` | HTTP server port |
| `{{VAR}}` | `{{value}}` | {{description}} |
