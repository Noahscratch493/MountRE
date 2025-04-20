Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "conhost cmd /k ver & cd /d C:\Windows\System32", 1, False
WScript.Sleep 100
WshShell.AppActivate "Command Prompt"
WshShell.SendKeys "{F11}"