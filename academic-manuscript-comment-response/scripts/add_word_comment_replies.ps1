param(
    [Parameter(Mandatory = $true)]
    [string]$InputDocx,

    [Parameter(Mandatory = $true)]
    [string]$RepliesJson,

    [Parameter(Mandatory = $true)]
    [string]$OutDocx
)

$ErrorActionPreference = "Stop"

Copy-Item -LiteralPath $InputDocx -Destination $OutDocx -Force
$items = Get-Content -LiteralPath $RepliesJson -Raw -Encoding UTF8 | ConvertFrom-Json

$word = $null
$doc = $null
try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $word.DisplayAlerts = 0

    $doc = $word.Documents.Open($OutDocx, $false, $false)
    $initialCount = [int]$doc.Comments.Count

    $ordered = @($items | Sort-Object {[int]$_.index} -Descending)
    $added = 0
    foreach ($item in $ordered) {
        $idx = [int]$item.index
        if ($idx -lt 1 -or $idx -gt $initialCount) {
            throw "Reply target index $idx is outside original comment range 1..$initialCount."
        }

        $comment = $doc.Comments.Item($idx)
        $replies = @()
        if ($item.replies -ne $null) {
            $replies = @($item.replies)
        }
        elseif ($item.reply -ne $null) {
            $replies = @([PSCustomObject]@{
                author = "Codex"
                initials = "CX"
                text = [string]$item.reply
            })
        }
        elseif ($item.reply_cn -ne $null -or $item.reply_en -ne $null) {
            if ($item.reply_cn -ne $null) {
                $replies += [PSCustomObject]@{
                    author = "Codex CN"
                    initials = "CN"
                    text = [string]$item.reply_cn
                }
            }
            if ($item.reply_en -ne $null) {
                $replies += [PSCustomObject]@{
                    author = "Codex EN"
                    initials = "EN"
                    text = [string]$item.reply_en
                }
            }
        }

        foreach ($reply in $replies) {
            $word.UserName = [string]$reply.author
            $word.UserInitials = [string]$reply.initials
            [void]$comment.Replies.Add($comment.Range, [string]$reply.text)
            $added += 1
        }
    }

    $doc.Save()
    $finalCount = [int]$doc.Comments.Count
    $doc.Close($false)
    $word.Quit()
    Write-Output "[OK] wrote $OutDocx (original_comments=$initialCount replies_added=$added total_comment_records=$finalCount)"
}
catch {
    if ($doc -ne $null) {
        $doc.Close($false)
    }
    if ($word -ne $null) {
        $word.Quit()
    }
    throw
}
