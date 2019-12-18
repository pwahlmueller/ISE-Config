# Config

Two PowerShell Configs with some benefits. Main benefit is the last execution time, which I find very useful to automate.
- My actual Config (psconfig.ps1)
- My previous ISE config (Microsoft.PowerShellISE_profile.ps1)

## Titlebar
- Actual time
- Actual User

## Interacitve Window
- Actual time in prompt and titlebar
- Timespan of the last command in prompt
- Prompt red for "as admin"
- User and Computer are displayed at startup
- Prompt color depends on PowerShell Provider
- Date and Time are displayed at startup

# Install Config

To use the Config for all powershell consoles, use the path in $profile.CurrentUserAllHosts. In the current console you can use the variable $profile to find out all possible profile files.

# Prerequesits
These prerequisits are optional.

- PowerShell Humanizer
- PowerShell PsISEProjectExplorer

# Example
![prompt example](2019-12-18-18-29-03promptexample.png)