#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, ignore 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#NoTrayIcon

#Include Gdip\Gdip_All.ahk

SplitPath A_WinDir,,,,,drive
path := drive "\Users\" A_UserName "\Pictures\Screenshots"
FileCreateDir % path
;ctrl+PrintScreen
^PrintScreen::
    CurrentDate := A_YYYY "-" A_MM "-" A_DD
    CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec
    Screenshot(path "\" CurrentDate "_" CurrentTime ".png")
Return

Screenshot(OutFile)
{
    pToken := Gdip_Startup()

    screen=0|0|%A_ScreenWidth%|%A_ScreenHeight%
    pBitmap := Gdip_BitmapFromScreen(screen)

    Gdip_SaveBitmapToFile(pBitmap, OutFile, 100)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
}