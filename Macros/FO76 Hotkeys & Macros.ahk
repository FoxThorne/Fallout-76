; *********************** Header - some configuration  ***********************
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2
#IfWinActive, ahk_class Fallout76

; *********************** Fallout76 Armor Naming Macros ***********************
    ^1::Send, Armor (L-Leg)
    ^2::Send, Armor (R-Leg)
    ^3::Send, Armor (L-Arm)
    ^4::Send, Armor (R-Arm)
    ^5::Send, Armor (Torso)
    ^6::Send, Armor (Helmet)

; *********************** E Spam Toggle ***********************
SpamE := 0  ; Toggle state tracker

NumpadMult::
    SpamE := !SpamE  ; Flip state
    if SpamE {
        SetTimer, PressE, 50  ; Spam every 50ms (adjust this number as needed)
    } else {
        SetTimer, PressE, Off
    }
return

PressE:
    Send, {e down}
    Sleep, 20  ; Short press duration
    Send, {e up}
return

; *********************** R Spam Toggle, useful for collecting Toxic Water ***********************
SpamR := 0  ; Toggle state tracker

NumpadDiv::
    SpamR := !SpamR  ; Flip state
    if SpamR {
        SetTimer, PressR, 50  ; Spam every 50ms (adjust as needed)
    } else {
        SetTimer, PressR, Off
    }
return

PressR:
    Send, {r down}
    Sleep, 20  ; Short keypress duration
    Send, {r up}
return

; *********************** Press "C" when "R" or "E" is pressed, this is a workaround for the o-matic add-ons that have trouble with the "New" tab ***********************

~r::
    SetTimer, PressC_AfterR, -1500  ; One-shot timer, triggers once
return

~e::
    SetTimer, PressC_AfterR, -1500  ; One-shot timer, triggers once
return

PressC_AfterR:
    Send, {c down}
    Sleep, 50
    Send, {c up}
return


; *********************** Perk Loadout Manager Macros ***********************
F1:: ; Loadout 1
    Send {Tab down}
    Sleep, 200
    Send {Tab up}
    Sleep, 1000
    Send {t down}
    Sleep, 200
    Send {t up}
    Sleep, 1000
    Send {1 down}
    Sleep, 200
    Send {1 up}
    Sleep, 1000
    Send {Tab down}
    Sleep, 200
    Send {Tab up}
return

F3:: ; Loadout 3
    Send {Tab down}
    Sleep, 200
    Send {Tab up}
    Sleep, 1000
    Send {t down}
    Sleep, 200
    Send {t up}
    Sleep, 1000
    Send {3 down}
    Sleep, 200
    Send {3 up}
    Sleep, 1000
    Send {Tab down}
    Sleep, 200
    Send {Tab up}
return

F6:: ; Loadout 6
    Send {Tab down}
    Sleep, 200
    Send {Tab up}
    Sleep, 1000
    Send {t down}
    Sleep, 200
    Send {t up}
    Sleep, 1000
    Send {6 down}
    Sleep, 200
    Send {6 up}
    Sleep, 1000
    Send {Tab down}
    Sleep, 200
    Send {Tab up}
return
