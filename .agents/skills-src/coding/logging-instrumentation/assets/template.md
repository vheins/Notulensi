# Logging & Instrumentation Specification Template

> Fill in all fields before activating the `logging-instrumentation` skill.

---

## Application Context

**Tech Stack:** {{e.g. Node.js + Express + TypeScript, Python + FastAPI, Go + Gin}}

**Current Logging:** {{describe what exists — e.g. "console.log only", "no structured logging", "basic winston setup"}}

---

## Log Levels & Usage

| Level | When to Use |
|-------|-------------|
| `error` | Unhandled exceptions, critical failures |
| `warn` | Recoverable issues, deprecated usage |
| `info` | Request lifecycle, business events |
| `debug` | Detailed flow for development |
| `trace` | Very verbose, disabled in production |

---

## Required Log Fields

| Field | Type | Source | Example |
|-------|------|--------|---------|
| `timestamp` | ISO 8601 | auto | `2026-03-20T17:00:00Z` |
| `level` | string | auto | `info` |
| `message` | string | manual | `User logged in` |
| `requestId` | uuid | middleware | `abc-123` |
| `userId` | string | auth context | `user_456` |
| `path` | string | request | `/api/orders` |
| `method` | string | request | `POST` |
| `statusCode` | number | response | `201` |
| `duration` | number (ms) | middleware | `45` |
| `{{field}}` | {{type}} | {{source}} | {{example}} |

---

## Logger Library

**Preferred:** {{e.g. pino (Node.js), structlog (Python), zerolog (Go), zap (Go)}}

**Output format:** {{JSON / pretty-print (dev only)}}

**Log destination:** {{stdout / file / both}}

---

## Instrumentation Points

| Point | Log Level | Fields |
|-------|-----------|--------|
| Incoming request | `info` | method, path, requestId |
| Outgoing response | `info` | statusCode, duration |
| DB query (slow >500ms) | `warn` | query, duration |
| External API call | `info` | service, endpoint, duration |
| Unhandled error | `error` | error, stack, requestId |
| Business event | `info` | event, userId, metadata |
| `{{point}}` | `{{level}}` | `{{fields}}` |
