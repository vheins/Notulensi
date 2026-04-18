# Module Documentation: feature_export

## 1. Responsibility
The `feature_export` module enables the portability of meeting data by generating professional documents and interacting with the OS share system.

## 2. Architecture
- **Layer**: Data/Infrastructure.
- **Plugin**: `pdf` (Document generation) & `share_plus` (OS Sharing).
- **Format**: PDF (Standard A4), TXT (UTF-8).

## 3. Workflows
- **PDF Generation**: Fetch note + highlights -> Layout document -> Save to temp storage.
- **Share Trigger**: Call native share sheet with generated file path.
- **Cleanup**: Delete temporary export files after the share session terminates.

## 4. User Stories
- **US-013**: Export notes as TXT.
- **US-014**: Export notes as PDF summary.

## 5. Test Architecture
This module adheres to the mandatory 4-concern test strategy:
- **Database Testing**: Verify fetching notes and highlights from Isar for export.
- **Service Testing**: Mock document generation (PDF/TXT) and verify file output structure and content.
- **State Management Testing**: Test state emissions during the generation and sharing process (e.g., preparing, ready, sharing, error).
- **UI Testing**: Widget test for the share/export bottom sheet and error dialogs.

## 6. Test Scenarios
| Type | Scenario | Expected Result |
| :--- | :--- | :--- |
| **Positive** | Export PDF with 10 Action Items. | PDF is generated and contains all items. |
| **Negative** | Export with zero transcript content. | Export blocked; user notified. |
| **Edge** | Rapidly trigger export multiple times. | System queues or replaces temp files without crash. |
| **Security** | Restricted file paths. | System verifies write access before attempting to save. |
