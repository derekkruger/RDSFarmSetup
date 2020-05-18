$Broker = "RDSBRK01.DRE.COM"
$Desk = "RDSDESK01.DRE.COM"
$Web = "RDSWEB01.DRE.COM"
$Sesh = "RDSSESH01.DRE.COM"
$VM_NAME = @("RDSBRK01","RDSDESK01","RDSWEB01","RDSSESH01")
$VM_RAM = 1GB
$VM_RAM_MAX = 2GB
$VM_CPUS = "4"
$VM_DEST_PATH = "C:\vhds"
$VM_TO_COPY = "server2019.vhdx"
$VM_HOST = ""
$NETWORK_SWITCH = "HVSwitch"
$ROOT_VHD_TPL = "C:\vhds"

# New-VM -Name $vmname -MemoryStartupBytes 8gb -BootDevice VHD -NewVHDPath "F:\VHDs\Virtual Hard Disks\$vmname" -NewVHDSizeBytes 20GB -Generation 1 -Switch HVSwitch
foreach ($server in $VM_NAME){
Copy-Item -Path "${VM_DEST_PATH}\${VM_TO_COPY}" -Destination "${VM_DEST_PATH}\${server}.vhdx" -Force
}
foreach ($server in $vmname) {
New-VM -Name $VM_NAME -MemoryStartupBytes 4GB -BootDevice VHD -VHDPath '${VM_DEST_PATH}\${server}.vhdx' -Path .\VMData -Generation 2 -Switch HVSwitch
}