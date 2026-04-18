# Tech Stack: .NET (Enterprise Clean Architecture)

## 1. Core Stack

| Category | Technology | Version |
|----------|------------|---------|
| Framework | .NET | 10 (LTS) |
| Language | C# | 14+ |
| Web Framework | ASP.NET Core Web API | 10.x |
| ORM | Entity Framework Core | 10.x |
| Database | SQL Server / PostgreSQL | 2022+ / 17+ |

## 2. Architecture: Clean Architecture

```
Solution/
├── src/
│   ├── Domain/          # Entities, Value Objects, Domain Events, Interfaces
│   ├── Application/     # Use Cases, CQRS Handlers, DTOs, Validators
│   ├── Infrastructure/  # EF Core, Repositories, External Services, Caching
│   └── API/             # Controllers, Middleware, Filters, Program.cs
└── tests/
    ├── Domain.UnitTests/
    ├── Application.UnitTests/
    ├── Application.IntegrationTests/
    └── API.FunctionalTests/
```

### Layer Responsibilities

| Layer | Responsibility | Dependencies |
|-------|----------------|--------------|
| **Domain** | Business logic, Entities, Value Objects, Domain Events | None (innermost) |
| **Application** | Use cases, CQRS, Validation, DTOs, Interfaces | Domain |
| **Infrastructure** | Data access, External services, Caching | Application, Domain |
| **API** | HTTP endpoints, Auth, Middleware, Filters | Application |

## 3. Essential Libraries

| Purpose | Library |
|---------|---------|
| CQRS/Mediator | `MediatR` |
| Validation | `FluentValidation` |
| Mapping | `Mapster` or `AutoMapper` |
| Logging | `Serilog` |
| API Docs | `Swashbuckle.AspNetCore` |
| Caching | `StackExchange.Redis` |
| Background Jobs | `Hangfire` or `Quartz.NET` |
| Resilience | `Polly` |

## 4. Coding Standards

- Enable nullable reference types: `<Nullable>enable</Nullable>`
- Use `async/await` with `CancellationToken` in all I/O operations
- Use `record` for DTOs and Commands/Queries (immutable)
- Use Result pattern: `Result<T>` for operation outcomes
- Constructor Injection only — no service locator pattern
- Use CQRS: Commands (write) and Queries (read) via MediatR

## 5. Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Interface | `I` prefix | `IUserRepository` |
| Async Method | `Async` suffix | `GetUserAsync` |
| Command | Action + Entity + `Command` | `CreateUserCommand` |
| Query | `Get` + Entity + `Query` | `GetUserByIdQuery` |
| Handler | Command/Query + `Handler` | `CreateUserCommandHandler` |
| DTO | Entity + `Dto` | `UserDto` |

## 6. Testing

| Purpose | Library |
|---------|---------|
| Framework | `xUnit` |
| Assertions | `FluentAssertions` |
| Mocking | `Moq` or `NSubstitute` |
| Integration | `WebApplicationFactory` |
| Architecture | `NetArchTest` |

## 7. Do's ✅ and Don'ts ❌

**Do:**
- Use `record` for DTOs and Commands/Queries
- Use MediatR for CQRS pattern
- Use FluentValidation for input validation
- Write unit tests for handlers
- Write integration tests for API endpoints

**Don't:**
- Put business logic in Controllers
- Use `Helpers` folder (anti-pattern)
- Skip validation
- Catch `Exception` without logging
- Hardcode configuration values
