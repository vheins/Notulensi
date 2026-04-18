# Example Output: problem-identification

## Scenario: B2B SaaS — Project Management Tool

> Output yang dihasilkan ketika diberikan input dari `input.md`

```
1. Problem Statement
Engineering managers at mid-size tech companies spend 2–4 hours every Friday manually compiling status reports from Jira tickets, GitHub PRs, and Slack threads. This process is error-prone, inconsistent across teams, and delays the delivery of accurate information to stakeholders. The manual effort diverts manager attention from higher-value work like unblocking engineers and strategic planning.

2. Affected Users
Primary: Engineering managers (encounter weekly, workaround: manual copy-paste from multiple tools)
Secondary: VPs of Engineering (receive inconsistent reports, workaround: ask follow-up questions in meetings)

3. Current Pain Points
- Pain 1: Switching between 3+ tools to gather data wastes ~2 hours per report cycle, causing delayed delivery
- Pain 2: Report format varies by manager, making cross-team comparison impossible for leadership
- Pain 3: Historical data is lost when managers leave, creating knowledge gaps during transitions

4. Root Cause Hypothesis
Why do managers spend hours on reports? → Because data lives in disconnected tools.
Why is data disconnected? → Because each tool (Jira, GitHub, Slack) has its own data model with no unified view.
Why is there no unified view? → Because no standard exists for cross-tool engineering metrics at the team level.

5. Impact if Unsolved
Short-term: 2–4 hours/week per manager wasted; stakeholder trust erodes due to inconsistent reporting.
Long-term: Engineering orgs scale without visibility infrastructure; decisions made on stale or incomplete data.
```
