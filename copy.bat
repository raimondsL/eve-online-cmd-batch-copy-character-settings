@echo off
SET FileMask=core_char_*

CD /D %LOCALAPPDATA%\CCP\EVE\
CD *tranquility
CD settings_Default

FOR /F %%I IN ('DIR %FileMask% /A-D /B /O-D /TW ^| FINDSTR /R %FileMask%[0-9][0-9][0-9][0-9][0-9]*\.dat$') DO (
    SET NewestFile=%%I
    GOTO FoundFile
)

ECHO No %FileMask% file found!
GOTO :EOF

:FoundFile
ECHO Newest file is: %NewestFile%

MD backup 2>nul
FOR /F %%F IN ('DIR %FileMask% /A-D /B ^| FINDSTR /R %FileMask%[0-9][0-9][0-9][0-9][0-9]*\.dat$ ^| FIND /V "%NewestFile%"') DO (
    XCOPY %%F backup /IY >nul
    XCOPY %NewestFile% %%F /UY
)

PAUSE
