# Feature Prioritization: Notulensi

## 1. Prioritization Table (MoSCoW)
| Feature | Category | Rationale |
| :--- | :--- | :--- |
| **Offline Recording & STT** | Must | The product doesn't exist without this. |
| **Isar/Hive Implementation** | Must | Foundation for all data management. |
| **Rule-based Keyword Parser** | Must | Primary differentiator from simple recording apps. |
| **Export (PDF/TXT)** | Must | Final deliverable for the user's workflow. |
| **AdMob Integration** | Should | Necessary for sustainable free-tier maintenance. |
| **Advanced Local Models** | Could | High effort, optional "pro" upgrade. |

## 2. Top 3 Quick Wins
* **Local Note CRUD:** High value for organization, very low effort with Isar.
* **Rule-based Parser:** High perceived "intelligence" for very low technical effort (Regex/Keyword lists).
* **PDF Export:** Critical professional feature, straightforward with existing Flutter packages.

## 3. Low-Value Flags
* **Cloud Sync:** High effort, high maintenance, and breaks the core "Privacy" value prop. (Decision: Cut).
* **Multi-Speaker Recognition:** High technical complexity (XL effort) for marginal utility in a "quick notes" MVP. (Decision: Defer).

## 4. Build Order Summary
The build will follow a "Data-First" sequence: 1. Storage & CRUD, 2. Recording & STT Bridge, 3. Parsing Logic, 4. UI Polish, 5. Monetization. This ensures that the foundation is stable before we layer on the complex transcription engine.
