# Tech Stack: Laravel (Modular Monolith)

## 1. Core Stack
- **Framework**: Laravel 13.x
- **Language**: PHP 8.3+ (PHP 8.4/8.5 recommended)
- **Architecture**: Modular Monolith (Custom `modules/` directory)
- **Database**: PostgreSQL (preferred for `pgvector`) / MySQL 8.0+
- **API Standard**: JSON:API (Native Laravel 13 support)

## 2. Architectural Guidelines
- **Modules**:
  - Located in `/modules/{ModuleName}`.
  - Each module has its own `composer.json` (merged via `wikimedia/composer-merge-plugin`).
  - Structure per module:
    - `src/Http/Controllers`
    - `src/Models`
    - `src/Services` (Business Logic)
    - `routes/api.php`
- **Pattern**: Service-Repository or Service-Action.
- **DTO**: Use `spatie/laravel-data` for strict typing.
- **AI Integration**: Use native Laravel AI SDK for text generation and agents.
- **Vector Search**: Use Eloquent vector query support with `pgvector` for semantic search.

## 3. Coding Standards
- **Strict Types**: `declare(strict_types=1);` mandatory.
- **Attributes**: Prefer PHP 8 attributes for declarative configuration (e.g., `#[Table]`, `#[Fillable]`, `#[Queue]`, `#[Middleware]`).
- **Dependency Injection**: Constructor injection.
- **Testing**: pestphp/pest (Feature tests per module).
- **Cache**: Use `Cache::touch()` to extend TTL without re-fetching.

## 4. Folder Structure (Root)
- `/app`: Core infrastructure / Shared.
- `/modules`: Feature modules (Auth, Finance, Inventory, etc).
- `/check`: Custom scripts (e.g. `worker.queue.sh`).
