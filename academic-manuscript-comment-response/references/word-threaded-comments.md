# Word Threaded Comment Workflow

Use this reference when the deliverable is a DOCX with replies to existing
teacher/expert comments.

## Preferred Path

1. Export comments with `scripts/export_word_comments.ps1`.
2. Draft a JSON reply plan keyed by Word comment `index`.
3. Add replies with `scripts/add_word_comment_replies.ps1`.
4. Verify counts and original-comment preservation.

## Why Word COM

Word's modern threaded comments include relationships among:

- `word/comments.xml`
- `word/commentsExtended.xml`
- `word/commentsIds.xml`
- document anchors

Manual OOXML edits are possible but fragile. If Microsoft Word is installed,
use Word COM and `comment.Replies.Add(comment.Range, text)` so Word maintains
the thread metadata.

## Encoding Rules

- Do not pipe literal Chinese text through a legacy PowerShell console.
- Prefer JSON produced by Python with `ensure_ascii=true`, or save JSON as UTF-8
  from a real file.
- In verification, search Codex reply texts for literal `?`. A normal question
  mark can be valid, but repeated `????` means text was corrupted before Word
  received it.

## Verification Checklist

- Original comment count before adding replies is known.
- Output file opens in Word.
- New total comment record count equals original plus expected replies, allowing
  for pre-existing threaded replies.
- All original comment texts are still present.
- Each expected reply marker is present, for example `Codex CN:` and `Codex EN:`.
- Codex reply text contains no replacement-question-mark corruption.
- Do not rely on OOXML comment ids after Word saves; ids can be rewritten.
