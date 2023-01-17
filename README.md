# Windows-Setup
A Powershell Script that installs applications that every new PC should have installed via Chocolatey

This script is a PowerShell script that makes changes to a Windows computer. It allows the user to change the hostname of the computer, navigate to the Downloads folder, and then prompts the user to install Adobe Reader, Libreoffice, Intelli Dealer shortcut and ScreenConnect.

It also prompts the user to confirm the installation of the above mentioned software, if the user confirms the script will use chocolatey package manager to install the software, if not the script will skip the installation of that software.

It also creates a shortcut to a website named Intelli Dealer on the desktop, if the user confirms that it is needed.

It also have a function that Unpins the Taskbar Store and Mail
It is important to note that running the script with the command (Set-ExecutionPolicy Unrestricted) to allow PowerShell to run scripts before running this script.
