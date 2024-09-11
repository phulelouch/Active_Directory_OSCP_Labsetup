New-ADUser -Name "John Doe" -GivenName "John" -Surname "Doe" -UserPrincipalName "John.Doe@yourdomain.com" -SamAccountName "John.Doe" -AccountPassword (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) -Enabled $true 

