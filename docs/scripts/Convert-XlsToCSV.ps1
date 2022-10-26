# this script saves each excel worksheet to a .csv file as Github doesn't support rendering .xls

param(
    [string] $File = 'Danmark-azure-security-benchmark-v3.0.xlsx',
    [string] $LocationToSave = '.\CSV'
)

$xls = Get-Item $File

$Excel = New-Object -ComObject Excel.Application
$wb = $Excel.Workbooks.Open($xls)

Push-Location
Set-Location  $LocationToSave
$path = (Get-Location).Path

foreach ($ws in $wb.Worksheets) {
    $n = [System.IO.Path]::Combine($path,($ws.name, 'csv') -join ".")
    $ws.SaveAs($n, 6)
}

$Excel.Quit()
pop-location