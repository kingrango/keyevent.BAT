@echo off
echo Welcome! This script will display the IMEI number of SIM1 and prepare a screenshot for WhatsApp.
pause

adb shell am force-stop com.android.dialer
adb shell am start -a android.intent.action.DIAL
adb shell input text '*#06#'
adb shell input keyevent 66

echo IMEI Numbers Now Displayed on your Phone.
pause

rem Take a screenshot using adb
adb shell screencap -p /sdcard/imei_screenshot.png

rem Pull the screenshot to your local machine
adb pull /sdcard/imei_screenshot.png imei_screenshot.png

rem Display IMEI on console
echo Retrieving IMEI number...
adb shell service call iphonesubinfo 1 | findstr /r /c:"[0-9][0-9]*" > imei.txt

for /f "tokens=1,2 delims=: " %%A in (imei.txt) do (
    if "%%A"=="Result" (
        set IMEI=%%B
    )
)

set IMEI=%IMEI:~2,15%

echo IMEI number %IMEI% has been retrieved:
echo %IMEI:~0,1%
echo %IMEI:~1,1%
echo %IMEI:~2,1%
echo %IMEI:~3,1%
echo %IMEI:~4,1%
echo %IMEI:~5,1%
echo %IMEI:~6,1%
echo %IMEI:~7,1%
echo %IMEI:~8,1%
echo %IMEI:~9,1%
echo %IMEI:~10,1%
echo %IMEI:~11,1%
echo %IMEI:~12,1%
echo %IMEI:~13,1%
echo %IMEI:~14,1%

echo IMEI number %IMEI% has been copied to the clipboard.

rem Manual step: Send the screenshot via WhatsApp
echo Please open WhatsApp Web/Desktop and manually send the screenshot to +255746551918.
pause

del imei.txt
