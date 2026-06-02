param(
  [string]$RepoName = "auto-research-landscape-2026",
  [string]$Owner = "",
  [switch]$Private,
  [switch]$SkipForks
)

$ErrorActionPreference = "Stop"

& "$PSScriptRoot\publish.ps1" -RepoName $RepoName -Owner $Owner -Private:$Private

if (-not $SkipForks) {
  & "$PSScriptRoot\fork-projects.ps1" -Owner $Owner
}
