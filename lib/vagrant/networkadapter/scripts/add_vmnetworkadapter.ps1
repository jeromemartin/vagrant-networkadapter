#Requires -Modules VagrantMessages

param(
    [Parameter(Mandatory=$true)]
    [string]$VmId,
    [parameter (Mandatory=$true)]
    [string] $SwitchName,
    [parameter (Mandatory=$true)]
    [string] $Name
)

$VM = Get-VM -Id $VmId

try {
	Write-Host "Creating NetworkAdapter"
    Add-VMNetworkAdapter -VM $VM -SwitchName $SwitchName -Name $Name
} catch {
    $ErrorMessage = $_.Exception.Message
    Write-ErrorMessage "Failed to add network adapter to VM $VmId : $ErrorMessage"
    exit 1    
}
