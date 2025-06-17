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
