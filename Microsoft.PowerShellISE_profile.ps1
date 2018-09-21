
if (Get-Module -ListAvailable PsISEProjectExplorer)
{Import-Module PsISEProjectExplorer}
else {Write-Host "You could install-module PsISEProjectExplorer" -ForegroundColor Yellow}

if (Get-Module -ListAvailable powershellhumanizer)

{Import-Module powershellhumanizer}
else {Write-Host "You could install-module powershellhumanizer" -ForegroundColor Yellow}

 
#this won't display properly on Linux
Function prompt {
    # .Description
    # This custom version of the PowerShell prompt will present a colorized location value based on the current provider. It will also display the PS prefix in red if the current user is running as administrator.    
    # .Link
    # https://go.microsoft.com/fwlink/?LinkID=225750
    # .ExternalHelp System.Management.Automation.dll-help.xml
 function Get-LastCmdTime
 {
    $diffPromptTime = $null
   
    $lastCmd = Get-History -Count 1
    if ($lastCmd -ne $null) {
        $diff = $lastCmd.EndExecutionTime - $lastCmd.StartExecutionTime
        try 
        {
        # assumes humanize has been installed:
          $diffPromptTime = $diff.Humanize()
        }
        catch
        {
          $diffPromptTime = $diff.ToString("hh\:mm\:ss")
        }
        $diffPromptTime
    }
 }
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    if ( (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        $adminfg = "Red"
    }
    else {
        $adminfg = $host.ui.rawui.ForegroundColor
        
    }
 
    Switch ((get-location).provider.name) {
        "FileSystem" { $fg = "green"}
        "Registry" { $fg = "magenta"}
        "wsman" { $fg = "cyan"}
        "Environment" { $fg = "yellow"}
        "Certificate" { $fg = "darkcyan"}
        "Function" { $fg = "gray"}
        "alias" { $fg = "darkgray"}
        "variable" { $fg = "darkgreen"}
        "CMSite" { $fg = "darkyellow"} 
        Default { $fg = $host.ui.rawui.ForegroundColor}
    } 
    if ($adminfg -eq -1) {$adminfg='DarkGray'}
    if ($fg -eq -1) {$adminfg='DarkGray'}
    #Write-Host "[$((Get-Date).timeofday.tostring().substring(0,8))] " -NoNewline
    Write-host '[' -NoNewline
    Write-Host "$((Get-Date).timeofday.tostring().substring(0,8))-" -foregroundcolor cyan  -NoNewline 
    write-host "$(Get-LastCmdTime)" -NoNewline -ForegroundColor Yellow
    Write-Host "] " -nonewline
    Write-Host "PS " -nonewline -ForegroundColor $adminfg
    Write-Host "$($executionContext.SessionState.Path.CurrentLocation)" -foregroundcolor $fg -nonewline
    Write-Output "$('>' * ($nestedPromptLevel + 1)) "  

    $code = 
{
    # thx for idea: http://community.idera.com/powershell/powertips/b/tips/posts/adding-live-clock-to-powershell-title-bar-part-2
    param($RawUi, $ExecContext)

    do
    {
        # find the current location in the host process
        $location = $ExecContext.SessionState.Path.CurrentLocation
        # compose the time and date display
        $time = Get-Date -Format 'HH:mm:ss dddd MMMM d'
        # compose the title bar text
        $title = "$location     $time    " + (whoami)
        # output the information to the title bar of the host process
        $RawUI.WindowTitle = $title
        # wait a half second
        Start-Sleep -Milliseconds 500
    } while ($true)
}
$ps = [PowerShell]::Create()
$null = $ps.AddScript($code).AddArgument($host.UI.RawUI).AddArgument($ExecutionContext)
$handle = $ps.BeginInvoke()
}
$host.PrivateData.ErrorForegroundColor = 'Yellow'
write-host "Hallo $env:UserName on $env:ComputerName" -ForegroundColor Green -NoNewline
$user = [Security.Principal.WindowsIdentity]::GetCurrent()
if ( (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        write-host " as ADMIN" -foregroundcolor yellow -NoNewline
    }
Get-Date


