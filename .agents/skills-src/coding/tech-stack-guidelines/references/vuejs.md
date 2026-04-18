# Tech Stack: Vue.js (Modular)

## 1. Core Stack
- **Build Tool**: Vite
- **Framework**: Vue 3.5+
- **Language**: TypeScript
- **State**: Pinia (Setup Store standard)
- **Routing**: Vue Router 4.x
- **UI**: Tailwind CSS, SweetAlert2, Tabler Icons

## 2. Architectural Guidelines
- **Modular Aliases**:
  - `#/`: Mapped to `/modules/`.
  - `~/`: Mapped to `/resources/`.
- **Global Components**: Located in `/resources/js/components`.
- **Entry Point**: `resources/js/app.js`.

## 3. Coding Rules
- **Pinia**: Use Setup Stores (`defineStore('id', () => { ... })`).
- **Composables**: Extracted to `resources/js/composables` or module-level `composables`.
- **API**: Use `axios` or `fetch` wrapper.

## 4. Testing
- **E2E**: Cypress or Playwright.
