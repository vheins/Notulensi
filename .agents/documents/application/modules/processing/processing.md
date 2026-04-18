# Feature: Processing

## Key Patterns
- **Action Item**: `\b(I|we)\s+(will|shall|must|need to)\s+([^.?!]+)`
- **Deadline**: `\b(by|on)\s+(Monday|Tuesday|...|tomorrow)\b`

## Workflows
- **Extraction Trigger**: Fires automatically when a recording stops.
- **Context Parsing**: Identifies sentence boundaries around matched keywords.
- **Storage Update**: Updates the `MeetingNote` record with new links to `ActionItem` and `Deadline` collections.
