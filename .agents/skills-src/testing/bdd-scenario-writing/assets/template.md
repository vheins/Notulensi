# BDD Scenario Template (Gherkin)

> Fill in all fields before activating the `bdd-scenario-writing` skill.

---

## Feature Info

**Feature Name:** `{{e.g. User Login, Checkout, Password Reset}}`

**Feature Description:** {{one-line description of the feature}}

**Stakeholders:** {{e.g. end users, admins, payment team}}

---

## User Stories

| As a... | I want to... | So that... |
|---------|-------------|------------|
| `{{role}}` | `{{action}}` | `{{benefit}}` |

---

## Scenarios to Cover

### Happy Path

```gherkin
Feature: {{Feature Name}}

  Scenario: {{happy path description}}
    Given {{initial context / precondition}}
    When {{action performed}}
    Then {{expected outcome}}
    And {{additional assertion}}
```

### Negative / Error Cases

```gherkin
  Scenario: {{error case description}}
    Given {{context}}
    When {{invalid action}}
    Then {{error outcome}}
```

### Edge Cases

```gherkin
  Scenario: {{edge case description}}
    Given {{boundary condition}}
    When {{action}}
    Then {{expected behavior}}
```

---

## Step Definitions Context

**Framework:** {{e.g. Cucumber.js, Behave (Python), SpecFlow (.NET), Behat (PHP)}}

**Existing step definitions:** {{yes/no — list reusable steps if any}}

**Test data setup:** {{e.g. factory, fixtures, database seeds}}

---

## Acceptance Criteria

- {{criterion 1}}
- {{criterion 2}}
- {{criterion 3}}
