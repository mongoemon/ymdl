#!/usr/bin/env bash

set -e

echo "============================================"
echo "  YouTube Playlist MP3 Downloader"
echo "  Folder: playlist name"
echo "  File:   song title.mp3"
echo "  Title:  video title"
echo "  Contributing Artist: uploader"
echo "  Album:  album name (from YouTube Music)"
echo "============================================"
echo

read -r -p "Paste your playlist URL here: " PLAYLIST

echo
echo "Getting playlist name..."
echo

PLNAME="$(yt-dlp --print "%(playlist_title)s" "$PLAYLIST" | sed -n '1p')"

if [ -z "$PLNAME" ]; then
  PLNAME="Playlist"
fi

echo "Playlist detected: $PLNAME"
echo
mkdir -p "$PLNAME"

echo "Download folder:"
echo "$(pwd)/$PLNAME"
echo

echo "Starting download..."
echo

yt-dlp -f "bestaudio[ext=webm]/bestaudio" \
  --extract-audio --audio-format mp3 --audio-quality 0 \
  --add-metadata \
  --embed-thumbnail \
  --convert-thumbnails jpg \
  --force-overwrites \
  --parse-metadata "uploader:%(meta_artist)s" \
  -o "$PLNAME/%(title)s.%(ext)s" \
  "$PLAYLIST"

echo
echo "DONE!"
echo "Files saved in:"
echo "$(pwd)/$PLNAME"
echo
read -r -p "Press Enter to exit..."
