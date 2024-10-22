# XV
## Windows Installation Guide
### Installation

1. Open Terminal (PowerShell Preferred):

```powershell
# Download and execute the installation script
irm https://raw.githubusercontent.com/mmilian/xv/refs/heads/main/install.ps1 | iex
```
Alternatively, download and review the script:

```powershell
# Download the script
irm https://raw.githubusercontent.com/mmilian/xv/refs/heads/main/install.ps1 -OutFile install.ps1
# Review the script
notepad install.ps1
# Execute the script
.\install.ps1
```

2. Restart the Terminal

This ensures that any environment variable changes take effect.

3. Set XEO_TOKEN Environment Variable

In PowerShell (Current Session):

```powershell
$env:XEO_TOKEN='<your_token_here>'
```
In PowerShell (Permanently for Current User):

```powershell
[Environment]::SetEnvironmentVariable("XEO_TOKEN", "<your_token_here>", "User")
```

In Windows CMD (Current Session):

```cmd
set XEO_TOKEN=<your_token_here>
```

In Windows CMD (Permanently for Current User):

```cmd
setx XEO_TOKEN <your_token_here>
```

Note: After using setx, restart your terminal or log off and log back in to apply the changes.


> [!WARNING] 
> Do not have XEO_TOKEN. Go to [docs.xeo.vision](https://xeo.vision)


4. Ready to Start

```powershell
xv convert https://raw.githubusercontent.com/xeokit/xeokit-sdk/master/assets/models/ifc/Duplex.ifc --type ifc-xkt --artifact
```

Explanation:

xv convert: Initiates the conversion process.
url: Specifies the IFC file to convert.
--type ifc-xkt: Sets the output format to xkt.
--artifact: Drops artifact to local folder.

### Uninstallation

1. Open PowerShell

```powershell
# Run the uninstall script with execution policy bypassed for this command only
powershell -ExecutionPolicy Bypass -File "$HOME\.xv\uninstall.ps1"
```

Note:

If XV was installed in a different directory, replace $HOME\.xv\uninstall.ps1 with the correct path.
There is no need to change the directory; the command specifies the full path to the uninstall script.
Additional Information
Help and Documentation:

For more information on XV commands and options, you can view the help documentation:

```powershell
xv --help
```

System Requirements:


Support:

If you encounter any issues or have questions, please refer to the official documentation or contact the support team.
[docs.xeo.vision](https://docs.xeo.vision)
