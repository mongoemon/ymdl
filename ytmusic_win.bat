@echo off
setlocal
echo ============================================
echo   YouTube Playlist MP3 Downloader
echo   Folder: playlist name
echo   File:   song title.mp3
echo   Title:  video title
echo   Contributing Artist: uploader
echo   Album:  album name (from YouTube Music)
echo ============================================
echo.
set /p PLAYLIST=Paste your playlist URL here: 

echo.
echo Getting playlist name...
echo.
rem Get playlist title from yt-dlp
for /f "delims=" %%A in ('yt-dlp --print "%%(playlist_title)s" "%PLAYLIST%"') do (
    set "PLNAME=%%A"
    goto :gotname
)

:gotname
if "%PLNAME%"=="" set "PLNAME=Playlist"

echo Playlist detected: %PLNAME%
echo.
mkdir "%PLNAME%" 2>nul

echo Download folder:
echo %cd%\%PLNAME%
echo.

echo Starting download...
echo.

yt-dlp -f "bestaudio[ext=webm]/bestaudio" ^
  --extract-audio --audio-format mp3 --audio-quality 0 ^
  --add-metadata ^
  --embed-thumbnail ^
  --convert-thumbnails jpg ^
  --force-overwrites ^
  --parse-metadata "uploader:%%(meta_artist)s" ^
  -o "%PLNAME%\%%(title)s.%%(ext)s" ^
  "%PLAYLIST%"

echo.
echo ✅ DONE!
echo Files saved in:
echo %cd%\%PLNAME%
endlocal
pause