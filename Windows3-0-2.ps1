#Set Hostname
Write-Host 'Enter a new Hostname or leave blank to use the Default [ENTER]' -BackgroundColor Black -ForegroundColor Yellow
Try {
   Rename-Computer
}
Catch { Write-Host "The Hostname is $env:COMPUTERNAME" -BackgroundColor Black -ForegroundColor Yellow }
#cd to Downloads
Set-Location ~\Downloads
######################QUESTIONS##########################################
$UsersAnswerAR = Read-Host -Prompt 'Do you want to install Adobe Reader? (Y/n) default [Y]'
$UsersAnswerLO = Read-Host -Prompt 'Do you want to install Libreoffice? (Y/n) default [n]'
$UsersAnswerID = Read-Host -Prompt 'Does this PC need a Intelli Dealer shortcut? (Y/n) default [n]'
$UsersAnswerSC = Read-Host -Prompt 'Do you want to install ScreenConnect? (Y/n) default [Y]'
#Install Choco
$Restricted = $false
$ex = Get-ExecutionPolicy
if ($ex -eq 'Restricted')
{
	Set-ExecutionPolicy Bypass -Scope Process -Force
	$Restricted = $true
}
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


#Do you want to install Reader?
do
{
	$r = 0
	if ($UsersAnswerAR -eq 'Yes' -or $UsersAnswerAR -eq 'Y' -or $UsersAnswerAR -eq '')
	{
		
		#Install
		choco install adobereader -y
		$r = 1
	}
	elseif ($UsersAnswerAR -eq 'No' -or $UsersAnswerAR -eq 'N')
	{
		Write-Host 'Adobe Reader NOT Installed'
		$r = 1
	}
	else
	{
		Write-Host 'Type Yes or No.'
	}
}
while ($r -eq 0)

#Do you want to install Libreoffice?
do
{
	$l = 0
	if ($UsersAnswerLO -eq 'Yes' -or $UsersAnswerLO -eq 'Y')
	{
		
		
		#Install
		choco install libreoffice-fresh -y
		$l = 1
	}
	elseif ($UsersAnswerLO -eq 'No' -or $UsersAnswerLO -eq 'N' -or $UsersAnswerLO -eq '')
	{
		Write-Host 'Libre Office NOT Installed'
		$l = 1
	}
	else
	{
		Write-Host 'Type Yes or No.'
	}
}
while ($l -eq 0)

#Does Keystone need to be installed?
do
{
	$r = 0
	if ($UsersAnswerID -eq 'Yes' -or $UsersAnswerID -eq 'Y')
	{
		
		#Create Website Shortcut
		$Shell = New-Object -ComObject ("WScript.Shell")
		$Favorite = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\IntelliDealer.url")
		$Favorite.TargetPath = "http://pfwf8033.cdkglobal-id.net:20203/intellidealer/index.html?_cb=20211101153548#/login?library=PFWF8033";
		$Favorite.Save()
		
		$r = 1
	}
	elseif ($UsersAnswerID -eq 'No' -or $UsersAnswerID -eq 'N' -or $UsersAnswerID -eq '')
	{
		Write-Host 'DIS NOT Installed'
		$r = 1
	}
	else
	{
		Write-Host 'Type Yes or No.'
	}
}
while ($r -eq 0)
#####################################################################
#Unpin Taskbar Store and Mail
function UnPinFromTaskbar {
   param( [string]$appname )
   Try {
      ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | Where-Object { $_.Name -eq $appname }).Verbs() | Where-Object { $_.Name -like "Ta bort fr*" -OR $_.Name -like "Unpin from*" } | ForEach-Object { $_.DoIt() }
   }
   Catch { $a = "b" }
} #UnPinFromTaskbar
UnPinFromTaskbar "E-Post"
UnPinFromTaskbar "Microsoft Store"
UnPinFromTaskbar "Mail"

#Download applications
#Chrome
choco install googlechrome -y 
#Firefox
choco install firefox -y
#Java
choco install jre8 -y
#7zip
choco install 7zip.install -y
#VLC
choco install vlc -y
#SpyBot
choco install spybot -y
#.Net
choco install dotnetfx -y
#Air
#choco install adobeair -y
#SilverLight
#choco install silverlight -y

# Set ExecutionPolice back to restricted
if ($Restricted -eq $true)
{
	Set-ExecutionPolicy Restricted -Scope Process -Force
}
# Install ScreenConnect
do
{
	$r = 0
	if ($UsersAnswerSC -eq 'Yes' -or $UsersAnswerSC -eq 'Y' -or $UsersAnswerSC -eq '')
	{
		
		$url = 'https://github.com/dazbuttars/Windows-Setup/releases/download/v3.0.0/ConnectWiseControl.ClientSetup.exe'
		$outpath = './ConnectWiseControl.ClientSetup.exe'
		Invoke-WebRequest -Uri $url -OutFile $outpath
		Start-Process -Filepath './ConnectWiseControl.ClientSetup.exe'

		
		$r = 1
	}
	elseif ($UsersAnswerSC -eq 'No' -or $UsersAnswerSC -eq 'N' -or $UsersAnswerSC -eq '')
	{
		Write-Host 'Screen Connect NOT Installed'
		$r = 1
	}
	else
	{
		Write-Host 'Type Yes or No.'
	}
}
while ($r -eq 0)
