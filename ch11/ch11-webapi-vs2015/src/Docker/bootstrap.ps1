
if ($env:configuration -eq 'debug') {
 Write-Output 'Starting debugger'
 Start-Process 'C:\Program Files\Microsoft Visual Studio 14.0\Common7\IDE\Remote Debugger\x64\msvsmon.exe' `
  -ArgumentList /noauth, /anyuser, /silent, /nostatus, /noclrwarn, /nosecuritywarn, /nofirewallwarn, /nowowwarn, /timeout:2147483646
}

Write-Output 'Running ServiceMonitor'
& C:\ServiceMonitor.exe w3svc