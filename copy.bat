@echo off
SET FileMask = core_char_*

CD %LOCALAPPDATA%\CCP\EVE\
FOR /F %%A IN ('DIR *tranquility* /B /AD') DO SET Tranquility=%%A
CD %Tranquility%

FOR /F %%I IN ('DIR %FileMask% /A-D /B /O-D /TW 2^>nul') DO (
    SET NewestFile=%%I
    GOTO FoundFile
)

ECHO No %FileMask% file found!
GOTO :EOF

:FoundFile
ECHO Newest %FileMask% file is: %NewestFile%

MD backup 2>nul
FOR /F %%F IN ('DIR %FileMask% /A-D /B ^| FIND /V "%NewestFile%"') DO (
	XCOPY %%F backup /IY >nul
    XCOPY %NewestFile% %%F /UY
)

PAUSE
