#Requires -Modules VagrantMessages

param(
    [Parameter(Mandatory=$true)]
    [string] $VmName,
	[parameter (Mandatory=$true)]
    [string] $NewName,
    [parameter (Mandatory=$false)]
    [string] $Name=$null
)


try {
    if ($Name) {
        Rename-VMNetworkAdapter -VMName $VmName -Name $Name -NewName $NewName
    } else {
        Rename-VMNetworkAdapter -VMName $VmName -NewName $NewName
    }
} catch {
    $ErrorMessage = $_.Exception.Message
    Write-ErrorMessage "Failed to change network adapter for VM : $ErrorMessage"
    exit 1    
}
