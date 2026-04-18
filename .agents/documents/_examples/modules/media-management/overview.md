# Module: Media Management

## Navigation
- [Module List](../../README.md)

## 1. Intro
- **Role:** Centralized asset storage and attachment logic.
- **Value:** Decouples storage concerns from business domains.

## 2. Features
- **File Management:** Upload, store, transform, attach. [Details](./file-management.md)

## 3. Architecture
```mermaid
flowchart LR
    API["Media API"]
    Adapter["Storage Adapter"]
    Cloud["Cloud (S3)"]
    Local["Local FS"]
    DB[("Metadata")]
    API --> Adapter
    Adapter --> Cloud
    Adapter --> Local
    API --> DB
```

## 4. Deps
- **Config:** Provider credentials, MIME limits, size limits.
- **Libs:** Storage abstraction, image processing.
