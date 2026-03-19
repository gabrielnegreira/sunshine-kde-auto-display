# sunshine-kde-auto-display
This repo contains a set of scripts I use to make [Sunshine](https://github.com/LizardByte/Sunshine) automatically switch display resolution when streaming starts, matching the client's display settings.

## Requirements

- A dummy display plug is necessary. I use [this one](https://www.amazon.com.be/-/en/dp/B07C8C3364).
- [KDE-plasma](https://kde.org/plasma-desktop/) as desktop environment. I am personally using [fedora 43](http://fedoraproject.org/).
- Of course, [Sunshine](https://github.com/LizardByte/Sunshine) properly installed and running.

## Usage
1) clone the repo wherever you want and set permissions. Here I am cloning it in the `~/.local/bin` directory.
```sh
cd ~/.local/bin
git clone git@github.com:gabrielnegreira/sunshine-kde-auto-display.git
chmod -R 744 sunshine-kde-auto-display/
```

2) In kde-plasma, go to `settings -> Display & Monitor -> Display Configuration`. 
3) There, disable your dummy plug and make sure your main display is enabled. 
4) check your display names:
```sh
kscreen-doctor -o
```
You should see something like this:
```
Output: 1 DP-2 5b6c31d6-27ee-4b49-b0fa-8c93cac0da64
        disabled
        connected
        priority 2
        DisplayPort
        replication source:0
        Modes:  1:1920x1080@60.00!  2:4096x2160@29.97  3:4096x2160@24.00  4:3840x2160@60.00  5:3840x2160@29.97  6:3840x2160@25.00  7:3840x2160@23.98  8:2880x1800@30.02  9:2560x1600@59.97  10:2560x1440@59.95  11:1920x1200@59.88  12:1920x1080@119.88*  13:1920x1080@59.94  14:1920x1080@50.00  15:1920x1080@29.97  16:1920x1080@25.00  17:1920x1080@23.98  18:1600x1200@60.00  19:1680x1050@59.95  20:1600x900@60.00  21:1280x1024@60.02  22:1440x900@59.89  23:1366x768@59.79  24:1280x800@59.81  25:1280x720@59.94  26:1280x720@50.00  27:1024x768@60.00  28:800x600@60.32  29:720x576@50.00  30:720x480@59.94  31:640x480@59.94 
        Custom modes: None
        Geometry: 1707,0 1920x1080
        Scale: 1
        Rotation: 1
        Overscan: 0
        Vrr: Never
        RgbRange: unknown
        HDR: disabled
        Wide Color Gamut: disabled
        ICC profile: none
        Color profile source: sRGB
        Color power preference: prefer efficiency and performance
        Brightness control: supported, set to 100% and dimming to 100%
        Color resolution: unknown
        Allow EDR: unsupported
        Sharpness control: unsupported
        Automatic brightness: unsupported
Output: 2 DP-4 79c8e690-4dd4-49e8-ab27-c2bb467aef49
        enabled
        connected
        priority 1
        DisplayPort
        replication source:0
        Modes:  32:2560x1440@180.00*!  33:2560x1440@165.00  34:2560x1440@144.00  35:2560x1440@120.00  36:2560x1440@60.00  37:1920x1080@144.00  38:1920x1080@119.93  39:1920x1080@119.88  40:1920x1080@60.00  41:1920x1080@59.94  42:1920x1080@50.00  43:1920x1080@23.98  44:1280x1440@60.00  45:1680x1050@119.99  46:1680x1050@59.95  47:1600x900@60.00  48:1280x1024@75.03  49:1280x1024@60.02  50:1440x900@59.89  51:1152x864@75.00  52:1280x720@59.94  53:1280x720@50.00  54:1024x768@75.03  55:1024x768@70.07  56:1024x768@60.00  57:800x600@75.00  58:800x600@72.19  59:800x600@60.32  60:800x600@56.25  61:720x576@50.00  62:720x480@59.94  63:640x480@75.00  64:640x480@72.81  65:640x480@59.94  66:640x480@59.93 
        Custom modes: None
        Geometry: 0,0 1707x960
        Scale: 1.5
        Rotation: 1
        Overscan: 0
        Vrr: Always
        RgbRange: unknown
        HDR: enabled
                SDR brightness: 391 nits
                SDR gamut wideness: 0%
                Peak brightness: 456 nits, overridden with: 450 nits
                Max average brightness: 391 nits
                Min brightness: 0 nits
        Wide Color Gamut: enabled
        ICC profile: none
        Color profile source: sRGB
        Color power preference: prefer efficiency and performance
        Brightness control: supported, set to 100% and dimming to 100%
        DDC/CI: allowed
        Color resolution: unknown
        Allow EDR: unsupported
        Sharpness control: unsupported
        Automatic brightness: unsupported
```
Since the dummy display is disabled, we can know for sure that `Output 2` is my main display, with name `DP-4`, while `Output 1` (`DP-2`) is the disabled dummy display.

5) Edit both the `sunshine-do.sh` and the `sunshine-undo.sh` scripts to have the `MAIN_OUT` and `DUMMY_OUT` variables match your display names:
```sh
MAIN_OUT="DP-4"
DUMMY_OUT="DP-2"
```
6) Navigate to the Sunshine configuration page (https://localhost:47990/) and go to `Applications`. 
7) Select an application and click `Edit`.
8) Point the `Do Command` to the `sunshine-do.sh` script.
9) Point the `Undo Command` to the `sunshine-undo.sh` script. 
10) Hit `Save`. 

Now whenever that application is launched on Sunshine the `sunshine-do.sh` script will run. When the application is closed, the `sunshine-undo.sh` runs instead.

OBS: The resolution will only change if your dummy display plug supports it!
