$PSVersionTable
# The PSVersion number is the version. you can get it specifically like this:
$PSVersionTable.PSVersion
# Getting Execution Policy List
Get-ExecutionPolicy -List
# Powershell Version Platform details
$PSVersionTable.Platform


if ($PSVersionTable.Platform -eq 'Unix') {
    $logPath = '/tmp'
}
else {
    $logPath = 'C:\Logs' #log path location
}

$logFile = "$logPath\driveCheck.log"


#verify if log directory path is present. if not, create it.
try {
    if (-not (Test-Path -Path $logPath -ErrorAction Stop )) {
        # Output directory not found. Creating...
        New-Item -ItemType Directory -Path $logPath -ErrorAction Stop | Out-Null
        New-Item -ItemType File -Path $logFile -ErrorAction Stop | Out-Null
    }
}
catch {
    throw
}

Add-Content -Path $logFile -Value "[INFO] Running $PSCommandPath"

$logFile



#verify that the required Telegram module is installed.
if (-not (Get-Module -ListAvailable -Name PoshRSJob)) {
    Add-Content -Path $logFile -Value '[INFO] PoshRSJob not installed.'
    throw
} 
else {
    Add-Content -Path $logFile -Value '[INFO] PoshRSJob modules are verified.'
}

if (-not (Get-Module -ListAvailable -Name PoshGram)) {
    Add-Content -Path $logFile -Value '[INFO] PoshGram  not installed.'
    throw
}
else {
    Add-Content -Path $logFile -Value '[INFO] PoshGram modules are verified.'
}




