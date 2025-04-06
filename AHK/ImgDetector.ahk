; made by salem, pls dont skid me im a shitty coder lol
; thanks to sage for middle align check

F1:: ; confirm user on page
    InputBox, user_input, Confirmation, Make sure your on your most recent repost!!`nType "Y" to proceed., , 300, 150
    if (user_input != "Y") {
        MsgBox, Cancelled by user.
        return
    }

    ; --- image checks ---
    SetTitleMatchMode, 2
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window

    ; --- config ---
    scrollDelay := 400  ; --- scroll delay (IN MS NOT S) 1s = 1000ms ---
    searchAttempts := 3  ; --- retry search shit ---
    maxLoops := 50       ; --- how many reposts to remove ---

    Loop % maxLoops {
        Sleep 2000
        ; --- finds repost button ---
        if !ImageFound("Buttons\repost.png", foundX, foundY, searchAttempts) {
            MsgBox, No repost button found.
            return
        }
		
		; --- math shit to get the middle of the image ---
		repostCenterX := foundX + 13  ; 26/2 = 13
        repostCenterY := foundY + 13  ; 26/2 = 13
		
        ; --- clicks remove repost --- 
        Click, %repostCenterX%, %repostCenterY%
        Sleep 1500

		; --- Scroll button ---
        if !ImageFound("Buttons\scroll.png", scrollX, scrollY) {
            MsgBox, Scroll not found.
            return
        }
        
        ; --- math shit to get the middle of the image ---
        scrollCenterX := scrollX + 20  ; 41/2 = 20.5
        scrollCenterY := scrollY + 20  ; 41/2 = 20.5
        
        ; --- Click center ---
        Click, %scrollCenterX%, %scrollCenterY%
        Sleep %scrollDelay%
    }
    MsgBox, finished. exiting. 
return


; --- img search fix shit ---
ImageFound(imagePath, ByRef x, ByRef y, attempts:=3) {
    Loop % attempts {
        ImageSearch, x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, %imagePath%
        if (ErrorLevel = 0) {
            return true
        }
        Sleep 1000
    }
    return false
}


; --- coordinate shit, hit f2 to get your mouse coordinates --- 
F2:: 
    CoordMode, ToolTip, Screen
    Loop {
        MouseGetPos, x, y
        ToolTip, X%x% Y%y%
        Sleep 1000
    }
    return
^Esc::ExitApp
