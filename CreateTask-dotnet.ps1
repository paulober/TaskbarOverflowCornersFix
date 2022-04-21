[string]$TaskName = "Taskbar Overflow Corners Fix"
[string]$TaskDesc = "This task will be executed on login"
[string]$TaskPath = "C:\Program Files\dotnet\dotnet.exe"
[string]$TaskArgument = "C:\<path-to>\TaskbarOverflowCornersFix.dll"
[string]$TaskWorkspace = "C:\<path-to>"

$TaskTrigger = New-ScheduledTaskTrigger -AtLogOn

$TaskAction = New-ScheduledTaskAction -Execute $TaskPath -Argument $TaskArgument -WorkingDirectory $TaskWorkspace

$tspan = New-TimeSpan -Minutes 2
$TaskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -ExecutionTimeLimit $tspan

$TaskUser = New-ScheduledTaskPrincipal -UserId "YOUR-PC-HOSTNAME\\your-username" -RunLevel Limited

if (Get-ScheduledTask $TaskName -ErrorAction SilentlyContinue) { Unregister-ScheduledTask $TaskName }

Register-ScheduledTask -TaskName $TaskName -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskUser -Settings $TaskSettings -Description $TaskDesc
