$targetVmSize = "Standard_B2pts_v2"

$dataPath = Join-Path $PSScriptRoot "data"
$resultPath = Join-Path $PSScriptRoot "result.json"

$regions = @()

Get-ChildItem -Path $dataPath -Filter "*.json" | ForEach-Object {

    $file = $_

    $region = $file.BaseName

    $vmSizes = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    $vm = $vmSizes | Where-Object {
        $_.name -eq $targetVmSize
    }

    if ($null -ne $vm) {
        $regions += $region
    }
}

$regions | ConvertTo-Json | Set-Content -Path $resultPath