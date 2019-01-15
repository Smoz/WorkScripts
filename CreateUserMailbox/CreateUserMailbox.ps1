#Import CSV to bulk create user mailboxes

Import-Csv C:\createusers.csv | foreach { Enable-Mailbox -Identity $_.UserPrincipalName -Alias $_.Username -Database $_.Database };
