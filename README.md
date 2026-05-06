# YT Music Playlist MP3 Downloader

Small helper scripts for downloading a YT or YT Music playlist as MP3 files.

The scripts create a folder using the playlist name and save each track as:

```text
song title.mp3
```

They also ask `yt-dlp` to add metadata, embed thumbnails, and set the contributing artist from the video uploader.

## Files

```text
ytmusic_win.bat    Windows version
ytmusic_macos.sh  macOS / Linux shell version
```

## Requirements

You need these installed before running the scripts:

- `yt-dlp`
- `ffmpeg`

`yt-dlp` does the downloading. `ffmpeg` converts audio to MP3 and helps embed metadata/thumbnails.

## Install on Windows

### Option 1: Using winget

Open PowerShell or Command Prompt and run:

```powershell
winget install yt-dlp.yt-dlp
winget install Gyan.FFmpeg
```

Close and reopen your terminal after installation.

Check that both tools are available:

```powershell
yt-dlp --version
ffmpeg -version
```

### Option 2: Using Chocolatey

If you use Chocolatey:

```powershell
choco install yt-dlp ffmpeg
```

## Install on macOS

Install Homebrew first if you do not already have it:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install the required tools:

```bash
brew install yt-dlp ffmpeg
```

Check that both tools are available:

```bash
yt-dlp --version
ffmpeg -version
```

## How to Use on Windows

Double-click:

```text
ytmusic_win.bat
```

Or run it from Command Prompt:

```cmd
ytmusic_win.bat
```

Then paste a YT or YT Music playlist URL when prompted.

## How to Use on macOS

In Terminal, go to the project folder:

```bash
cd /path/to/ymdl
```

Make the script executable once:

```bash
chmod +x ytmusic_macos.sh
```

Run it:

```bash
./ytmusic_macos.sh
```

Then paste a YT or YT Music playlist URL when prompted.

## Output

For a playlist named `My Playlist`, files are saved like this:

```text
My Playlist/
  Song One.mp3
  Song Two.mp3
  Song Three.mp3
```

The scripts use the playlist title as the folder name. If no playlist title is found, the folder is named:

```text
Playlist
```

## Notes

- Private playlists may require browser cookies or login support through `yt-dlp`.
- Some videos may not have thumbnails or metadata available.
- Existing files can be overwritten because the scripts use `--force-overwrites`.
- File names come from YT video titles, so unusual characters in titles may affect the saved file names.

## Using Cookies

Some playlists or videos may require cookies, especially if they are private, age-restricted, region-restricted, or only available when you are signed in.

### Easiest Method: Read Cookies From Your Browser

This is usually the best option because you do not need to manually find or copy cookie values.

1. Open YT or YT Music in your browser.
2. Sign in to the account that can access the playlist.
3. Make sure the playlist works in the browser.
4. Close the browser if `yt-dlp` has trouble reading cookies.
5. Run `yt-dlp` with `--cookies-from-browser`.

`yt-dlp` can read cookies from your browser:

```bash
yt-dlp --cookies-from-browser chrome "PLAYLIST_URL"
```

Other common browser names:

```bash
yt-dlp --cookies-from-browser firefox "PLAYLIST_URL"
yt-dlp --cookies-from-browser edge "PLAYLIST_URL"
yt-dlp --cookies-from-browser safari "PLAYLIST_URL"
```

You can also use a `cookies.txt` file:

```bash
yt-dlp --cookies cookies.txt "PLAYLIST_URL"
```

### How to See Cookies in the Browser

You can inspect cookies directly in your browser, but this is mainly for checking that cookies exist. For downloading, prefer `--cookies-from-browser` or a `cookies.txt` export.

Chrome / Edge:

1. Open web
2. Sign in.
3. Press `F12` or right-click the page and choose `Inspect`.
4. Open the `Application` tab.
5. In the left sidebar, open `Storage` then `Cookies`.
6. Select web

Firefox:

1. Open web
2. Sign in.
3. Press `F12` or right-click the page and choose `Inspect`.
4. Open the `Storage` tab.
5. In the left sidebar, open `Cookies`.
6. Select the web domain.

Safari:

1. Open Safari settings.
2. Enable the developer menu if it is not already enabled.
3. Open web
4. Sign in.
5. Use the developer tools storage/cookies view to inspect cookies.

You normally do not need to copy individual cookie values manually.

### How to Get a cookies.txt File

If `--cookies-from-browser` does not work, export cookies to a Netscape-format `cookies.txt` file.

Common approach:

1. Install a trusted browser extension that exports cookies in `cookies.txt` / Netscape format.
2. Open web
3. Sign in to the account that can access the playlist.
4. Use the extension to export cookies for YT.
5. Save the file as `cookies.txt` in this project folder.
6. Run the script after adding `--cookies cookies.txt` to the `yt-dlp` command.

Important: only install cookie-export extensions you trust. A cookies file can give access to your logged-in browser session.

### Add Browser Cookies to the Windows Script

In `ytmusic_win.bat`, add this line to the `yt-dlp` command:

```cmd
  --cookies-from-browser chrome ^
```

Example:

```cmd
yt-dlp -f "bestaudio[ext=webm]/bestaudio" ^
  --cookies-from-browser chrome ^
  --extract-audio --audio-format mp3 --audio-quality 0 ^
  --add-metadata ^
  --embed-thumbnail ^
  --convert-thumbnails jpg ^
  --force-overwrites ^
  --parse-metadata "uploader:%%(meta_artist)s" ^
  -o "%PLNAME%\%%(title)s.%%(ext)s" ^
  "%PLAYLIST%"
```

### Add Browser Cookies to the macOS Script

In `ytmusic_macos.sh`, add this line to the `yt-dlp` command:

```bash
  --cookies-from-browser chrome \
```

Example:

```bash
yt-dlp -f "bestaudio[ext=webm]/bestaudio" \
  --cookies-from-browser chrome \
  --extract-audio --audio-format mp3 --audio-quality 0 \
  --add-metadata \
  --embed-thumbnail \
  --convert-thumbnails jpg \
  --force-overwrites \
  --parse-metadata "uploader:%(meta_artist)s" \
  -o "$PLNAME/%(title)s.%(ext)s" \
  "$PLAYLIST"
```

Replace `chrome` with your browser name if needed.

### Using a cookies.txt File

If you have a `cookies.txt` file in the project folder, use:

Windows:

```cmd
  --cookies cookies.txt ^
```

macOS:

```bash
  --cookies cookies.txt \
```

Do not share your cookies file. It can contain login/session data for your account.

## Updating yt-dlp

If downloads stop working, update `yt-dlp`.

Windows:

```powershell
yt-dlp -U
```

macOS with Homebrew:

```bash
brew upgrade yt-dlp
```

## Responsible Use

Use this project only for content you have the right to download and store. Respect YT's terms, artist rights, and copyright laws in your country.

## Regards

This project is meant to be a simple personal utility: paste a playlist link, wait a little, and get a clean MP3 folder with metadata. Keep it small, keep it useful, and keep `yt-dlp` updated.
# ymdl
