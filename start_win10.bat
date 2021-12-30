@echo off
echo:
echo [93m[ BanRX Quick Setup ] for [96mWindows 10[0m
echo:

if not exist payload\ (
    echo [91mMiner not found... downloading[0m
    bitsadmin /transfer mydownloadjob /download /priority FOREGROUND "https://github.com/xmrig/xmrig/releases/download/v6.16.2/xmrig-6.16.2-gcc-win64.zip" "%cd%/payload.zip"
    mkdir payload
    tar -xf payload.zip -C payload
)

echo [92mMiner installed... starting miner[0m

for /d %%d in (payload/xmrig*.*) do (
    cd payload/%%d
)

if defined BAN_ADDRESS (
    goto update_prompt
) else (
    goto update_address
)

:update_prompt
    echo:
    set use_current=
    echo [93mCurrent BAN address: [4m[97m%BAN_ADDRESS%[93m[0m
    set /p use_current=[93mDo you want to mine to your current address? (y/n) [0m
    if %use_current%==n (
        goto update_address
    ) else (
        set address=%BAN_ADDRESS%
        goto start_mining
    ) 

:update_address
    echo:
    set address=
    set /p address=[91mType your BAN address: [0m
    setx BAN_ADDRESS %address% >nul
    goto start_mining

:start_mining
    echo:
    echo [91mYou must leave this window open whilst mining.[0m
    echo [92mPress enter to start mining![0m
    pause >nul
    echo:
    xmrig.exe --coin=XMR -o xmr.bananoplanet.cc:3333 -u %address%
	pause
