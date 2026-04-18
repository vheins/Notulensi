# Example Input: dependency-upgrade

### Example 1: Node.js + React 17 → React 18

**Input:**
- `{{tech_stack}}`: Node.js 20 + npm + React + TypeScript
- `{{current_dependencies}}`:
```json
{
  "react": "^17.0.2",
  "react-dom": "^17.0.2",
  "@types/react": "^17.0.0",
  "@types/react-dom": "^17.0.0"
}
```
- `{{target_versions}}`: "react: 18.3.0, react-dom: 18.3.0"

---

### Example 2: Python + Django 3.2 → Django 4.2

**Input:**
- `{{tech_stack}}`: Python 3.11 + pip + Django
- `{{current_dependencies}}`:
```
Django==3.2.18
djangorestframework==3.13.1
django-cors-headers==3.13.0
```
- `{{target_versions}}`: "Django==4.2.0, djangorestframework==3.14.0"
