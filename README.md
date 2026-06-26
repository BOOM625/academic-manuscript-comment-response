# Academic Manuscript Comment Response

A Codex skill for evaluating and replying to teacher, supervisor, reviewer, or
expert comments on academic manuscripts. It is designed for Word `.docx`
manuscripts with existing comments and preserves the original comments while
adding true threaded replies underneath them.

## What It Does

- Extracts Word comments in their visible Word order.
- Helps triage whether each comment is scientifically useful, submission-relevant,
  optional, or not recommended as written.
- Drafts direct replies to the teacher/expert comment.
- Supports Chinese replies, English replies, combined bilingual replies, or
  separate Chinese and English replies.
- Adds replies as real Word comment-thread replies instead of editing the
  original comment text.
- Verifies that original comment text is preserved and reply markers are present.

## Typical Use Cases

- "请回复老师在正文里的批注，判断是否合理，是否值得改。"
- "Add bilingual replies to all expert comments in this manuscript."
- "Evaluate reviewer-style Word comments and reply in separate Chinese and English threads."
- "Do not change the original comments; add replies under each comment."

## Installation

Copy this folder into your Codex skills directory:

```powershell
Copy-Item -Recurse . "$env:USERPROFILE\.codex\skills\academic-manuscript-comment-response"
```

Then invoke it explicitly:

```text
$academic-manuscript-comment-response
```

or ask naturally for replies to teacher/expert comments on a manuscript.

## Requirements

- Microsoft Word on Windows for true threaded Word replies.
- PowerShell for the bundled scripts.
- Codex document-reading tools, or another DOCX comment extraction method, for
  manuscript context and comment triage.

The skill can still help draft comment responses without Microsoft Word, but the
bundled script that writes true threaded replies depends on Word COM automation.

## Included Scripts

### `scripts/export_word_comments.ps1`

Exports Word comments to JSON in Word's comment collection order.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass `
  -File .\scripts\export_word_comments.ps1 `
  -InputDocx manuscript.docx `
  -OutJson comments.json
```

### `scripts/add_word_comment_replies.ps1`

Adds true Word threaded replies from a JSON reply plan.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass `
  -File .\scripts\add_word_comment_replies.ps1 `
  -InputDocx manuscript.docx `
  -RepliesJson replies.json `
  -OutDocx manuscript_with_replies.docx
```

## Reply JSON Example

Separate Chinese and English replies:

```json
[
  {
    "index": 1,
    "reply_cn": "Codex CN: 必须改。这个批注合理，因为...",
    "reply_en": "Codex EN: MUST revise. This comment is valid because..."
  }
]
```

General multi-reply format:

```json
[
  {
    "index": 1,
    "replies": [
      {"author": "Codex CN", "initials": "CN", "text": "Codex CN: ..."},
      {"author": "Codex EN", "initials": "EN", "text": "Codex EN: ..."}
    ]
  }
]
```

`index` is the Microsoft Word comment index exported by
`export_word_comments.ps1`, not the OOXML comment id.

## Verification Checklist

- Original comment texts are still present.
- Expected reply markers, such as `Codex CN:` and `Codex EN:`, are present.
- No repeated `????` replacement characters appear in the replies.
- Word opens the output `.docx`.
- Comment counts make sense: Word counts replies as comment records.

## License

MIT License. See [LICENSE](LICENSE).
