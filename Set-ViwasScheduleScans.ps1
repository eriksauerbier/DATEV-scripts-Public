# Skript zum Einstellen der Viwas Prüfungen
# Stannek GmbH - v.1.01 - E.Sauerbier

# Registrypfade
$RegPathQS = "HKLM:\SOFTWARE\WOW6432Node\DATEV Viwas\StandardTasks\QuickScan"
$RegPathNS = "HKLM:\SOFTWARE\WOW6432Node\DATEV Viwas\StandardTasks\NormalScan"
$RegItemQS = "Schedule"
$RegItemNS = "Schedule"

# Zeit für QuickScan generieren
$RandomHourQS = Get-Random -Minimum 19 -Maximum 23
$RandomHourQS = $RandomHourQS.ToString()
$RandomMinuteQS = Get-Random -Minimum 01 -Maximum 58
$RandomMinuteQS = $RandomMinuteQS.ToString()
$RandomTimeQS = $RandomHourQS.PadLeft(2,"0")+":"+$RandomMinuteQS.PadLeft(2,"0")

# Zeit für NormalScan generieren
$RandomHourNS = Get-Random -Minimum 17 -Maximum 23
$RandomHourNS = $RandomHourNS.ToString()
$RandomMinuteNS = Get-Random -Minimum 02 -Maximum 58
$RandomMinuteNS = $RandomMinuteNS.ToString()
$RandomTimeNS = $RandomHourNS.PadLeft(2,"0")+":"+$RandomMinuteNS.PadLeft(2,"0")
$RandomDayNS = Get-Random -InputObject 'NNNNNNY','YNNNNNN'

# Viwas Quickscan anpassen
Set-ItemProperty -Path $RegPathQS -Name $RegItemQS -Value "NYYYNYN,$RandomTimeQS"

# Viwas Normalscan anpassen
Set-ItemProperty -Path $RegPathNS -Name $RegItemNS -Value "$RandomDayNS,$RandomTimeNS"
