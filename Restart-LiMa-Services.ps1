# Skript zum Neustarten bei LiMa-Problemen
# Stannek GmbH - Version 1.0 - 09.12.2021 ES

#Parameter
$ASPEnvironment = $True

# Dienste stoppen
Stop-Service "DATEV Sicherheitspaket-Basis-Dienst"
Stop-Service "DATEV LiMa-Server"
Stop-Service "Datev.CC.Processes.Hosting.RdtServiceMode"

# Dienste für ASP Umgebungen stoppen/starten
if ($ASPEnvironment = $True) 
    {Stop-Service "DBSZClient"
     Start-Sleep -Seconds 15
     Start-Service "DBSZClient"
    }

# Dienste starten
Start-Sleep -Seconds 15
Start-Service "DATEV Sicherheitspaket-Basis-Dienst"
Start-Sleep -Seconds 15
Start-Service "DATEV LiMa-Server"
Start-Sleep -Seconds 15
Start-Service "Datev.CC.Processes.Hosting.RdtServiceMode"