# xv - xeoVision services in the command line!

## Windows Installation Guide

### Installation

#### 1. `Open Terminal` (PowerShell preferred) and download and execute the installation script by:

```powershell
irm https://raw.githubusercontent.com/mmilian/xv/refs/heads/main/install.ps1 | iex
```
<details>
  <summary>Alternatively (step by step) </summary>
1. Download and review the script:

```powershell
# Download the script
irm https://raw.githubusercontent.com/mmilian/xv/refs/heads/main/install.ps1 -OutFile install.ps1
# Review the script
notepad install.ps1
# Execute the script
.\install.ps1
```
</details>

#### 2. Set XEO_TOKEN environment variable

In PowerShell (Permanently for Current User):

```powershell
[Environment]::SetEnvironmentVariable("XEO_TOKEN", "<your_token_here>", "User")
```

<details>
  <summary>Alternatively </summary>

In PowerShell (Current Session):

```powershell
$env:XEO_TOKEN="<your_token_here>"
```

In Windows CMD (Permanently for Current User):

```cmd
setx XEO_TOKEN="<your_token_here>""
```

After using setx, restart your terminal or log off and log back in to apply the changes.

In Windows CMD (Current Session):

```cmd
set XEO_TOKEN="<your_token_here>"
```


</details>

#### 3. `Restart the Terminal` to ensure that any environment variable changes take effect.


> [!WARNING] 
> Do not have XEO_TOKEN? Go to [docs.xeo.vision](https://xeo.vision)


#### 4. Ready to Start

```powershell
xv convert https://raw.githubusercontent.com/xeokit/xeokit-sdk/master/assets/models/ifc/Duplex.ifc --type ifc-xkt --artifact
```

<details>
<summary>Explanation:</summary>

- xv convert \<url>  initiates the conversion process with specifies IFC file (from the web).
- --type ifc-xkt     sets the output format to xkt.
- --artifact         drops artifacts to local folder.
- --log              drops logs to local folder.

</details>

### Uninstallation

#### 1. Open PowerShell

Run the uninstall script with execution policy bypassed for this command only

```powershell
powershell -ExecutionPolicy Bypass -File "$HOME\.xv\uninstall.ps1"
```

Note:

If XV was installed in a different directory, replace $HOME\\.xv\uninstall.ps1 with the correct path.
There is no need to change the directory; the command specifies the full path to the uninstall script.
Additional Information
Help and Documentation:

## Usage

For more information on XV commands and options, you can view the help documentation:

```powershell
xv --help
```

or check [docs.xeo.vision](https://docs.xeo.vision)

## Support:

If you encounter any issues or have questions, please refer to the official documentation or contact the support team.
[docs.xeo.vision](https://docs.xeo.vision)
