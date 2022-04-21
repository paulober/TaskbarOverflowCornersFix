[string]$TaskName = "Taskbar Overflow Corners Fix"
[string]$TaskDesc = "This task will be executed on login"
[string]$TaskPath = "C:\<path-to>\cornersfix.exe"

$TaskTrigger = New-ScheduledTaskTrigger -AtLogOn

$TaskAction = New-ScheduledTaskAction -Execute $TaskPath

$tspan = New-TimeSpan -Minutes 2
$TaskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -ExecutionTimeLimit $tspan

$TaskUser = New-ScheduledTaskPrincipal -UserId "WORLDMIND\\paulo" -RunLevel Limited

if (Get-ScheduledTask $TaskName -ErrorAction SilentlyContinue) { Unregister-ScheduledTask $TaskName }

Register-ScheduledTask -TaskName $TaskName -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskUser -Settings $TaskSettings -Description $TaskDesc
