# Module: core_storage

## Responsibility
The `core_storage` module is responsible for the persistent storage and retrieval of all application data, including database records (Isar) and physical files (audio, exported PDFs).

## Architecture
- **Layer**: Data/Infrastructure.
- **Engine**: Isar NoSQL Database.
- **Pattern**: Repository Pattern with Local Data Sources.
