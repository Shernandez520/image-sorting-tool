
param (
    [string]$sourceFolder = $(Read-Host "Enter the full path to the source image folder")
)

$portraitFolder = Join-Path $sourceFolder "1200h"
$landscapeFolder = Join-Path $sourceFolder "1200w"
$squareFolder = Join-Path $sourceFolder "Square"
$logFile = Join-Path $sourceFolder "image_sort_log.txt"

foreach ($folder in @($portraitFolder, $landscapeFolder, $squareFolder)) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }
}

Add-Type -AssemblyName System.Drawing

$portraitCount = 0
$landscapeCount = 0
$squareCount = 0

"Image Sorting Log - $(Get-Date)" | Out-File -FilePath $logFile

Get-ChildItem -Path $sourceFolder -Include *.jpg, *.jpeg, *.png, *.bmp -File -Recurse | ForEach-Object {
    try {
        $image = [System.Drawing.Image]::FromFile($_.FullName)
        $width = $image.Width
        $height = $image.Height
        $image.Dispose()

        if ($width -gt $height) {
            Move-Item $_.FullName -Destination $landscapeFolder
            "$($_.Name) -> Landscape" | Out-File -FilePath $logFile -Append
            $landscapeCount++
        } elseif ($height -gt $width) {
            Move-Item $_.FullName -Destination $portraitFolder
            "$($_.Name) -> Portrait" | Out-File -FilePath $logFile -Append
            $portraitCount++
        } else {
            Move-Item $_.FullName -Destination $squareFolder
            "$($_.Name) -> Square" | Out-File -FilePath $logFile -Append
            $squareCount++
        }
    } catch {
        "ERROR: Could not process $($_.Name)" | Out-File -FilePath $logFile -Append
    }
}

"" | Out-File -FilePath $logFile -Append
"Summary:" | Out-File -FilePath $logFile -Append
"Portrait images: $portraitCount" | Out-File -FilePath $logFile -Append
"Landscape images: $landscapeCount" | Out-File -FilePath $logFile -Append
"Square images: $squareCount" | Out-File -FilePath $logFile -Append

Write-Host "Image sorting complete. Log saved to $logFile"
Read-Host -Prompt "Press Enter to exit"
