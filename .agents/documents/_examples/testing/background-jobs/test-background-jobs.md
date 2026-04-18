# Test Scenarios: Background Jobs

## Navigation
- [Overview](../../modules/background-jobs/overview.md) | [Feature](../../modules/background-jobs/job-processing.md) | [API](../../api/background-jobs/api-background-jobs.md)

## 1. Functional

### Happy Path
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| JOB-001 | US-JOB-03 | Enqueue export | Valid payload | 202 Accepted |
| JOB-002 | US-JOB-01 | Worker process | — | Status → completed |
| JOB-003 | US-JOB-01 | Scheduled run | — | Job enqueued |
| JOB-004 | US-JOB-02 | Retry via API | Job ID | 200 OK, active |

### Edge Cases
| ID | User Story | Case | Input | Expected |
| :- | :--------- | :--- | :---- | :------- |
| JOB-010 | US-JOB-02 | Retry to DLQ | Fail-trigger | DLQ after N retries |
| JOB-011 | US-JOB-02 | Invalid ID | Random ID | 404 Not Found |

## 2. Security
| ID | Role | Case | Action | Expected |
| :- | :--- | :---- | :----- | :------- |
| SEC-001 | Any | Unauth access | No token | 401 Unauthorized |
| SEC-002 | User | Cross-access | User B Job | 403 Forbidden |

## 3. Chaos
| ID | Focus | Case | Expected |
| :- | :---- | :--- | :------- |
| MNK-001 | Broker | Kill mid-process | Pauses/Resumes |
| MNK-002 | Load | 10k jobs flood | No memory leaks |
