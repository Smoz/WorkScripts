# This will take a CSV file with usernames and add them to a specified AD group
# This could be improved by adding the ability to add these users to multiple groups

# Your list of usernames
$users = Import-Csv "[CSVTHATCONTAINSUSERNAMES]" # Example C:\Users\[USERNAME]\OneDrive\Documents\userlist.csv

# Your output TXT file locations
# 
$exists = $Home\Documents\exists.txt
$added = $Home\Documents\not-exists.txt

# The username
$user = $_.username

# The group that you want to add users to
# Example acl-ww-GP-OneDriveProfileRemap
$group = "[ADGROUPTOADDUSERSTO]" 

# Get the AD Group Members
$members = Get-ADGroupMember -Identity $group -Recursive | Select -ExpandProperty SamAccountName

# Loop through and check if the user is already in the group
# IF the user is in the group the output those usernames to a TXT file
# ELSE the user is not in the group so they are added
# Then output those usernames to a TXT file
ForEach ($user in $users) {
    If ($members -contains $user.username) {
      Write-Host "$user already exists in $group."
      Out-file -InputObject "$user already exists in $group." -FilePath $exists -append
 } Else {
      Write-Host "$user does not exist in $group. Adding $user now." 
      Add-ADGroupMember -Identity $group -Members $user.UserName
      Out-file -InputObject "$user does not exist in $group. Adding $user now." -FilePath $added -append
}}

# Wait for input before closing CLI window
Read-Host -Prompt "Press Enter to Exit"
