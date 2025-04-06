; made by salem, pls dont skid me im a shitty coder lol
; --- coordinates ---
repostX := 1699
repostY := 357
scrollX := 1336
scrollY := 585
coordDisplayOn := false  ; Track coordinate display state

F1:: ; confirm msg
    InputBox, user_input, Confirmation, Make sure your on your most recent repost!!`nType "Y" to proceed., , 300, 150
    if (user_input != "Y") {
        MsgBox, Cancelled.
        return
    }

    ; --- config ---
    SetTitleMatchMode, 2
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
    scrollDelay := 400
    maxLoops := 50

    Loop % maxLoops {
        ; --- Click remove repost --- 
        Click, %repostX%, %repostY%
        Sleep 1500

        ; --- Click scroll down ---
        Click, %scrollX%, %scrollY%
        Sleep %scrollDelay%
    }
    MsgBox, finished. exiting. 
return

; --- Change Coords (F3) ---
F3::
    InputBox, confirm, Confirm Changes, You are about to change coordinates.`n`n1. Hit F3 on repost button`n2. Then hit F3 on scroll button`nPress F5 to cancel current step`n`nDo you understand? (Y/N), , 450, 300
    if (confirm != "Y") {
        MsgBox, Coordinate change cancelled.
        return
    }

    Hotkey, F3, Off
    abort := false

    ; --- Repost Button ---
    ToolTip, [F3] Capture Repost | [F5] Skip 
    Loop {
        Sleep 50
        if (GetKeyState("F3", "P")) {
            MouseGetPos, repostX, repostY
            break
        }
        if (GetKeyState("F5", "P")) {
            abort := true
            break
        }
    }
    ToolTip
    if (abort) {
        MsgBox, Repost coordinate NOT changed.
        abort := false
    }

    ; --- Scroll Button ---
    ToolTip, [F3] Capture Scroll | [F5] Skip
    Loop {
        Sleep 50
        if (GetKeyState("F3", "P")) {
            MouseGetPos, scrollX, scrollY
            break
        }
        if (GetKeyState("F5", "P")) {
            abort := true
            break
        }
    }
    ToolTip

    Hotkey, F3, On
    MsgBox, Final coords:`nRepost: X%repostX% Y%repostY%`nScroll: X%scrollX% Y%scrollY%
return

; --- Toggle coordinate display (F2) --- 
F2::
    global coordDisplayOn
    coordDisplayOn := !coordDisplayOn  ; Toggle
    
    if (coordDisplayOn) {
        SetTimer, UpdateCoordDisplay, 1000
        ToolTip, Coordinate display ON
        Sleep 1000
        ToolTip
    } else {
        SetTimer, UpdateCoordDisplay, Off
        ToolTip
    }
return

UpdateCoordDisplay:
    CoordMode, ToolTip, Screen
    MouseGetPos, x, y
    ToolTip, X%x% Y%y%
return

^Esc::ExitApp ;CTRL + ESC
