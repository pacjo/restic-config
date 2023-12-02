$timestamp = Get-Date -UFormat "%Y-%m-%d - %H-%M"
$crestic_config = "C:\Users\kamil\.config\crestic"

echo "==== Running backup... ====" | Tee-Object -Append -FilePath $crestic_config\logs\$timestamp.log
crestic home backup | Tee-Object -Append -FilePath $crestic_config\logs\$timestamp.log
echo "==== Running forget and prune... ====" | Tee-Object -Append -FilePath $crestic_config\logs\$timestamp.log
crestic home forget | Tee-Object -Append -FilePath $crestic_config\logs\$timestamp.log
echo "==== Backup done! ====" | Tee-Object -Append -FilePath $crestic_config\logs\$timestamp.log

pause