#!/usr/bin/bash

# Go to the script directory
cd "${0%/*}" 1> /dev/null 2> /dev/null

# Find an available version of img2gb or install install in a virtualenv if the
# executable is not in the current directory (requires Python)
IMG2GB=./img2gb.exe
if [ ! -f $IMG2GB ] ; then
    if [ ! -d __env__ ] ; then
        python3 --version \
            && PYTHON=python3 \
            || PYTHON=python
        $PYTHON -m venv __env__
        test -f __env__/bin/activate \
            && source __env__/bin/activate \
            || source __env__/Scripts/activate
        pip install img2gb
    else
        test -f __env__/bin/activate \
            && source __env__/bin/activate \
            || source __env__/Scripts/activate
    fi
    IMG2GB="python -m img2gb"
fi

$IMG2GB tileset \
    --output-c-file=../src/splashscreen.tileset.c \
    --output-header-file=../src/splashscreen.tileset.h \
    --output-image=../src/splashscreen.tileset.png \
    --deduplicate \
    --name=SPLASH_TS \
    ./splash.png

$IMG2GB tilemap \
    --output-c-file=../src/splashscreen.tilemap.c \
    --output-header-file=../src/splashscreen.tilemap.h \
    ../src/splashscreen.tileset.png \
    --name=SPLASH_TM \
    ./splash.png

$IMG2GB tileset \
    --output-c-file=../src/logo_rgb.tileset.c \
    --output-header-file=../src/logo_rgb.tileset.h \
    --output-image=../src/logo_rgb.tileset.png \
    --deduplicate \
    --name=LOGO_RGB_TS \
    ./logo/rgb_gb.v2.png

$IMG2GB tilemap \
    --output-c-file=../src/logo_rgb.tilemap.c \
    --output-header-file=../src/logo_rgb.tilemap.h \
    ../src/logo_rgb.tileset.png \
    --name=LOGO_RGB_TM \
    ./logo/rgb_gb.v2.png

$IMG2GB tileset \
    --output-c-file=../src/font.tileset.c \
    --output-header-file=../src/font.tileset.h \
    --name=FONT_TS \
    ./font.png

$IMG2GB tileset \
    --output-c-file=../src/studio.tileset.c \
    --output-header-file=../src/studio.tileset.h \
    --output-image=../src/studio.tileset.png \
    --deduplicate \
    --name=STUDIO_TS \
    ./studio/studio.png

$IMG2GB tilemap \
    --output-c-file=../src/studio.tilemap.c \
    --output-header-file=../src/studio.tilemap.h \
    ../src/studio.tileset.png \
    --name=STUDIO_TM \
    ./studio/studio.png
