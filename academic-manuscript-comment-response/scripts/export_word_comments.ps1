param(
    [Parameter(Mandatory = $true)]
    [string]$InputDocx,

    [Parameter(Mandatory = $true)]
    [string]$OutJson
)

$ErrorActionPreference = "Stop"

$word = $null
$doc = $null
try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $word.DisplayAlerts = 0

    $doc = $word.Documents.Open($InputDocx, $false, $true)
    $items = @()
    for ($i = 1; $i -le $doc.Comments.Count; $i++) {
        $comment = $doc.Comments.Item($i)
        $isReply = $false
        $ancestorText = ""
        try {
            $ancestor = $comment.Ancestor
            if ($ancestor -ne $null) {
                $isReply = $true
                $ancestorText = [string]$ancestor.Range.Text
            }
        }
        catch {
            $isReply = $false
        }

        $items += [PSCustomObject]@{
            index = $i
            author = [string]$comment.Author
            initials = [string]$comment.Initial
            text = [string]$comment.Range.Text
            is_reply = $isReply
            replies_count = [int]$comment.Replies.Count
            ancestor_text = $ancestorText
        }
    }

    $doc.Close($false)
    $word.Quit()

    $items | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $OutJson -Encoding UTF8
    Write-Output "[OK] exported $($items.Count) comments to $OutJson"
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
