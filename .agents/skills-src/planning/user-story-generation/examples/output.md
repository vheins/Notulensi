# Example Output: user-story-generation

**Expected Output Shape:**
```
Story 1: View Notification List
- Story: As a registered user, I want to view all my notifications in one place, so that I can stay informed about activity relevant to me.
- Acceptance Criteria:
  1. When the user opens the notification center, the system shall display all notifications in reverse chronological order.
  2. When there are unread notifications, the system shall display a badge with the unread count on the notification icon.
  3. When there are no notifications, the system shall display an empty state message.

Story 2: Mark Notification as Read
- Story: As a registered user, I want to mark notifications as read, so that I can track which updates I have already seen.
- Acceptance Criteria:
  1. When the user clicks a notification, the system shall mark it as read and remove the unread indicator.
  2. When the user clicks "Mark all as read," the system shall mark all notifications as read simultaneously.
  3. When a notification is marked as read, the system shall persist that state across sessions.

Coverage Summary: Covers viewing, reading, and dismissing. Excludes notification preferences and email digest (separate feature).
Suggested Story Order: Story 1 → Story 2 → Story 3 (unread count) → Story 4 (dismiss)
```


**Expected Output Shape:**
```
Story 1: Upload a Document
- Story: As a project member, I want to upload documents to a project workspace, so that I can share files with my team.
- Acceptance Criteria:
  1. When the user selects a file under 50MB, the system shall upload it and display it in the document list.
  2. When the user selects a file over 50MB, the system shall reject the upload and display an error message with the size limit.
  3. When the upload is in progress, the system shall display a progress indicator.

Story 2: Preview an Uploaded Document
- Story: As a project member, I want to preview uploaded documents without downloading them, so that I can quickly review content.
- Acceptance Criteria:
  1. When the user clicks a PDF document, the system shall open an inline preview panel.
  2. When the user clicks an image file, the system shall display a full-size preview overlay.
  3. When a file format is not previewable, the system shall offer a download button instead.

Coverage Summary: Covers upload, preview, and delete. Excludes version history and access permissions (separate stories).
Suggested Story Order: Story 1 (upload) → Story 2 (preview) → Story 3 (delete) → Story 4 (search)
```
