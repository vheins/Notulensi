# ADR-001: Selection of Isar for Local Persistence

**Date**: 2025-05-20
**Status**: Accepted

## Context
The application requires a high-performance, offline-first database that supports complex relationships, full-text search (FTS), and built-in encryption. As a privacy-first meeting recorder, the volume of text data (transcripts) and metadata (markers, action items) will grow significantly over time.

## Decision
We will use **Isar Database** as the primary persistence layer.

### Rationale
- **Performance**: Isar is significantly faster than SQLite/sqflite for large datasets and complex queries.
- **Full-Text Search**: Built-in FTS is critical for searching through meeting transcripts locally.
- **Built-in Encryption**: Supports AES-GCM 256-bit encryption out of the box, aligning with our biometric safe-box requirement.
- **Type Safety**: Generates code from Dart classes, reducing runtime errors and boilerplate.

## Consequences
### Positive
- Native encryption simplifies the implementation of the private Safe-Box.
- Rapid search across thousands of meetings without cloud indexing.
- Clean architectural separation between Domain Entities and Isar Collections.

### Negative
- Code generation adds a build step (`build_runner`).
- Slightly larger app binary size compared to simple shared preferences.

## Alternatives Considered
- **SQLite (sqflite)**: Rejected due to high boilerplate and manual SQL management for FTS and encryption.
- **Hive**: Rejected as it is no longer being actively maintained/improved in favor of Isar (by the same author).
