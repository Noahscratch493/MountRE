@echo off
cls
setlocal EnableDelayedExpansion

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo You do not have Administrator privileges. Please run this batch file as Administrator.
    pause
    exit /b
)

:: Set safer temp drive letter (avoid X: since WinRE uses it internally)
set "drvLetter=R"

:MENU
cls
echo ==== MountRE - Windows Recovery Image Tool ====
echo.
echo 1. Mount Recovery Image
echo 2. Unmount Recovery Image
echo 3. Exit
echo.
set /p choice=Enter your choice (1, 2, or 3): 

if "%choice%"=="1" goto MOUNT
if "%choice%"=="2" goto UNMOUNT
if "%choice%"=="3" exit
echo Invalid choice.
pause
goto MENU

:MOUNT
:: Check if the drive letter is already mounted
if exist %drvLetter%:\ (
    echo Drive letter %drvLetter%: is already in use.
    echo Please change the script to use a different letter or free it manually.
    pause
    goto MENU
)

:: Assign recovery partition to the drive letter
echo Assigning %drvLetter%: to recovery partition...
(
    echo select disk 0
    echo select partition 4
    echo assign letter=%drvLetter%
) > diskpart.txt
diskpart /s diskpart.txt >nul
del diskpart.txt

if %errorlevel% neq 0 (
    echo Failed to assign the drive letter.
    pause
    goto MENU
)

mkdir %drvLetter%:\RE 2>nul
echo Mounting winre.wim...
dism /Mount-Wim /WimFile=\\?\GLOBALROOT\device\harddisk0\partition4\Recovery\WindowsRE\winre.wim /index:1 /MountDir=%drvLetter%:\RE
if %errorlevel% neq 0 (
    echo Failed to mount WinRE.
    rmdir /s /q %drvLetter%:\RE
    pause
    goto MENU
)

echo Recovery image successfully mounted to %drvLetter%:\RE
pause
goto MENU

:UNMOUNT
echo.
echo Choose how to unmount the image:
echo 1. Commit changes (save)
echo 2. Discard changes
set /p unmountChoice=Enter your choice (1 or 2): 

if "%unmountChoice%"=="1" (
    echo Committing changes...
    dism /Unmount-Wim /MountDir=%drvLetter%:\RE /Commit
) else if "%unmountChoice%"=="2" (
    echo Discarding changes...
    dism /Unmount-Wim /MountDir=%drvLetter%:\RE /Discard
) else (
    echo Invalid option. Cancelling unmount.
    pause
    goto MENU
)

if %errorlevel% neq 0 (
    echo Failed to unmount WinRE.
    pause
    goto MENU
)

rmdir /s /q %drvLetter%:\RE 2>nul
echo Unmounted successfully.

:: Remove drive letter
(
    echo select disk 0
    echo select partition 4
    echo remove letter=%drvLetter%
) > diskpart.txt
diskpart /s diskpart.txt >nul
del diskpart.txt

echo Drive letter %drvLetter%: removed.
pause
goto MENU
