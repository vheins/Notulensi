# Environment Setup Specification Template

> Fill in all fields before activating the `environment-setup` skill.

---

## Project Info

**Project Name:** `{{project-name}}`

**Tech Stack:** {{e.g. Node.js 20 + TypeScript + PostgreSQL + Redis}}

**OS Target:** {{macOS / Linux / Windows (WSL2) / all}}

---

## Required Tools

| Tool | Version | Install Method |
|------|---------|----------------|
| Node.js | {{e.g. 20.x}} | {{e.g. nvm, brew, asdf}} |
| Python | {{e.g. 3.11}} | {{e.g. pyenv, brew}} |
| Docker | {{e.g. latest}} | Docker Desktop |
| {{tool}} | {{version}} | {{method}} |

---

## Services (local)

| Service | Version | Port | Start Command |
|---------|---------|------|---------------|
| PostgreSQL | {{e.g. 15}} | 5432 | {{e.g. docker-compose up db}} |
| Redis | {{e.g. 7}} | 6379 | {{e.g. docker-compose up redis}} |
| {{service}} | {{version}} | {{port}} | {{command}} |

---

## Environment Variables

Copy `.env.example` to `.env` and fill in:

| Variable | Example Value | Description |
|----------|---------------|-------------|
| `DATABASE_URL` | `postgresql://postgres:postgres@localhost:5432/{{db}}` | Local DB |
| `REDIS_URL` | `redis://localhost:6379` | Local Redis |
| `{{VAR}}` | `{{example}}` | {{description}} |

---

## Setup Steps

1. Clone repo: `git clone {{repo-url}}`
2. Install dependencies: `{{e.g. npm install, pip install -r requirements.txt}}`
3. Copy env: `cp .env.example .env`
4. Start services: `{{e.g. docker-compose up -d}}`
5. Run migrations: `{{e.g. npm run db:migrate}}`
6. Seed data (optional): `{{e.g. npm run db:seed}}`
7. Start dev server: `{{e.g. npm run dev}}`

---

## Verify Setup

```bash
# Expected output after successful setup:
{{e.g. Server running on http://localhost:3000}}
{{e.g. Database connected}}
```
