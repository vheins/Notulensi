# Processing Overview

## Navigation
- [Overview](./overview.md)
- [API](../../api/processing/api-processing.md)
- [Tests](../../testing/processing/overview.md)

## 1. Intro
- **Role:** Support (Domain)
- **Value:** Automatically extracts action items and deadlines from transcripts locally.

## 2. Features
| Feature | Desc | Doc |
|---------|------|-----|
| **Rule-Based Extraction** | Regex-based highlight generation | [processing.md](./processing.md) |

## 3. Architecture
```mermaid
flowchart TB
    Isolate["Background Isolate (Compute)"] --> RegexEngine["Regex Pipeline"]
    RegexEngine --> DataMapper["Data Mapper"]
    DataMapper --> Repo["NoteRepository (Isar)"]
```

## 4. Dependencies
- **Store:** Isar Database
- **External:** None
- **Internal:** Recording, Storage
