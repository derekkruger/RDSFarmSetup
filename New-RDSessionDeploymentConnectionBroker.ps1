$Broker = RDSBRK01.DRE.COM
$Desk = RDSDESK01.DRE.COM
$Web = RDSWEB01.DRE.COM


New-RDSessionDeployment -ConnectionBroker $Broker `
                        -SessionHost $Desk `
                        -WebAccessServer $Web


Add-RDServer -Server RDS-APP-01.SeromIT.local `
                        -Role RDS-RD-SERVER `
                        -ConnectionBroker $Broker
            
Add-RDServer -Server $Broker `
                        -Role RDS-Licensing `
                        -ConnectionBroker $Broker
            
Add-RDServer -Server $Web `
                        -Role RDS-Gateway `
                        -ConnectionBroker $Broker `
                        -GatewayExternalFqdn RDS-GW.SeromIT.com

#Set Certs 
$Password = Read-Host -AsSecureString
Set-RDCertificate -Role RDGateway `
                  -ImportPath C:\temp\RDS\wildcard_SeromIT_com.pfx `
                  -Password $Password `
                  -ConnectionBroker $Broker `
                  -Force
 
Set-RDCertificate -Role RDWebAccess `
                  -ImportPath C:\temp\RDS\wildcard_SeromIT_com.pfx `
                  -Password $Password `
                  -ConnectionBroker $Broker `
                  -Force
 
Set-RDCertificate -Role RDPublishing `
                  -ImportPath C:\temp\RDS\Broker.pfx `
                  -Password $Password `
                  -ConnectionBroker $Broker `
                  -Force
 
Set-RDCertificate -Role RDRedirector `
                  -ImportPath C:\temp\RDS\Broker.pfx `
                  -Password $Password `
                  -ConnectionBroker $Broker `
                  -Force

New-RDSessionCollection -CollectionName Desktop `
                  -CollectionDescription "Desktop Publication" `
                  -SessionHost $Desk `
                  -ConnectionBroker $Broker

