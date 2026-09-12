# Restaure un dossier projet à partir d'un snapshot existant.
# - Sauvegarde d'abord l'état courant (hors livrables/ et snapshots/) dans
#   _versions/pre-rollback_<timestamp>/.
# - livrables/ n'est JAMAIS touché par cette opération.
#
# Usage : .\rollback.ps1 -ProjectDir "03_PROJECTS/active/MonProjet" -SnapshotName "20260702_113000_avant_refonte"

param(
    [Parameter(Mandatory = $true)][string]$ProjectDir,
    [Parameter(Mandatory = $true)][string]$SnapshotName
)

$SnapshotDir = Join-Path $ProjectDir "snapshots\$SnapshotName"
if (-not (Test-Path $SnapshotDir -PathType Container)) {
    Write-Error "Snapshot introuvable : $SnapshotDir"
    Write-Output "Snapshots disponibles :"
    Get-ChildItem (Join-Path $ProjectDir "snapshots") -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
    exit 1
}

$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$PreRollbackDir = Join-Path $ProjectDir "_versions\pre-rollback_$Timestamp"
New-Item -ItemType Directory -Path $PreRollbackDir -Force | Out-Null

Get-ChildItem -Path $ProjectDir -Force |
    Where-Object { $_.Name -notin @("livrables", "snapshots", "_versions") } |
    ForEach-Object { Copy-Item -Path $_.FullName -Destination $PreRollbackDir -Recurse -Force }

Write-Output "État courant sauvegardé dans : $PreRollbackDir"

Get-ChildItem -Path $SnapshotDir -Force |
    Where-Object { $_.Name -notin @("livrables", "snapshots") } |
    ForEach-Object { Copy-Item -Path $_.FullName -Destination $ProjectDir -Recurse -Force }

Write-Output "Projet restauré depuis : $SnapshotDir"
