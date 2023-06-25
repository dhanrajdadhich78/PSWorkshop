############################################################################
# Sending email with attachments
#############################################################################

#Connection Details
$username="yourmailid@gmail.com"
$password="P@$$w0rd!"
$smtpServer = "smtp.gmail.com"

#To get the credentials from Environemnt variable:
# $env.username
# $env.password
# $env.smtpServer

$msg = New-Object Net.Mail.MailMessage

#SMTP connection
$smtp = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 

#SSL tunnel to communicate   
$smtp.EnableSsl = $true

$smtp.Credentials = New-Object System.Net.NetworkCredential($username,$password)

#From Address
$msg.From = "yourmailid@gmail.com"

#To Address, Copy the below line for multiple recipients
$msg.To.Add("yourmailid@gmail.com")

#Message Body
$msg.Body="Please See Attached Files"

#Message Subject
$msg.Subject = "Email with Multiple Attachments"



#for Single file 
$msg.Attachments.Add($attachment)

#for multiple /all files in a folder
#your file location
$files=Get-ChildItem "$env:USERPROFILE\Documents\ScreenShot\"

# Add file/files to messge Body
Foreach($file in $files)
{
Write-Host "Attaching File :- " $file
$attachment = New-Object System.Net.Mail.Attachment -ArgumentList $file.FullName
$msg.Attachments.Add($attachment)

}
$smtp.Send($msg)
write-host "Mail Sent"
$attachment.Dispose();
$msg.Dispose();
