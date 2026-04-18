# Module: feature_processing

## Responsibility
The `feature_processing` module implements the rule-based intelligence for extracting highlights (Action Items/Deadlines) from raw transcripts.

## Architecture
- **Layer**: Domain/Data.
- **Processing**: Dart Isolates (`compute`) for non-blocking execution.
- **Logic**: Regex Pipeline (Pure Dart).
