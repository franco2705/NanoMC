@echo off
setlocal EnableExtensions EnableDelayedExpansion
title NanoMC - Minecraft 1.8.9
color 02

set "ROOT=%~dp0"
set "MC_DIR=%ROOT%mcdata"
set "GAME_DIR=%MC_DIR%"
set "ASSETS_DIR=%MC_DIR%\assets"
set "NATIVES_DIR=%MC_DIR%\natives\1.8.9"
set "VERSION=1.8.9"
set "ASSETS_INDEX=1.8"
set "WIDTH=930"
set "HEIGHT=540"
set "JAVA_EXE=%MC_DIR%\java\bin\javaw.exe"

echo.
echo ============================
echo          NanoMC
echo      Minecraft 1.8.9
echo ============================
echo.

if not exist "%MC_DIR%" (
 echo [ERROR] mcdata folder was not found.
 pause
 exit /b 1
)
if not exist "%JAVA_EXE%" (
 echo [ERROR] Bundled Java was not found: %JAVA_EXE%
 pause
 exit /b 1
)
if not exist "%NATIVES_DIR%" (
 echo [ERROR] Native libraries were not found: %NATIVES_DIR%
 pause
 exit /b 1
)

set /p "PLAYER_NAME=Username: "
if not defined PLAYER_NAME set "PLAYER_NAME=Player"

rem Build the classpath from all bundled libraries.
set "CLASSPATH="
for /r "%MC_DIR%\libraries" %%F in (*.jar) do (
 if defined CLASSPATH (
  set "CLASSPATH=!CLASSPATH!;%%F"
 ) else (
  set "CLASSPATH=%%F"
 )
)

if exist "%MC_DIR%\versions\%VERSION%\%VERSION%.jar" (
 set "CLASSPATH=!CLASSPATH!;%MC_DIR%\versions\%VERSION%\%VERSION%.jar"
) else (
 echo [ERROR] Minecraft %VERSION% jar was not found.
 pause
 exit /b 1
)

echo Starting Minecraft...
cd /d "%MC_DIR%"

start "" "%JAVA_EXE%" ^
 -Xmx2G ^
 -Djava.library.path="%NATIVES_DIR%" ^
 -cp "!CLASSPATH!" ^
 net.minecraft.launchwrapper.Launch ^
 --username "%PLAYER_NAME%" ^
 --version "%VERSION%" ^
 --accessToken 0 ^
 --userProperties "{}" ^
 --gameDir "%GAME_DIR%" ^
 --assetsDir "%ASSETS_DIR%" ^
 --assetIndex "%ASSETS_INDEX%" ^
 --width %WIDTH% ^
 --height %HEIGHT% ^
 --tweakClass net.minecraftforge.fml.common.launcher.FMLTweaker

endlocal
