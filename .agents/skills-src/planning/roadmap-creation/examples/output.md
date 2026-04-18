# Example Output: roadmap-creation

**Expected Output Shape:**
```
| Phase | Milestone | Deliverables | Timeline | Dependencies | Success Criteria |
|-------|-----------|--------------|----------|--------------|-----------------|
| Phase 1 | Core Foundation | User auth, project creation, task management | Month 1–2 | None | Users can create projects and assign tasks |
| Phase 2 | Collaboration | Team invitations, activity feed, email notifications | Month 3–4 | Phase 1 | Teams can collaborate; notifications delivered |
| Phase 3 | Insights | Dashboard analytics | Month 5 | Phase 1, 2 | Managers can view team productivity metrics |
| Phase 4 | Growth | API integrations | Month 6 | Phase 1–3 | 2+ integrations live; webhook events firing |
| Deferred | Mobile app | Native iOS/Android app | Post-launch | Phase 1–4 | Deferred — insufficient capacity in 6-month window |

Phasing Rationale: Phase 1 delivers the core value loop. Phase 2 enables team use (required for B2B). Phase 3 adds retention value. Mobile deferred due to capacity constraints.
Critical Path: Phase 1 → Phase 2 → Phase 3 → Phase 4
Risks: 1) Auth complexity delays Phase 1 → mitigate with NextAuth.js. 2) Analytics scope creep → timebox to 3 charts. 3) API integration partner delays → start partner outreach in Month 4.
```


**Expected Output Shape:**
```
| Phase | Milestone | Deliverables | Timeline | Dependencies | Success Criteria |
|-------|-----------|--------------|----------|--------------|-----------------|
| Phase 1 | Content Platform | Instructor registration, course creation, video upload | Month 1–3 | None | Instructors can publish courses with video |
| Phase 2 | Student Experience | Student enrollment, progress tracking, quizzes | Month 4–6 | Phase 1 | Students can enroll, watch, and complete courses |
| Phase 3 | Monetization | Payment processing, certificates | Month 7–8 | Phase 1, 2 | Revenue flowing; certificates issued on completion |
| Phase 4 | Growth | Affiliate program | Month 9 | Phase 3 | Affiliate links tracked; commissions calculated |

Phasing Rationale: Content must exist before students can enroll. Monetization requires a complete student experience. Affiliate program is a growth lever, not core functionality.
Critical Path: Phase 1 → Phase 2 → Phase 3 → Phase 4
Risks: 1) Video upload/encoding complexity → use third-party (Mux or Cloudflare Stream). 2) Payment compliance (PCI) → use Stripe, not custom implementation. 3) 3-person team is lean → no parallel phase work possible.
```
