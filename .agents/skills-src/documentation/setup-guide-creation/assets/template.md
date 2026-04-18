# Template: setup-guide-creation

> Salin template ini dan ganti semua `{{placeholder}}` dengan nilai aktual.

---

# Setup Guide: {{project_name}}

## Prerequisites

- {{prerequisite_1}}
- {{prerequisite_2}}

## Installation

### 1. Clone the repository

```bash
git clone {{repo_url}}
cd {{project_directory}}
```

### 2. Install dependencies

```bash
{{install_command}}
```

### 3. Configure environment

```bash
cp .env.example .env
```

Edit `.env` and fill in:
- `{{env_var_1}}` — {{env_var_1_description}}
- `{{env_var_2}}` — {{env_var_2_description}}

### 4. Start services

```bash
{{start_command}}
```

## Verification

```bash
{{verification_command}}
# Expected: {{expected_output}}
```

## Troubleshooting

**{{common_error_1}}** — {{resolution_1}}
