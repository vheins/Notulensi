# Form Design Specification: Note Edit Form

## 1. Form Info
- **Form Name**: Note Detail Edit Form
- **Purpose**: Allows users to manually correct transcript errors, edit the title, or change the assigned project folder.
- **Route / Page**: `/note/:id` (Triggered via "Edit" action).
- **Framework**: Flutter (`GetX` Controller + `Form`).
- **Validation Approach**: On Blur and On Submit.

## 2. Field Inventory
| Name | Type | Label | Placeholder | Required | Rules | Errors |
|------|------|-------|-------------|----------|-------|--------|
| `title` | Text (Single) | "Meeting Title" | "e.g., Weekly Sync" | Yes | Min 1 char, Max 100 chars | "Title cannot be empty" |
| `folderId` | Dropdown | "Project Folder" | "Select a folder..." | No | Must map to valid `Folder` UUID | "Invalid folder selected" |
| `transcript` | Text (Multi) | "Transcript" | "..." | Yes | Cannot be empty | "Transcript is required" |

## 3. Submission States
- **Loading**: Save button transforms into a `CircularProgressIndicator`. Form fields are disabled (`enabled: false`) to prevent double-submission.
- **Success**: SnackBar appears: "Note updated". Form switches back to "View Mode" (Read-only).
- **Error**: If Isar write fails, SnackBar appears: "Failed to save changes. Please try again." Save button resets.

## 4. Accessibility (A11y)
- **Labels**: Every `TextFormField` uses the `decoration: InputDecoration(labelText: ...)` which Flutter maps to screen readers automatically.
- **Focus Order**: Title -> Folder Dropdown -> Transcript Body -> Save Button.
- **Contrast**: Error messages use `#D32F2F` (Material Red 700) with a warning icon to assist color-blind users.

## 5. Framework Implementation (Flutter)
- Uses a `GlobalKey<FormState>` to trigger `.validate()` on the `Save` button press.
- Real-time save is *not* used to avoid unnecessary Isar transactions while typing.
- When saving, a new `NoteVersion` object is created to store the previous state of the transcript for the Version History feature.
