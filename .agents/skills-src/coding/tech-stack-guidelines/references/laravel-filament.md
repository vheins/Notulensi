# Tech Stack: Laravel Filament (ERP Monolith)

## 1. Core Stack
- **Framework**: Laravel 13.x
- **Admin Panel**: Filament 5.x
- **Frontend**: Livewire 4.x
- **CSS Framework**: Tailwind CSS 4.0+
- **Architecture**: Standard Monolith (ERP Optimized)
- **Permissions**: `spatie/laravel-permission` + `bezhansalleh/filament-shield`
- **Database**: PostgreSQL / MySQL 8.0+

## 2. Architectural Guidelines
- **Structure**:
  - `/app/Filament`: All Admin Logic.
  - `/app/Filament/Clusters`: Group related Resources (e.g. `Finance`, `HR`).
  - `/app/Filament/Resources`: Standalone Resources.
  - `/app/Models`: Eloquent Models using PHP 8 attributes (Laravel 13 standard).
  - `/app/Providers`: App Service Providers (FilamentPanelProvider).
  - `/app/Policies`: Authorization Policies (Strict).
- **Pattern**: Resource-driven development. Logic resides in Resources and Actions.
- **Performance**: Leverages Livewire 4 Islands for isolated re-renders and parallel async requests.

## 3. Coding Rules
- **Themes**: Custom theme utilizing Tailwind CSS 4 features.
- **Components**: Prefer the native `Callout` component and stacked table rows for mobile optimization.
- **Optimization**: Use `php artisan filament:optimize` and `php artisan livewire:configure-sfc` (if applicable).
- **Strict Mode**: `Model::shouldBeStrict()` in local environment.
- **AI-Native**: Designed for compatibility with **Filament Blueprint** for AI-assisted code generation.

## 4. Testing
- **Feature**: Test Filament Resources using native Livewire 4 testing utilities (`$this->get(UserResource::getUrl('index'))->assertSuccessful()`).
- **Unit**: Test complex actions/jobs using the `#[Tries]` and `#[Queue]` attributes.
- **Validation**: Use `InteractsWithPageTable` for comprehensive table testing.
