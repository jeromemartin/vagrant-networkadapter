#Requires -Modules VagrantMessages

param(
    [Parameter(Mandatory=$true)]
    [string] $VmId,
    [parameter (Mandatory=$true)]
    [string] $SwitchName,
    [parameter (Mandatory=$false)]
    [string] $Name=$null
)

$VM = Get-VM -Id $VmId

try {
    if ($Name) {
        Write-Host "Changing NetworkAdapter '$Name' for VM $VmId to $SwitchName"
        $adap = Get-VMNetworkAdapter -VM $VM -Name $Name
    } else {
        Write-Host "Changing NetworkAdapter for VM $VmId to $SwitchName"
        $adap = Get-VMNetworkAdapter -VM $VM
    }
    Connect-VMNetworkAdapter -VMNetworkAdapter $adap -SwitchName $SwitchName
} catch {
    $ErrorMessage = $_.Exception.Message
    Write-ErrorMessage "SwitchName : $SwitchName Name : $Name VM : $VM VmId : $VmId Failed to change network adapter for VM $VmId : $ErrorMessage"
    exit 1    
}
