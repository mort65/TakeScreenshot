#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#NoTrayIcon

#Include Gdip\Gdip_All.ahk

SplitPath A_WinDir,,,,,drive
path := drive "\Users\" A_UserName "\Pictures\Screenshots"
FileCreateDir % path
;ctrl+PrintScreen: Screenshot
^PrintScreen::
    CurrentDate := A_YYYY "-" A_MM "-" A_DD
    CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec
    Screenshot(path "\" CurrentDate "_" CurrentTime ".png")
Return
;shift+PrintScreen: Screenshot from the window
+PrintScreen::
    CurrentDate := A_YYYY "-" A_MM "-" A_DD
    CurrentTime := A_Hour "-" A_Min "-" A_Sec "." A_MSec
    Screenshot(path "\" CurrentDate "_" CurrentTime ".png", True)
Return

Screenshot(OutFile,bWindow=False)
{
    pToken := Gdip_Startup()
    if (bWindow)
    {
        WinGet, top_id, ID, A
        if (top_id="") 
        {
            WinGet, ids, List
            Loop, %ids%
            {
                this_id := ids%A_Index%
                if WinExist("ahk_id" . this_id)
                {
                    WinGetClass this_class, ahk_id %this_id%
                    if (this_class!="Shell_TrayWnd")
                    {
                        top_id := this_id
                        break
                    }
                }
            }
        }
        pBitmap := Gdip_BitmapFromHWND(top_id)
    }
    else {
        screen=0|0|%A_ScreenWidth%|%A_ScreenHeight%
        pBitmap := Gdip_BitmapFromScreen(screen)
    }
    Gdip_SaveBitmapToFile(pBitmap, OutFile, 100)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
}