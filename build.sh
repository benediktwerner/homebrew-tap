#!/bin/bash

set -euxo pipefail

# Sample script for building a .app bundle
# This doesn't work properly with AssetRipper version 1.x since it just launches a web server and opens a browser page

version=1.1.7

mkdir -p AssetRipper.app/Contents/MacOS
mkdir -p AssetRipper.app/Contents/Resources

mv AssetRipper_mac_arm64/* AssetRipper.app/Contents/MacOS/

wget "https://raw.githubusercontent.com/AssetRipper/AssetRipper/refs/tags/$version/Media/Images/LogoReimagined/LogoReimagined.png"
mkdir AssetRipper.iconset
sips -z 16 16     LogoReimagined.png --out AssetRipper.iconset/icon_16x16.png
sips -z 32 32     LogoReimagined.png --out AssetRipper.iconset/icon_16x16@2x.png
sips -z 32 32     LogoReimagined.png --out AssetRipper.iconset/icon_32x32.png
sips -z 64 64     LogoReimagined.png --out AssetRipper.iconset/icon_32x32@2x.png
sips -z 128 128   LogoReimagined.png --out AssetRipper.iconset/icon_128x128.png
sips -z 256 256   LogoReimagined.png --out AssetRipper.iconset/icon_128x128@2x.png
sips -z 256 256   LogoReimagined.png --out AssetRipper.iconset/icon_256x256.png
sips -z 512 512   LogoReimagined.png --out AssetRipper.iconset/icon_256x256@2x.png
sips -z 512 512   LogoReimagined.png --out AssetRipper.iconset/icon_512x512.png
sips -z 1024 1024 LogoReimagined.png --out AssetRipper.iconset/icon_512x512@2x.png
iconutil -c icns AssetRipper.iconset
mv AssetRipper.icns AssetRipper.app/Contents/Resources/

cat << EOF > AssetRipper.app/Contents/Info.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>CFBundleName</key>               <string>AssetRipper</string>
        <key>CFBundleExecutable</key>         <string>AssetRipper.GUI.Free</string>
        <key>CFBundleIdentifier</key>         <string>assetripper</string>
        <key>CFBundleIconFile</key>           <string>AssetRipper.icns</string>
        <key>CFBundleVersion</key>            <string>$version</string>
        <key>CFBundleShortVersionString</key> <string>$version</string>
        <key>NSHighResolutionCapable</key>    <string>True</string>
    </dict>
</plist>
EOF
