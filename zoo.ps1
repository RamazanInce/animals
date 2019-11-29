 If ($datetimecheckCriticals -gt $alert.TimeRaised -and [System.String]::IsNullOrEmpty($alert.TicketId)-AND (-not$AllAlertIds.Contains($([string]$alert.Id))))
    {
       $AllAlertIds+=$([string]$alert.Id) # add to keep track of it.
       write-output "Subscription 2 Alerts"
   	   Write-Output "alertid<>$([string]$alert.Id)###"
	   Write-Output "alertname<>$($alert.Name)###"
	   If ([system.string]::IsNullOrEmpty($alert.NetbiosComputerName))
		    {
		      Write-Output "alertServername<>$($alert.MonitoringObjectDisplayName)###"
		    }
		    else
		    {
		       Write-Output "alertServername<>$($alert.NetbiosComputerName)###"
		    }
	   Write-Output "alertTimeraised<>$([System.TimeZoneInfo]::ConvertTimeFromUtc($alert.TimeRaised, $TZ).DateTime)###" 
	   #Write-Output "alertTimeadded<>$(($alert.TimeAdded).Datetime)###"
	   Write-Output "alertTimeadded<>$([System.TimeZoneInfo]::ConvertTimeFromUtc($alert.TimeAdded, $TZ).datetime)###"
	   Write-Output "alertTimelastModified<>$([System.TimeZoneInfo]::ConvertTimeFromUtc($alert.LastModified, $TZ).datetime)###"
	   Write-Output "alertLastModifiedBy<>$($alert.LastModifiedBy)###"
	   Write-Output "alertSeverity<>$($alert.severity)###"
       Write-Output "alertPriority<>$($alert.priority)###"
	   Write-Output "alertMMmodeLastModified<>$([System.TimeZoneInfo]::ConvertTimeFromUtc($alert.MaintenanceModeLastModified , $TZ).datetime)###"
	   try{
	   		
          	[string]$extra=([xml]$alert.Context | Select-xml -Xpath "//EventDescription" -ErrorAction Stop | Select-Object -ExpandProperty "node").'#cdata-section'
         	$extra = "`n" + $extra
         	Write-Output "alertDescription<>$($alert.Description)$($extra)###"
          }
        catch
        {

        }
         Write-Output "|||" 
    }
}
