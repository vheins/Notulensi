# ADR-002: Local-Only AI and Speech Processing

**Date**: 2025-05-20
**Status**: Accepted

## Context
The core value proposition of Notulensi is 100% privacy. Traditional Speech-to-Text (STT) and NLP services often require cloud processing (OpenAI, Google Cloud, AWS), which violates our privacy mandate.

## Decision
All audio processing, transcription, and information extraction (Action Items, Deadlines) MUST occur 100% on-device.

### Rationale
- **Privacy**: No meeting content ever leaves the user's physical device.
- **Offline Reliability**: The app works in secure locations or planes without internet.
- **Zero Latency**: Eliminates network round-trips for data processing.

## Implementation Strategy
- **STT**: Use `speech_to_text` (relying on OS-level offline packs) or `vosk_flutter` for local model hosting.
- **NLP**: Information extraction will use a deterministic **Rule-Based Engine (Regex)** and Keyword matching instead of LLMs to maintain 100% offline status and low CPU usage.

## Consequences
### Positive
- Absolute privacy guarantee for enterprise/personal users.
- No recurring API costs or token usage.

### Negative
- Lower accuracy compared to massive cloud LLMs (e.g., GPT-4).
- Deterministic extraction may miss nuanced context that an LLM would catch.
- Larger initial download if Vosk models are bundled.

## Alternatives Considered
- **OpenAI Whisper API**: Rejected (Cloud-based).
- **On-device Llama (MLC)**: Considered but rejected for Phase 1 due to high RAM consumption and battery drain on older mobile devices.
