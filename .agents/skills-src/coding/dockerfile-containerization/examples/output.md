# Example Output: dockerfile-containerization

**Expected Output Shape:**
```dockerfile
# Dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package files first — cached unless dependencies change
COPY package*.json ./
RUN npm ci --only=production=false

COPY tsconfig.json ./
COPY src/ ./src/
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS production
WORKDIR /app

# Non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy only production dependencies and compiled output
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

COPY --from=builder /app/dist ./dist

USER appuser

EXPOSE 3000

# Health check — adjust path to your health endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Exec form ensures signals reach the Node process
CMD ["node", "dist/index.js"]
```

```
# .dockerignore
node_modules
dist
.env
.env.*
*.log
.git
coverage
```

```yaml
# docker-compose.yml
version: '3.9'
services:
  app:
    build: { context: ., target: builder }
    command: npm run dev  # hot reload in dev
    ports: ["3000:3000"]
    env_file: .env
    volumes:
      - ./src:/app/src:ro  # source mount for hot reload
    depends_on:
      postgres: { condition: service_healthy }
      redis: { condition: service_healthy }

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: myapp_dev
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    volumes: [postgres_data:/var/lib/postgresql/data]
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 5s

volumes:
  postgres_data:
```

Image Size: ~180MB (vs ~1.2GB without multi-stage). Alpine base + production-only node_modules.


**Expected Output Shape:**
```dockerfile
# Dockerfile
FROM python:3.11-slim AS builder
WORKDIR /app
RUN pip install --no-cache-dir uv
COPY requirements.txt .
RUN uv pip install --system --no-cache -r requirements.txt

FROM python:3.11-slim AS production
WORKDIR /app
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin/uvicorn /usr/local/bin/uvicorn
COPY app/ ./app/
USER appuser
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "2"]
```

```yaml
# docker-compose.yml
services:
  api:
    build: .
    ports: ["8000:8000"]
    env_file: .env
    volumes: [./app:/app/app]  # hot reload via --reload flag in dev
    depends_on:
      postgres: { condition: service_healthy }

  postgres:
    image: postgres:15-alpine
    environment: { POSTGRES_DB: myapp, POSTGRES_USER: postgres, POSTGRES_PASSWORD: password }
    volumes: [pgdata:/var/lib/postgresql/data]
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s

volumes:
  pgdata:
```

Image Size: ~220MB. Slim base, uv for fast dependency installation.
