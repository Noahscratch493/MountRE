# MountRE

**MountRE** is a utility that allows you to mount the **Windows Recovery Environment (WinRE)** recovery image and interact with its files directly within your normal Windows environment. This enables you to access WinRE tools, retrieve files from the recovery partition, or even perform certain recovery tasks without needing to reboot into WinRE.

## Features
- Mount the WinRE recovery partition and access its files directly.
- Access essential tools like **Backup Notepad**, **startrep.exe**, and more.
- Open the WinRE tools without the need to reboot into the recovery environment.
- Simple and easy-to-use batch script.

## Requirements
- **Administrator Privileges**: This tool requires administrative rights to mount and unmount the recovery partition.
  
## Installation

1. **Copy `mountre.bat` to `C:\Windows\System32`**:
   - This will allow you to run the `mountre` script from any Command Prompt or PowerShell window without needing to navigate to its directory.

2. **Ensure you run the script as Administrator**:
   - Right-click on the `mountre.bat` file and select **Run as Administrator** when using it.
   - You can also **pin it to the Start Menu or Taskbar** for quicker access.

## Usage

1. **Open Command Prompt or PowerShell**.
2. Type `mountre` and press **Enter**.
3. The script will provide you with options:
   - **Option 1**: Mount the WinRE image and access its contents.
   - **Option 2**: Unmount the recovery image and clean up.
   - **Option 3**: **Exit the script**.

### Steps:
- **Run the script** by typing `mountre` in any Command Prompt or PowerShell window.
- You will be prompted with options to mount the recovery image, unmount it, or exit the script.
- Select the option you want, and follow any additional prompts to complete the task.

## Admin Privileges

**MountRE** requires administrator privileges to function properly.

### Running as Administrator:
- **Right-click** the `mountre.bat` file and choose **Run as Administrator**.

## Troubleshooting

- **"You do not have Administrator privileges"**: Ensure that you're running the script as an administrator.

## License

This project is licensed under the MIT License.
