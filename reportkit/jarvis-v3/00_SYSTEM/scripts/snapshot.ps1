# Crée un snapshot horodaté d'un dossier projet, en excluant TOUJOURS livrables/
# et snapshots/ eux-mêmes (pas de copie récursive des anciens snapshots).
#
# Usage : .\snapshot.ps1 -ProjectDir "03_PROJECTS/active/MonProjet" -Name "avant refonte roadmap"

param(
    [Parameter(Mandatory = $true)][string]$ProjectDir,
    [string]$Name = "snapshot"
)

if (-not (Test-Path $ProjectDir -PathType Container)) {
    Write-Error "Dossier introuvable : $ProjectDir"
    exit 1
}

$NameSlug = ($Name -replace '[ /]', '_')
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$Dest = Join-Path $ProjectDir "snapshots\${Timestamp}_${NameSlug}"
New-Item -ItemType Directory -Path $Dest -Force | Out-Null

Get-ChildItem -Path $ProjectDir -Force |
    Where-Object { $_.Name -ne "livrables" -and $_.Name -ne "snapshots" } |
    ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $Dest -Recurse -Force
    }

Write-Output "Snapshot créé : $Dest"
