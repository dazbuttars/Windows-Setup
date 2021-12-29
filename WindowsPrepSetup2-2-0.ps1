#Set Hostname
Write-Host 'Enter a new Hostname or leave blank to use the Default [ENTER]' -BackgroundColor Black -ForegroundColor Yellow
Try {
   Rename-Computer
}
Catch { Write-Host "The Hostname is $env:COMPUTERNAME" -BackgroundColor Black -ForegroundColor Yellow }
#cd to Downloads
Set-Location ~\Downloads
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

#Install Choco
$Restricted = $false
$ex = Get-ExecutionPolice
if ($ex -eq 'Restricted') {
   Set-ExecutionPolicy Bypass -Scope Process -Force
   $Restricted = $true 
}
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
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
choco install adobeair -y
#SilverLight
choco install silverlight -y

#Do you want to install Reader?
do {
   $r = 0
   $UsersAnswer = Read-Host -Prompt 'Do you want to install Adobe Reader? (Yes/No)'
   if ($UsersAnswer -eq 'Yes') {

      #Install
      choco install adobereader -y
      $r = 1
   }
   elseif ($UsersAnswer -eq 'No') {
      Write-Host 'O.K.'
      $r = 1
   }
   else {
      Write-Host 'Type Yes or No.'
   }
} while ($r -eq 0)

#Do you want to install Libreoffice?
do {
   $l = 0
   $UsersAnswer = Read-Host -Prompt 'Do you want to install Libreoffice? (Yes/No)'
   if ($UsersAnswer -eq 'Yes') {
   
  
      #Install
      choco install libreoffice-fresh -y
      $l = 1
   }
   elseif ($UsersAnswer -eq 'No') {
      Write-Host 'O.K.'
      $l = 1
   }
   else {
      Write-Host 'Type Yes or No.'
   }
} while ($l -eq 0)

# Set ExecutionPolice back to restricted
if ($Restricted -eq $true) {
   Set-ExecutionPolicy Restricted -Scope Process -Force
}


#Does Keystone need to be installed?
do {
   $r = 0
   $UsersAnswer = Read-Host -Prompt 'Does this PC need a Intelli Dealer shortcut? (Yes/No)'
   if ($UsersAnswer -eq 'Yes') {
		
		#Create Website Shortcut
		$Shell = New-Object -ComObject ("WScript.Shell")
		$Favorite = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\IntelliDealer.url")
		$Favorite.TargetPath = "http://pfwf8033.cdkglobal-id.net:20203/intellidealer/index.html?_cb=20211101153548#/login?library=PFWF8033";
		$Favorite.Save()
		
      $r = 1
   }
   elseif ($UsersAnswer -eq 'No') {
      Write-Host 'O.K.'
      $r = 1
   }
   else {
      Write-Host 'Type Yes or No.'
   }
} while ($r -eq 0)
Start-Process chrome.exe https://itsp.screenconnect.com