# Academic Comment Triage Rubric

Use this rubric to decide whether a teacher/expert comment is worth addressing.

## Categories

### Must Revise

Use when the comment exposes a submission-risk issue:

- missing data, incomplete placeholder, or unsubstantiated quantitative claim
- weak evidence chain for a mechanism or conclusion
- unsupported novelty such as "first" or "for the first time"
- unclear methods, parameterization, uncertainty, statistics, or model logic
- figure/table traceability problems that block verification

Reply pattern:

```text
Codex CN: 必须改。这个批注合理，因为[reason]。建议[concrete revision].
Codex EN: MUST revise. This comment is valid because [reason]. Suggested revision: [concrete revision].
```

### Revise

Use when the comment improves clarity or defensibility but is not central to the
main claim:

- add a citation
- define a technical term
- specify where a ratio, fraction, model, or figure value comes from
- soften a claim that is mostly supported but phrased too strongly

Reply pattern:

```text
Codex CN: 建议改。该修改能提升可读性/可追踪性。建议[concrete revision].
Codex EN: REVISE. This improves readability/traceability. Suggested revision: [concrete revision].
```

### Optional

Use when the comment is reasonable but low priority:

- style preference that does not affect meaning
- extra example that may lengthen an already clear section
- wording improvement with little submission impact

Reply pattern:

```text
Codex CN: 可选修改。该建议有一定帮助，但不是投稿风险点。若篇幅允许，可[revision]; 否则可不优先处理。
Codex EN: OPTIONAL. This may help but is not a submission-risk issue. If space allows, [revision]; otherwise it can be deprioritized.
```

### Not Recommended

Use sparingly, when a comment would weaken the manuscript or create unsupported
claims:

- asks for a claim the data cannot support
- moves the argument away from the paper's evidence
- duplicates material already clear in the manuscript

Reply pattern:

```text
Codex CN: 不建议按原意见直接改。原因是[reason]。更稳妥的处理是[alternative].
Codex EN: NOT RECOMMENDED as written. The reason is [reason]. A safer approach is [alternative].
```

## Evidence Discipline

- Do not invent data, citations, line numbers, figures, tables, p-values, or
  experiments.
- If data are missing, say what data are needed.
- If a claim is too strong, recommend softening verbs: confirm -> suggest,
  demonstrate -> indicate, prove -> support.
- If a comment reveals reader confusion, treat it as a manuscript clarity issue
  first.

## Common Academic Reply Moves

- Add quantitative support: ratios, fractions, yield values, uncertainty, or
  sensitivity analysis.
- Add traceability: "calculated from Table Sx", "shown in Fig. Sy", or "defined
  in Text Sz".
- Separate observation from interpretation.
- Move speculative mechanisms into Discussion or SI.
- Replace broad labels with concrete features.
- Change "first" to "to our knowledge" unless novelty has been verified.
