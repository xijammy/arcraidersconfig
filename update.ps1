# === Arc Raiders Auto Updater ===

# Where to temporarily download the files
$src = "$env:USERPROFILE\Downloads\ArcRaiders-Files"

# The Call of Duty Players folder (hidden but accessible)
$dst = "$env:LOCALAPPDATA\PioneerGame\Saved\Config\WindowsClient"

# Make sure the temporary folder exists
New-Item -ItemType Directory -Force -Path $src | Out-Null

# List of files to download (RAW links!)
$files = @(
    @{ url = "https://raw.githubusercontent.com/xijammy/arcraidersconfig/main/GameUserSettings.ini"; name = "GameUserSettings.ini" }
)

# Download each file
foreach ($f in $files) {
    $out = Join-Path $src $f.name
    Invoke-WebRequest -Uri $f.url -OutFile $out
    Write-Host "Downloaded $($f.name)"
}

# Replace files inside the Arc Raiders Config folder
Copy-Item "$src\*" $dst -Force

Write-Host "`n✔ Arc Raiders configuration files replaced successfully, you can now launch the game."