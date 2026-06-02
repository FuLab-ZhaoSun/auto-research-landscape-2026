param(
  [string]$RepoName = "auto-research-landscape-2026",
  [string]$Owner = "",
  [switch]$Private
)

$ErrorActionPreference = "Stop"

$token = $env:GITHUB_TOKEN
if (-not $token) {
  $token = $env:GH_TOKEN
}

if (-not $token) {
  throw "Set GITHUB_TOKEN or GH_TOKEN before publishing. The token needs repo creation and push permissions."
}

$headers = @{
  Authorization = "Bearer $token"
  Accept = "application/vnd.github+json"
  "X-GitHub-Api-Version" = "2022-11-28"
  "User-Agent" = "auto-research-landscape-publish"
}

$user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers
if (-not $Owner) {
  $Owner = $user.login
}

$body = @{
  name = $RepoName
  description = "Landscape survey of automated research, AI scientist, and automated paper writing projects."
  private = [bool]$Private
  auto_init = $false
} | ConvertTo-Json

if ($Owner -eq $user.login) {
  $createUrl = "https://api.github.com/user/repos"
} else {
  $createUrl = "https://api.github.com/orgs/$Owner/repos"
}

try {
  Invoke-RestMethod -Uri $createUrl -Method Post -Headers $headers -Body $body -ContentType "application/json" | Out-Null
  Write-Host "Created GitHub repository: $Owner/$RepoName"
} catch {
  $message = $_.Exception.Message
  if ($message -notmatch "422") {
    throw
  }
  Write-Host "Repository may already exist: $Owner/$RepoName"
}

$remoteUrl = "https://github.com/$Owner/$RepoName.git"
$remoteExists = (git remote) -contains "origin"
if ($remoteExists) {
  git remote set-url origin $remoteUrl
} else {
  git remote add origin $remoteUrl
}

$basic = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("x-access-token:$token"))
git -c "http.https://github.com/.extraheader=AUTHORIZATION: basic $basic" push -u origin main

Write-Host "Published: https://github.com/$Owner/$RepoName"
