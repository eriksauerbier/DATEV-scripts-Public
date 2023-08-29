# Skript zum Anpassen der Instman DFÜ Abruf-Zeiten
# Stannek GmbH - v.1.0.1 - 25.08.2023 - E.Sauerbier

# Parameter
$PathPRM = "\\$env:COMPUTERNAME\WINDVSW1\DATEV\DATEN\INSTMAN\Properties\DvInesProperties.prm"
$PathINI = "\\$env:COMPUTERNAME\WINDVSW1\DATEV\DATEN\INSTMAN\Properties\DvInesProperties.prm.ini"

# Zufallszahl fuer Stunde und Minute erstellen
$RandomHour =Get-Random -Minimum "5" -Maximum "18"
$RandomMinute =Get-Random -Minimum "1" -Maximum "55"

# PRM-File auslesen
$PRM = Get-Content -Path $PathPRM

# INI auslesen
$INI = Get-Content -Path $PathINI

# Original PRM Parameter auslesen
$OrgPRMStartHour = Select-String -Path $PathPRM -Pattern '<parameter name="hour">'
$OrgPRMEndHour = Select-String -Path $PathPRM -Pattern '<parameter name="hourende">'
$OrgPRMStartMinute = Select-String -Path $PathPRM -Pattern '<parameter name="minute">'
$OrgPRMEndMinute = Select-String -Path $PathPRM -Pattern '<parameter name="minuteende">'

# PRM Werte anpassen
$PRM[$OrgPRMStartHour.LineNumber] = $PRM[$OrgPRMStartHour.LineNumber] -replace '\d+',"$RandomHour"
$PRM[$OrgPRMEndHour.LineNumber] = $PRM[$OrgPRMEndHour.LineNumber] -replace '\d+',"$($RandomHour+"1")"
$PRM[$OrgPRMStartMinute.LineNumber] = $PRM[$OrgPRMStartMinute.LineNumber] -replace '\d+',"$RandomMinute"
$PRM[$OrgPRMEndMinute.LineNumber] = $PRM[$OrgPRMEndMinute.LineNumber] -replace '\d+',"$RandomMinute"		

# Original INI Parameter auslesen
$OrgStartHour = Select-String -Path $PathINI -Pattern "hour="
$OrgEndHour = Select-String -Path $PathINI -Pattern "hourende="
$OrgStartMinute = Select-String -Path $PathINI -Pattern "minute="
$OrgEndMinute = Select-String -Path $PathINI -Pattern "minuteende="

# INI-Werte anpassen
$INI = $INI -replace $OrgStartHour.Line,"hour=$RandomHour"
$INI = $INI -replace $OrgStartMinute.Line,"minute=$RandomMinute"
$INI = $INI -replace $OrgEndHour.Line,"hourende=$($RandomHour+"1")"
$INI = $INI -replace $OrgEndMinute.Line,"minuteende=$RandomMinute"

# Angepasste Werte in INI und PRM schreiben
Set-Content -Path $PathPRM -Value $PRM
#Set-Content -Path $PathINI -Value $INI