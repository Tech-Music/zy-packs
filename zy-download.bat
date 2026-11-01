@echo off
REM ============================================================
REM  zy data packs downloader for the offline HTML page
REM  Put this file in the SAME folder as the main HTML file
REM  (the folder that already has some zi-*.js files or is empty),
REM  then double-click it. All 15 extension packs will be
REM  downloaded from Gitee into this folder.
REM  After downloading, open the main HTML and refresh once.
REM ============================================================
setlocal
chcp 65001 >nul
set "BASE=https://gitee.com/Geek-Leo/zy-packs/raw/master"
set "FILES=zy-ext-1.js zy-ext-2.js zy-ext-3.js zy-ext2-1.js zy-ext2-2.js zy-ext2-3.js zy-seal-1.js zy-seal-2.js zy-seal-3.js zy-seal-4.js zy-vox-1.js zy-vox-2.js zy-vox-3.js zy-vox-4.js zy-vox-5.js"
where curl >nul 2>nul
if errorlevel 1 (
  echo [ERROR] curl.exe not found. Windows 10 1803+ ships with it.
  echo         Or download the packs manually from:
  echo         https://gitee.com/Geek-Leo/zy-packs
  pause
  exit /b 1
)
echo Downloading extension packs from Gitee ...
echo Folder: %CD%
echo.
set FAIL=0
for %%F in (%FILES%) do (
  if exist "%%F" (
    echo [SKIP] %%F already exists.
  ) else (
    echo [GET ] %%F ...
    curl -sS -L --fail -o "%%F" "%BASE%/%%F"
    if errorlevel 1 (
      echo [FAIL] %%F - please retry.
      if exist "%%F" del "%%F"
      set FAIL=1
    )
  )
)
echo.
if "%FAIL%"=="1" (
  echo Some downloads failed. Run this script again to retry missing files.
) else (
  echo All done. Open the main HTML file now. Extension packs load
  echo automatically from this folder - refresh the page once if asked.
)
pause
