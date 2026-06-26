---
name: academic-manuscript-comment-response
description: Reply to teacher, supervisor, reviewer, or expert comments on academic manuscripts, especially Word DOCX comments. Use when the user asks to evaluate whether academic manuscript comments are reasonable or worth addressing, draft academic replies to comments, add Chinese/English or bilingual replies, respond to 老师批注, 专家批注, 审稿式批注, Word comments, manuscript comments, or preserve original comments while adding threaded replies.
---

# Academic Manuscript Comment Response

Use this skill to triage academic manuscript comments and write responses as
true Word comment replies. The core rule is: preserve the teacher/expert's
original comments and add reply-thread comments underneath them.

## Core Stance

- Treat comments as manuscript-improvement signals, not as commands to obey blindly.
- Judge each comment on whether it improves evidence, logic, clarity, submission
  readiness, or reviewer defensibility.
- Distinguish valuable scientific edits from low-value wording churn.
- Never overwrite or append into the teacher/expert's original comment text unless
  the user explicitly asks for that format.
- Prefer true Word threaded replies over new standalone comments.
- For bilingual output, ask or infer whether the user wants:
  - one combined reply containing both languages, or
  - separate Chinese and English replies. If unclear, use separate replies.

## Workflow

1. Read the manuscript and comments.
   - For DOCX, use the Documents skill if available.
   - Use `scripts/export_word_comments.ps1` when Microsoft Word is available and
     exact threaded-comment structure matters.
   - Use DOCX XML extraction only for triage when Word is unavailable.

2. Build a comment tracker.
   - Preserve comment order and the original comment text.
   - Record whether a comment is top-level or already a reply.
   - Keep enough manuscript context around each anchor to evaluate the comment.

3. Triage each comment.
   - Use `references/triage-rubric.md` for categories and wording.
   - Decide: must revise, revise, optional, or not worth changing.
   - Explain why the comment is or is not useful for submission.
   - Give a concrete revision plan when the comment is worth addressing.

4. Draft replies.
   - Replies should answer the teacher/expert directly and professionally.
   - For Chinese users, default to Chinese replies unless the user asks for English
     or bilingual output.
   - For bilingual/separate replies, create two reply texts per comment:
     `Codex CN: ...` and `Codex EN: ...`.
   - Do not claim that manuscript changes were already made unless they were.
   - Use action language such as "must revise", "revise", "optional", or "not
     recommended" plus a concrete next step.

5. Write replies into DOCX.
   - Prefer `scripts/add_word_comment_replies.ps1`.
   - Generate the replies JSON with Unicode escapes (`ensure_ascii=true`) or write
     it as UTF-8 from Python, not through a lossy console pipeline.
   - Loop targets in descending Word comment index order so original comment
     indexes remain stable while replies are added.

6. Verify.
   - Confirm original comment texts still exist unchanged.
   - Confirm the expected number of `Codex CN`, `Codex EN`, or other reply markers.
   - Confirm no literal `?` replacement characters appear in Codex replies.
   - Open the DOCX with Word COM when available and report comment/reply counts.
   - Rendering is optional for comment-only edits; Word comments often do not
     render in headless PDF exports.

## Reply JSON Format

Use this format for separate bilingual replies:

```json
[
  {
    "index": 1,
    "replies": [
      {"author": "Codex CN", "initials": "CN", "text": "Codex CN: 必须改。..."},
      {"author": "Codex EN", "initials": "EN", "text": "Codex EN: MUST revise. ..."}
    ]
  }
]
```

Use this format for a single reply:

```json
[
  {
    "index": 1,
    "replies": [
      {"author": "Codex", "initials": "CX", "text": "Codex reply: ..."}
    ]
  }
]
```

`index` is the Microsoft Word comment collection index from
`scripts/export_word_comments.ps1`, not the OOXML comment id.

## Word Comment Caveats

- Word may count replies as comments. A document with 22 original comments and
  two replies per comment can report 66 total comment records.
- Some source documents already contain threaded comments. Replying to a comment
  that is itself a reply may attach the new reply to the thread parent, depending
  on Word behavior. Preserve the visible thread and verify counts.
- OOXML comment ids can change after Word saves the file. Verify by text presence
  and Word comment indexes, not by XML id alone.

## Resources

- `scripts/export_word_comments.ps1`: export Word comments in Word collection
  order, including text, author, reply status, and reply counts.
- `scripts/add_word_comment_replies.ps1`: add true Word threaded replies from a
  JSON plan while preserving original comments.
- `references/triage-rubric.md`: academic comment triage categories and reply
  templates.
- `references/word-threaded-comments.md`: details for Word threaded comments,
  encoding, and verification.
