@echo off
:START
cls
echo *************************************
echo * FROM OTHER SUNS Save Scummer v0.1 *
echo *************************************
echo.

if exist SaveGames\.multi.txt (
	type SaveGames\.multi.txt
) else (
	if exist SaveGames\.single.txt (
		type SaveGames\.single.txt
	) else (
		echo Cannot determine save directory mode, please switch to singleplayer or multiplayer to create mode files
	)
)

echo Options:
echo.   
echo 1. Save game
echo 2. Restore game
echo 3. Switch saves to singleplayer
echo 4. Switch saves to multiplayer
echo 5. Exit
echo.
choice /C 12345 /M "Please select option number"

if ERRORLEVEL 5 GOTO :SCUM_NO_MOAR
if ERRORLEVEL 4 GOTO :MULTIPLAYER
if ERRORLEVEL 3 GOTO :SINGLEPLAYER
if ERRORLEVEL 2 GOTO :RESTORE_GAME
if ERRORLEVEL 1 GOTO :SAVE_GAME
if ERRORLEVEL 0 GOTO :SCUM_NO_MOAR

GOTO :START

:SAVE_GAME
echo Preparing to save game
cd SaveGames
echo Backing up current saves
copy scum_save_0.sav scum_save_0.bak
copy scum_save_1.sav scum_save_1.bak
copy scum_save_2.sav scum_save_2.bak
echo Copying saves
copy save_0.sav scum_save_0.sav
copy save_1.sav scum_save_1.sav
copy save_2.sav scum_save_2.sav
echo Copying profile
copy profile_save.sav profile_save_backup.sav
copy profile.sav profile_save.sav
cd ..
pause
GOTO :START

:RESTORE_GAME
echo Preparing to restore game
cd SaveGames
copy scum_save_0.sav save_0.sav
copy scum_save_1.sav save_1.sav
copy scum_save_2.sav save_2.sav
copy profile_save.sav profile.sav
cd ..
pause
GOTO :START

:SINGLEPLAYER
echo Switching to your singleplayer saves
mkdir SaveGames_multi 2>NUL 1>NUL
mkdir SaveGames_multi_backup 2>NUL 1>NUL
REM Backing up current multi dir
copy SaveGames_multi\* SaveGames_multi_backup\
REM Copying main saves to multi dir
copy SaveGames\* SaveGames_multi\
echo Multiplayer mode > SaveGames_multi\.multi.txt

REM Erasing current saves
del /Q SaveGames\*
REM Copying singleplayer saves to main save dir
copy SaveGames_single\* SaveGames\
pause
GOTO :START

:MULTIPLAYER
echo Switching to your multiplayer saves
mkdir SaveGames_single 2>NUL 1>NUL
mkdir SaveGames_single_backup 2>NUL 1>NUL
REM Backing up current single dir
copy SaveGames_single\* SaveGames_single_backup\
REM Copying main saves to single dir
copy SaveGames\* SaveGames_single\
echo Singleplayer mode > SaveGames_single\.single.txt
REM Erasing current saves
del /Q SaveGames\*
REM Copying multiplayer saves to main save dir
copy SaveGames_multi\* SaveGames\
pause
GOTO :START

:SCUM_NO_MOAR
exit /B