# xv

## Windows

### Installation

1. Open terminal (Windows CMD or Powershell):
```powershell
powershell -c "irm https://raw.githubusercontent.com/mmilian/xv/refs/heads/main/install.ps1 | iex"
```
2. Restart the terminal
3. Set XEO_TOKEN=<your token> (can be globally or just for the session)
```powershell
$env:XEO_TOKEN = '<your_token_here>'
```
4. Ready to start 
```powershell
xv convert https://raw.githubusercontent.com/xeokit/xeokit-sdk/master/assets/models/ifc/Duplex.ifc --type ifc-xkt --airtifact
```

### Uninstall
1. Open powershell
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
cd $Env:HOMEPATH
.\.xv\uninstall.ps1
```
