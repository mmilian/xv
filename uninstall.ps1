    # This script will remove the Xv installation at the location of this
    # script, removing it from %PATH%, deleting caches, and removing it from
    # the list of installed programs.
    param(
    [switch]$PauseOnError = $true
    )

    $ErrorActionPreference = "Stop"

    # These two environment functions are roughly copied from https://github.com/prefix-dev/pixi/pull/692
    # They are used instead of `SetEnvironmentVariable` because of unwanted variable expansions.
    function Write-Env {
    param([String]$Key, [String]$Value)

    $RegisterKey = Get-Item -Path 'HKCU:'
    $EnvRegisterKey = $RegisterKey.OpenSubKey('Environment', $true)
    if ($null -eq $Value) {
        $EnvRegisterKey.DeleteValue($Key)
    } else {
        $RegistryValueKind = if ($Value.Contains('%')) {
        [Microsoft.Win32.RegistryValueKind]::ExpandString
        } elseif ($EnvRegisterKey.GetValue($Key)) {
        $EnvRegisterKey.GetValueKind($Key)
        } else {
        [Microsoft.Win32.RegistryValueKind]::String
        }
        $EnvRegisterKey.SetValue($Key, $Value, $RegistryValueKind)
    }
    }

    function Get-Env {
    param([String] $Key)

    $RegisterKey = Get-Item -Path 'HKCU:'
    $EnvRegisterKey = $RegisterKey.OpenSubKey('Environment')
    $EnvRegisterKey.GetValue($Key, $null, [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
    }

    if (-not (Test-Path "${PSScriptRoot}\bin\xv.exe")) {
    Write-Host "xv.exe not found in ${PSScriptRoot}\bin`n`nRefusing to delete this directory as it may.`n`nIf this uninstallation is still intentional, please just manually delete this folder."
    if ($PauseOnError) { pause }
    # exit 1
    }

    function Stop-Xv {
    try {
        Get-Process -Name xv | Where-Object { $_.Path -eq "${PSScriptRoot}\bin\xv.exe" } | Stop-Process -Force
    } catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
        # ignore
    } catch {
        Write-Host "There are open instances of xv.exe that could not be automatically closed."
        if ($PauseOnError) { pause }
        exit 1
    }
    }

    # Remove ~\.xv\bin\xv.exe
    try {
    Stop-Xv
    Remove-Item "${PSScriptRoot}\bin\xv.exe" -Force
    } catch {
    # Try a second time
    Stop-Xv
    Start-Sleep -Seconds 1
    try {
        Remove-Item "${PSScriptRoot}\bin\xv.exe" -Force
    } catch {
        Write-Host $_
        Write-Host "`n`nCould not delete ${PSScriptRoot}\bin\xv.exe."
        Write-Host "Please close all instances of xv.exe and try again."
        if ($PauseOnError) { pause }
        # exit 1
    }
    }

    # # Remove ~\.xv
    try {
    Remove-Item "${PSScriptRoot}" -Recurse -Force
    } catch {
    Write-Host "Could not delete ${PSScriptRoot}."
    if ($PauseOnError) { pause }
    # exit 1
    }

    # Delete some tempdir files. Do not fail if an error happens here
    try {
    Remove-Item "${Temp}\xv-*" -Recurse -Force
    } catch {}

    # Remove Entry from path
    try {
    $Path = Get-Env -Key 'Path'
    $Path = $Path -split ';'
    $Path = $Path | Where-Object { $_ -ne "${PSScriptRoot}\bin" }
    Write-Env -Key 'Path' -Value ($Path -join ';')
    } catch  {
    Write-Host "Could not remove ${PSScriptRoot}\bin from PATH."
    Write-Error $_
    if ($PauseOnError) { pause }
    # exit 1
    }

    # Remove Entry from Windows Installer, if it is owned by this installation.
    try {
    $item = Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Xv";
    $location = $item.GetValue("InstallLocation");
    if ($location -eq "${PSScriptRoot}") {
        Remove-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Xv" -Recurse
    }
    } catch {
    # unlucky tbh
    }

    Write-Host "XV has been uninstalled."