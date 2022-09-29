[CmdletBinding()]
param ()

do {
    $n = (New-Guid).Guid.Replace("-", "").Substring(0, 24)
}
while ($n[0] -notmatch "[a-f]")

$n
