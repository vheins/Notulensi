# Example Output: design-system-specification

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Color Palette**

Primary scale (derived from #2563EB):
- `meridian-primary-600: #2563eb` — [BASE] primary button background, links
- `meridian-primary-700: #1d4ed8` — primary button hover
- `meridian-primary-800: #1e40af` — primary button active/pressed

Semantic colors:
- `success-base: #16a34a` — form validation, status badges
- `warning-base: #d97706` — alert banners, caution states
- `error-base: #dc2626` — error messages, destructive actions

Dark Mode: `[data-theme="dark"]` block with inverted neutral scale.

**2. Typography Scale**

- `font-sans: "Inter", "Helvetica Neue", Arial, sans-serif` — body text
- `font-display: "Cal Sans", "Inter", sans-serif` — headings
- `font-mono: "JetBrains Mono", "Fira Code", monospace` — code blocks

**3. Tailwind CSS Output**

```js
// tailwind.config.js
module.exports = {
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: {
          50:  '#eff6ff',
          600: '#2563eb',
          950: '#172554',
        },
        success: { base: '#16a34a', light: '#dcfce7', dark: '#14532d' },
        error:   { base: '#dc2626', light: '#fee2e2', dark: '#7f1d1d' },
      },
      fontFamily: {
        sans:    ['Inter', 'Helvetica Neue', 'Arial', 'sans-serif'],
        display: ['Cal Sans', 'Inter', 'sans-serif'],
        mono:    ['JetBrains Mono', 'Fira Code', 'monospace'],
      },
    },
  },
}
```
