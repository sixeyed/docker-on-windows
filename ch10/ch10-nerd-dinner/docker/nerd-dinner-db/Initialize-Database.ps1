param(
    [Parameter(Mandatory=$true)]
    [string] $sa_password,

    [Parameter(Mandatory=$true)]
    [string] $data_path,
    
    [Parameter(Mandatory=$true)]
    [string] $sa_password_path
)

# start the service
Write-Verbose 'Starting SQL Server'
Start-Service MSSQL`$SQLEXPRESS

# set the SA password
if ($sa_password_path -and (Test-Path $sa_password_path)) {
    $password = Get-Content -Raw $sa_password_path
    if ($password) {
        $sa_password = $password
        Write-Verbose "Using SA password from secret file: $sa_password_path"
    }
    else {
        Write-Verbose "WARN: Using default SA password, no password in secret file: $sa_password_path"
    }
}
else {
    Write-Verbose "WARN: Using default SA password, secret file not found at: $sa_password_path"
}

if ($sa_password) {
	Write-Verbose 'Changing SA login credentials'
    $sqlcmd = "ALTER LOGIN sa with password='$sa_password'; ALTER LOGIN sa ENABLE;"
    Invoke-SqlCmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS" 
}
else {
    Write-Verbose 'FATAL: SA password not supplied in sa_password or sa_password_path'
    return 1
}

$mdfPath = "$data_path\NerdDinner_Primary.mdf"
$ldfPath = "$data_path\NerdDinner_Primary.ldf"

# attach data files if they exist: 
if ((Test-Path $mdfPath) -eq $true) {
    $sqlcmd = "IF DB_ID('NerdDinner') IS NULL BEGIN CREATE DATABASE NerdDinner ON (FILENAME = N'$mdfPath')"
    if ((Test-Path $ldfPath) -eq $true) {
        $sqlcmd =  "$sqlcmd, (FILENAME = N'$ldfPath')"
    }
    $sqlcmd = "$sqlcmd FOR ATTACH; END"
    Write-Verbose 'Data files exist - will attach and upgrade database'
    Invoke-Sqlcmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS"
}
else {
     Write-Verbose 'No data files - will create new database'
}

# deploy or upgrade the database:
$SqlPackagePath = 'C:\Program Files\Microsoft SQL Server\140\DAC\bin\SqlPackage.exe'
& $SqlPackagePath  `
    /sf:NerdDinner.Database.dacpac `
    /a:Script /op:deploy.sql /p:CommentOutSetVarDeclarations=true `
    /tsn:.\SQLEXPRESS /tdn:NerdDinner /tu:sa /tp:$sa_password 

$SqlCmdVars = "DatabaseName=NerdDinner", "DefaultFilePrefix=NerdDinner", "DefaultDataPath=$data_path\", "DefaultLogPath=$data_path\"  
Invoke-Sqlcmd -InputFile deploy.sql -Variable $SqlCmdVars -Verbose

Write-Verbose "Deployed NerdDinner database, data files at: $data_path"

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}