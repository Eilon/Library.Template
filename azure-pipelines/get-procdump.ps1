<#
.SYNOPSIS
    Gets the path to the procdump.exe tool, installing it if necessary.
#>
Param(
)

$NuGetVersion = '0.0.1'
$toolsPath = & "$PSScriptRoot\Get-TempToolsPath.ps1"
if (!(Test-Path $toolsPath)) { $null = mkdir $toolsPath }

$procdumpPath = Join-Path $toolsPath "ProcDump.$NuGetVersion/bin/procdump.exe"

if (!(Test-Path $procdumpPath)) {
    Write-Host "Downloading procdump $NuGetVersion..." -ForegroundColor Yellow
    & (& .\azure-pipelines\Get-NuGetTool.ps1) install ProcDump -version $NuGetVersion -PackageSaveMode nuspec -OutputDirectory $toolsPath -Source https://api.nuget.org/v3/index.json | Out-Null
}

return (Resolve-Path $procdumpPath).Path
