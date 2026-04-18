# Dockerfile / Containerization Specification Template

> Fill in all fields before activating the `dockerfile-containerization` skill.

---

## Application Info

**App Name:** `{{app-name}}`

**Tech Stack:** {{e.g. Node.js 20 + TypeScript, Python 3.11 + FastAPI, Go 1.22}}

**Entry Point:** {{e.g. `node dist/index.js`, `uvicorn main:app`, `./bin/server`}}

**Port:** `{{e.g. 3000, 8080}}`

---

## Build Requirements

**Build command:** `{{e.g. npm run build, go build -o ./bin/server}}`

**Build output:** `{{e.g. dist/, ./bin/server}}`

**Build args / secrets needed:** {{e.g. NPM_TOKEN for private registry}}

---

## Runtime Requirements

**Environment variables:**
| Variable | Required | Description |
|----------|----------|-------------|
| `DATABASE_URL` | yes | DB connection string |
| `PORT` | no | Defaults to 3000 |
| `{{VAR}}` | {{yes/no}} | {{description}} |

**Volumes / persistent storage:** {{e.g. /app/uploads, none}}

**External services:** {{e.g. PostgreSQL, Redis, S3}}

---

## Optimization Goals

| Goal | Include? |
|------|----------|
| Multi-stage build (smaller image) | {{yes/no}} |
| Non-root user | {{yes/no}} |
| Layer caching (deps before source) | {{yes/no}} |
| Health check endpoint | {{yes/no — path: /health}} |
| docker-compose for local dev | {{yes/no}} |
| .dockerignore | {{yes/no}} |

---

## Base Image Preference

**Preferred base:** {{e.g. node:20-alpine, python:3.11-slim, scratch (Go)}}

**Registry:** {{Docker Hub / AWS ECR / GitHub Container Registry}}
