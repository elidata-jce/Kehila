<#
.SYNOPSIS
  install-git-windows.ps1
.DESCRIPTION
  Installs Git on Windows using winget or Chocolatey (if available), configures git identity,
  optionally generates an SSH key and prints the public key for GitHub.
.PARAMETER Name
  Full name for git user.name
.PARAMETER Email
  Email for git user.email
.PARAMETER Ssh
  Switch to generate SSH keypair (~/.ssh/id_ed25519)
.EXAMPLE
  .\install-git-windows.ps1 -Name "Jane Doe" -Email "jane@example.com" -Ssh
#>

param(
  [string]$Name,
  [string]$Email,
  [switch]$Ssh
)

function Show-Usage {
  Write-Host "Usage: .\install-git-windows.ps1 -Name 'Full Name' -Email 'email' [-Ssh]"
  Write-Host ""
  Write-Host "Options:"
  Write-Host "  -Name   Full name to set as git user.name"
  Write-Host "  -Email  Email to set as git user.email"
  Write-Host "  -Ssh    Generate an ed25519 SSH keypair (~/.ssh/id_ed25519) and print the public key"
  Write-Host ""
  Write-Host "Examples:"
  Write-Host "  .\install-git-windows.ps1 -Name 'Jane Doe' -Email 'jane@example.com' -Ssh"
  Write-Host "  .\install-git-windows.ps1 -Ssh"
  Write-Host ""
  Write-Host "If you run with no parameters this help is shown and the script exits."
}

# If no arguments provided, show usage and exit
if ($PSBoundParameters.Count -eq 0) {
  Show-Usage
  exit 1
}
function Require-Admin {
  $current = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = New-Object Security.Principal.WindowsPrincipal($current)
  if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "Please run this script from an elevated PowerShell (Run as Administrator)."
    exit 1
  }
}

# detect whether running elevated only for package installs; winget may fail without elevation
Write-Host "Detecting package managers..."
$winget = Get-Command winget -ErrorAction SilentlyContinue
$choco = Get-Command choco -ErrorAction SilentlyContinue

if ($winget) {
  Write-Host "Installing Git with winget..."
  # Accept agreements to avoid interactive prompt
  winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
} elseif ($choco) {
  Write-Host "Installing Git with Chocolatey..."
  if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Error "Chocolatey install requires an elevated shell. Re-run in an Administrator PowerShell."
    exit 1
  }
  choco install git -y
} else {
  Write-Warning "Neither winget nor chocolatey found. Please install Git for Windows manually from https://git-scm.com/download/win and re-run this script."
  exit 1
}

# Verify installation
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Error "Git not found after installation. Ensure Git was installed and is in PATH, then re-run."
  exit 1
}

git --version

# Prompt for name/email if not provided
if (-not $Name) {
  $Name = Read-Host "Enter git user.name (Full Name) or press Enter to skip"
}
if (-not $Email) {
  $Email = Read-Host "Enter git user.email (you@example.com) or press Enter to skip"
}

if ($Name) {
  git config --global user.name "$Name"
  Write-Host "Set git user.name -> $Name"
}
if ($Email) {
  git config --global user.email "$Email"
  Write-Host "Set git user.email -> $Email"
}

# sensible defaults for line endings on Windows
git config --global core.autocrlf true
git config --global color.ui auto

if ($Ssh) {
  $sshDir = Join-Path $env:USERPROFILE ".ssh"
  if (-not (Test-Path $sshDir)) { New-Item -ItemType Directory -Path $sshDir | Out-Null }
  $keyPath = Join-Path $sshDir "id_ed25519"
  if (Test-Path $keyPath) {
    Write-Host "SSH key already exists at $keyPath. Skipping generation."
  } else {
    Write-Host "Generating ed25519 SSH key (no passphrase)..."
    # Use ssh-keygen that comes with Git for Windows or Windows OpenSSH
    $sshgen = Get-Command ssh-keygen -ErrorAction SilentlyContinue
    if (-not $sshgen) {
      Write-Error "ssh-keygen not found. Please ensure OpenSSH or Git Bash is installed. You can generate a key manually."
      exit 1
    }
    & ssh-keygen -t ed25519 -C ($Email -or "git@localhost") -f $keyPath -N "" | Out-Null

    # Start ssh-agent service and add key
    Write-Host "Ensuring ssh-agent service is running..."
    if (Get-Service -Name ssh-agent -ErrorAction SilentlyContinue) {
      Set-Service -Name ssh-agent -StartupType Automatic
      Start-Service ssh-agent -ErrorAction SilentlyContinue
    }

    & ssh-add $keyPath
  }

  Write-Host ""
  Write-Host "Public key (copy/paste into GitHub -> Settings -> SSH and GPG keys -> New SSH key):"
  Write-Host "--------------------------------------------------------------------------------"
  Get-Content "${keyPath}.pub"
  Write-Host "--------------------------------------------------------------------------------"
  Write-Host "You can copy to clipboard with: Get-Content ${keyPath}.pub | Set-Clipboard"
}

Write-Host ""
Write-Host "Done. Useful next steps:"
Write-Host "  git --version"
Write-Host "  git config --list --show-origin"
Write-Host "  Open VS Code and open your project folder (VS Code will use the system Git)."
Write-Host "If you generated an SSH key, add the public key to GitHub and test:"
Write-Host "  ssh -T git@github.com"