#Import CSV for bulk creation

Import-Csv C:\createusers.csv | foreach-object { New-ADUser -Name $_.Name -UserPrincipalName $_.UserPrincipalName -SamAccountName $_.Username -GivenName $_.Givenname -DisplayName $_.Name -Surname $_.Surname -Description $_.Department -EmployeeID $_.EmployeeID -Path $_.Path -ScriptPath $_.ScriptPath -AccountPassword (ConvertTo-SecureString -AsPlainText $_.Password -force) -Enabled $True -PassThru -Country $_.Country -Company $_.Company }; 
