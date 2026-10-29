<#
.SYNOPSIS
  Installs, tests and removes Zyvor Retail on Windows through WSL2.

.DESCRIPTION
  The image is a Linux container, so on Windows Zyvor Retail runs inside WSL2. This script checks that WSL2 and a
  container engine are there, then runs the same checksum-verified get.sh that Linux and macOS use, inside your WSL
  distribution. If WSL or a container engine is missing it asks before setting them up. Installing WSL needs your
  administrator approval and a restart of Windows, after which you run the same command again. It never restarts
  Windows for you and never writes outside the WSL home's ~/.zyvor-retail.

  Not yet verified on a real Windows PC. The script is tested with simulated Windows calls only.

.EXAMPLE
  & ([scriptblock]::Create((irm https://github.com/zyvorai/zyvor-retail-site/releases/latest/download/get.ps1))) up --demo

.EXAMPLE
  ... get.ps1 test
  ... get.ps1 uninstall
#>
[CmdletBinding(PositionalBinding = $false)]
param(
  [switch]$Yes,
  [switch]$InstallPodman,
  [switch]$DryRun,
  [string]$Distro = '',
  [Parameter(ValueFromRemainingArguments = $true)][string[]]$InstallArgs
)

Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

function Say {
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Interactive installer')]
  param([string]$Message)
  Write-Host $Message
}
function Exit-Install([string]$Message) { throw "Zyvor Retail install: $Message" }

function Get-WindowsBuild { return [int][Environment]::OSVersion.Version.Build }
function Test-WslPresent { return [bool](Get-Command wsl.exe -ErrorAction SilentlyContinue) }
function Invoke-WslRaw([string[]]$WslArgs) {
  $out = & wsl.exe @WslArgs 2>&1 | ForEach-Object { ([string]$_) -replace "`0", '' }
  return [pscustomobject]@{ Code = $LASTEXITCODE; Lines = @($out) }
}
function Open-Url([string]$Url) { Start-Process $Url }
function Confirm-Step([string]$Question, [switch]$AutoYes) {
  if ($AutoYes) { return $true }
  $a = Read-Host "$Question [Y/n]"
  return ($a -eq '' -or $a -match '^(y|yes)$')
}
function Invoke-Elevated([string]$Exe, [string[]]$ArgList) {
  $p = Start-Process -FilePath $Exe -ArgumentList $ArgList -Verb RunAs -Wait -PassThru
  return [int]$p.ExitCode
}

function ConvertFrom-WslList([string[]]$Lines) {
  $rows = @()
  foreach ($l in $Lines) {
    if ($l -match '^\s*(\*?)\s*(\S+)\s+(Running|Stopped|Installing|Uninstalling|Converting)\s+(\d)\s*$') {
      $rows += [pscustomobject]@{ Name = $Matches[2]; Default = ($Matches[1] -eq '*'); State = $Matches[3]; Version = [int]$Matches[4] }
    }
  }
  return $rows
}

function Select-Distro($Rows, [string]$Wanted) {
  $usable = @($Rows | Where-Object { $_.Name -notmatch '^docker-desktop' })
  if ($usable.Count -eq 0) {
    Exit-Install "WSL has no Linux distribution yet. In an administrator PowerShell run: wsl --install -d Ubuntu  (then restart Windows and run this again)."
  }
  if ($Wanted) {
    $d = @($usable | Where-Object { $_.Name -eq $Wanted })
    if ($d.Count -eq 0) { Exit-Install "no WSL distribution called '$Wanted' (have: $(($usable | ForEach-Object { $_.Name }) -join ', '))." }
    $pick = $d[0]
  } else {
    $def = @($usable | Where-Object { $_.Default })
    if ($def.Count -gt 0) { $pick = $def[0] } else { $pick = $usable[0] }
  }
  return $pick
}

function Assert-SafeArgument([string[]]$List) {
  foreach ($a in $List) {
    if ($a -notmatch '^[A-Za-z0-9._:/=@,+-]+$') { Exit-Install "unsupported character in argument '$a' (use letters, digits and . _ : / = @ , + - only)." }
  }
}

function Invoke-Retail {
  [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Interactive installer')]
  [CmdletBinding()]
  param([switch]$DryRun, [switch]$InstallPodman, [switch]$Yes, [string]$Distro = '', [string[]]$InstallArgs = @())
  $base = $env:RETAIL_RELEASE_BASE
  if (-not $base) { $base = 'https://github.com/zyvorai/zyvor-retail-site/releases/latest/download' }
  if ($base -notmatch '^https://[A-Za-z0-9._:/-]+$') { Exit-Install "RETAIL_RELEASE_BASE must be a plain https URL." }
  if ($Distro -and $Distro -notmatch '^[A-Za-z0-9._-]+$') { Exit-Install "'$Distro' is not a valid WSL distribution name." }
  $list = @($InstallArgs | Where-Object { $_ })
  if ($list.Count -eq 0) { $list = @('up', '--demo') }
  Assert-SafeArgument $list
  $argText = $list -join ' '

  if ($DryRun) {
    Say "[dry-run] would check: Windows build 19041 or later, wsl.exe, a WSL 2 distribution, a container engine plus curl and openssl inside it"
    if ($InstallPodman) { Say "[dry-run] would install podman, podman-compose, curl and openssl in WSL if missing (Debian/Ubuntu only)" }
    Say "[dry-run] would run in WSL: curl -fsSL $base/get.sh | sh -s -- $argText"
    if ($list[0] -eq 'up') { Say "[dry-run] would then open the address the installer prints" }
    return
  }

  if ((Get-WindowsBuild) -lt 19041) { Exit-Install "needs Windows 10 version 2004 (build 19041) or Windows 11 for WSL 2." }
  if (-not (Test-WslPresent)) { Exit-Install "WSL is not installed. In an administrator PowerShell run: wsl --install -d Ubuntu  (then restart Windows and run this again)." }

  $list1 = Invoke-WslRaw @('-l', '-v')
  $rows = @()
  if ($list1.Code -eq 0) { $rows = @(ConvertFrom-WslList $list1.Lines) }
  $usable = @($rows | Where-Object { $_.Name -notmatch '^docker-desktop' })
  if ($usable.Count -eq 0) {
    if (-not (Confirm-Step 'WSL 2 with Ubuntu is not set up on this PC. Install it now? (Windows asks for administrator approval, and you restart Windows afterwards)' -AutoYes:$Yes)) {
      Exit-Install "WSL 2 is required. In an administrator PowerShell run: wsl --install -d Ubuntu  (then restart Windows and run this again)."
    }
    $code = Invoke-Elevated 'wsl.exe' @('--install', '-d', 'Ubuntu')
    if ($code -ne 0) { Exit-Install "wsl --install exited with code $code. Run it yourself in an administrator PowerShell: wsl --install -d Ubuntu" }
    Say 'WSL and Ubuntu are installed. Restart Windows, open Ubuntu once from the Start menu to create your Linux user, then run the same command again.'
    return
  }
  $d = Select-Distro $rows $Distro
  if ($d.Version -ne 2) {
    if (-not (Confirm-Step "'$($d.Name)' runs WSL 1, but Zyvor Retail needs WSL 2. Convert it now? (a few minutes)" -AutoYes:$Yes)) {
      Exit-Install "'$($d.Name)' runs WSL 1; Zyvor Retail needs WSL 2. Run: wsl --set-version $($d.Name) 2"
    }
    $conv = Invoke-WslRaw @('--set-version', $d.Name, '2')
    if ($conv.Code -ne 0) { Exit-Install "converting '$($d.Name)' to WSL 2 failed: $(($conv.Lines | Select-Object -Last 3) -join ' ')" }
  }
  $name = $d.Name
  Say "Using WSL distribution '$name'."

  $probe = 'command -v curl >/dev/null 2>&1 && command -v openssl >/dev/null 2>&1 && { docker compose version >/dev/null 2>&1 || { command -v podman >/dev/null 2>&1 && command -v podman-compose >/dev/null 2>&1; }; }'
  $have = Invoke-WslRaw @('-d', $name, '-e', 'sh', '-c', $probe)
  if ($have.Code -ne 0) {
    if (-not ($InstallPodman -or (Confirm-Step "'$name' has no container engine (or curl/openssl). Install podman inside it now? (Debian/Ubuntu; a minute or two)" -AutoYes:$Yes))) {
      Exit-Install ("'$name' is missing curl, openssl, or a container engine. Either turn on Docker Desktop > Settings > Resources > WSL integration for '$name', " +
        "or run this again with -InstallPodman (Debian/Ubuntu: installs podman, podman-compose, curl and openssl inside WSL).")
    }
    $os = Invoke-WslRaw @('-d', $name, '-e', 'sh', '-c', '. /etc/os-release; echo "$ID $ID_LIKE"')
    if (($os.Lines -join ' ') -notmatch 'debian|ubuntu') { Exit-Install "-InstallPodman supports Debian and Ubuntu only; install podman, podman-compose, curl and openssl in '$name' yourself." }
    Say "Installing podman, podman-compose, curl and openssl in '$name' (needs a minute)..."
    $inst = Invoke-WslRaw @('-d', $name, '-u', 'root', '-e', 'sh', '-c', 'apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq podman podman-compose curl openssl')
    if ($inst.Code -ne 0) { Exit-Install "installing the packages failed: $(($inst.Lines | Select-Object -Last 5) -join ' ')" }
  }

  Say "Running: curl -fsSL $base/get.sh | sh -s -- $argText"
  $captured = New-Object System.Collections.Generic.List[string]
  & wsl.exe -d $name -e sh -c "curl -fsSL '$base/get.sh' | sh -s -- $argText" 2>&1 | ForEach-Object {
    $line = ([string]$_) -replace "`0", ''
    Write-Host $line
    $captured.Add($line)
  }
  $code = $LASTEXITCODE
  if ($code -ne 0) { Exit-Install "the installer in WSL exited with code $code (see the messages above)." }

  if ($list[0] -eq 'up') {
    $url = $null
    foreach ($l in $captured) { if ($l -match 'is running:\s+(https?://\S+)') { $url = $Matches[1] } }
    if ($url) {
      Say "Opening $url"
      Open-Url $url
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') { Invoke-Retail -DryRun:$DryRun -InstallPodman:$InstallPodman -Yes:$Yes -Distro $Distro -InstallArgs $InstallArgs }
