param(
  [string]$Owner = "",
  [string]$ProjectsFile = "data/projects.json",
  [string]$ForkListFile = "data/forkable-repos.txt",
  [int]$DelaySeconds = 2
)

$ErrorActionPreference = "Stop"

$token = $env:GITHUB_TOKEN
if (-not $token) {
  $token = $env:GH_TOKEN
}

if (-not $token) {
  throw "Set GITHUB_TOKEN or GH_TOKEN before forking repositories. The token needs permission to fork public repositories."
}

$headers = @{
  Authorization = "Bearer $token"
  Accept = "application/vnd.github+json"
  "X-GitHub-Api-Version" = "2022-11-28"
  "User-Agent" = "auto-research-landscape-forker"
}

$user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers
if (-not $Owner) {
  $Owner = $user.login
}

$repoUrls = New-Object System.Collections.Generic.List[string]

if (Test-Path $ProjectsFile) {
  $projectsPath = Resolve-Path $ProjectsFile
  $projects = Get-Content -Raw $projectsPath | ConvertFrom-Json
  foreach ($project in $projects) {
    if ($project.repo_url) {
      $repoUrls.Add([string]$project.repo_url)
    }
  }
}

if (Test-Path $ForkListFile) {
  Get-Content $ForkListFile |
    Where-Object { $_ -match "^https://github\.com/[^/]+/[^/]+/?$" } |
    ForEach-Object { $repoUrls.Add($_) }
}

$repos = $repoUrls |
  Where-Object { $_ -match "^https://github\.com/[^/]+/[^/]+/?$" } |
  ForEach-Object {
    $path = $_ -replace "^https://github\.com/", ""
    $path = $path.TrimEnd("/")
    [PSCustomObject]@{
      Upstream = $path
      Url = $_
    }
  } |
  Sort-Object Upstream -Unique

$results = New-Object System.Collections.Generic.List[object]

foreach ($repo in $repos) {
  $endpoint = "https://api.github.com/repos/$($repo.Upstream)/forks"
  $bodyObject = @{}
  if ($Owner -ne $user.login) {
    $bodyObject.organization = $Owner
  }
  $body = $bodyObject | ConvertTo-Json

  Write-Host "Forking $($repo.Upstream) -> $Owner ..."
  try {
    $response = Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body $body -ContentType "application/json"
    $forkUrl = if ($response.html_url) { $response.html_url } else { "https://github.com/$Owner/$($repo.Upstream.Split('/')[1])" }
    $results.Add([PSCustomObject]@{
      upstream = $repo.Upstream
      status = "requested"
      fork_url = $forkUrl
      message = ""
    })
  } catch {
    $message = $_.Exception.Message
    $status = "failed"
    if ($message -match "422") {
      $status = "exists_or_unprocessable"
    }
    $results.Add([PSCustomObject]@{
      upstream = $repo.Upstream
      status = $status
      fork_url = "https://github.com/$Owner/$($repo.Upstream.Split('/')[1])"
      message = $message
    })
  }

  Start-Sleep -Seconds $DelaySeconds
}

$outDir = "data"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$outPath = Join-Path $outDir "fork-results.json"
$results | ConvertTo-Json -Depth 5 | Set-Content -Path $outPath -Encoding UTF8

Write-Host "Fork results written to $outPath"
$results | Format-Table -AutoSize
