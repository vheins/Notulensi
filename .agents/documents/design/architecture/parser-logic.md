# Rule-based Processing Logic: Notulensi

The extraction of Action Items and Deadlines is performed 100% offline using a rule-based engine.

## 1. Extraction Pipeline
The pipeline runs immediately after a recording session ends or when a note is manually edited.

1. **Input**: Raw Transcript String.
2. **Preprocessing**: Normalization (lowercase, removing redundant whitespace).
3. **Keyword Matching**: Identifying sentences containing target trigger phrases.
4. **Context Capture**: Extracting the sentence/phrase following the trigger.
5. **Deduplication**: Ensuring the same item isn't extracted twice.
6. **Output**: List of `ActionItem` and `Deadline` objects.

## 2. Regex Patterns

### 2.1 Action Items
Trigger phrases focus on commitment and necessity.

- **Pattern 1 (Commitment)**: `\b(I|we)\s+(will|shall|must|need to)\s+([^.?!]+)`
- **Pattern 2 (Explicit Label)**: `\b(action item|task):\s+([^.?!]+)`
- **Pattern 3 (Directives)**: `\b(remember to|don't forget to)\s+([^.?!]+)`

### 2.2 Deadlines
Focuses on temporal markers.

- **Pattern 1 (Relative)**: `\b(by|on)\s+(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday|tomorrow|next week)\b`
- **Pattern 2 (Specific Date)**: `\b(by|on)\s+([A-Z][a-z]{2,8})\s+(\d{1,2})(?:st|nd|rd|th)?`
- **Pattern 3 (Due Date)**: `\b(due|deadline)\s+(?:is|on|by)?\s+([^.?!]+)`

## 3. Post-Processing Logic
- **Sentence Boundaries**: Rules only capture up to the next sentence terminator (`.`, `!`, `?`) to keep highlights concise.
- **Confidence Scoring (Internal)**:
  - If a sentence matches multiple patterns, it is prioritized.
  - "Explicit Labels" have the highest priority.

## 4. Performance Considerations
- **Non-Blocking**: Processing is executed on a separate background isolate using `compute()` in Flutter to prevent frame drops on the main UI thread.
- **Memory Efficiency**: Since it uses standard Dart Regex, memory overhead is negligible compared to an LLM-based approach.
