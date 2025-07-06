; *********************** Fallout 76 Hotkeys & Macros Script ***********************
Menu, Tray, Icon, C:\Program Files (x86)\Steam\steamapps\common\Fallout76\fallout76.exe, 1
#NoEnv
#MaxThreadsPerHotkey 3
SendMode Event
SetBatchLines -1
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

; Disable Windows keys in-game
#IfWinActive, ahk_class Fallout76
LWin::Return
RWin::Return

; ======================= HOTKEYS =======================
Pause::Pause

; ======================= GLOBAL FLAGS =======================
global SpamE := 0
global SpamR := 0
global SpamEnabled := 1
global GlobalInterrupt := 0

; *********************** Armor Naming Macros BEGIN ***********************
SetKeyDelay, 50, 50
^1::Send, {Text} Rustclaw Guard (Arm-L)
^2::Send, {Text} Rustclaw Guard (Arm-R)
^3::Send, {Text} Rustclaw Guard (Leg-L)
^4::Send, {Text} Rustclaw Guard (Leg-R)
^5::Send, {Text} Rustclaw Guard (Torso)
^6::Send, {Text} Rustclaw Guard (Helmet)
!1::Send, {Text} (Arm-L)
!2::Send, {Text} (Arm-R)
!3::Send, {Text} (Leg-L)
!4::Send, {Text} (Leg-R)
!5::Send, {Text} (Torso)
!6::Send, {Text} (Helmet)
; *********************** Armor Naming Macros END ***********************

; *********************** LOOT ALL THE THINGS!!! Begin ***********************
NumpadMult:: ; Toggle E-spam
    GlobalInterrupt := 0
    if (!SpamEnabled) {
        SpamEnabled := 1
        return
    }
    if (!SpamE) {
        if (SpamR) {
            SetTimer, PressRSpam, Off
            SetTimer, R_Spam_Reminder, Off
            SpamR := 0
            SoundPlay, notification_off.wav
        }
        SetTimer, PressESpam, 15
        SetTimer, E_Spam_Reminder, 1000
        SpamE := 1
        SoundPlay, notification_on.wav
    } else {
        SetTimer, PressESpam, Off
        SetTimer, E_Spam_Reminder, Off
        SpamE := 0
        SoundPlay, notification_off.wav
    }
return

PressESpam:
    if (GlobalInterrupt)
        return
    SendInput {e Down}
    Sleep, 20
    SendInput {e Up}
return

E_Spam_Reminder:
    if (GlobalInterrupt)
        return
    SoundPlay, notification_running.wav
return

ResumeSpam:
    GlobalInterrupt := 0
return

NumpadDiv:: ; Toggle R-spam
    GlobalInterrupt := 0
    if (!SpamEnabled) {
        SpamEnabled := 1
        return
    }
    if (!SpamR) {
        if (SpamE) {
            SetTimer, PressESpam, Off
            SetTimer, E_Spam_Reminder, Off
            SpamE := 0
            SoundPlay, notification_off.wav
        }
        SetTimer, PressRSpam, 15
        SetTimer, R_Spam_Reminder, 1000
        SpamR := 1
        SoundPlay, notification_on.wav
    } else {
        SetTimer, PressRSpam, Off
        SetTimer, R_Spam_Reminder, Off
        SpamR := 0
        SoundPlay, notification_off.wav
    }
return

PressRSpam:
    if (GlobalInterrupt)
        return
    SendInput {r Down}
    Sleep, 20
    SendInput {r Up}
return

R_Spam_Reminder:
    if (GlobalInterrupt)
        return
    SoundPlay, notification_running.wav
return

; *********************** H Spam Macro BEGIN ***********************
HSpamLock := 0
~h::
    if (HSpamLock || GlobalInterrupt)
        return
    HSpamLock := 1
    Loop, 6
    {
        if (GlobalInterrupt) {
            HSpamLock := 0
            return
        }
        SendInput {h Down}
        Sleep, 40
        SendInput {h Up}
        Sleep, 40
    }
    HSpamLock := 0
return
; *********************** H Spam Macro END ***********************

; *********************** Perk Loadout Manager Macros BEGIN ***********************
F1:: ; Loadout 1
    SendInput {Tab down}
    Sleep, 200
    SendInput {Tab up}
    Sleep, 1000
    SendInput {t down}
    Sleep, 200
    SendInput {t up}
    Sleep, 1000
    SendInput {1 down}
    Sleep, 200
    SendInput {1 up}
    Sleep, 1000
    SendInput {Tab down}
    Sleep, 200
    SendInput {Tab up}
return

F3:: ; Loadout 3
    SendInput {Tab down}
    Sleep, 200
    SendInput {Tab up}
    Sleep, 1000
    SendInput {t down}
    Sleep, 200
    SendInput {t up}
    Sleep, 1000
    SendInput {3 down}
    Sleep, 200
    SendInput {3 up}
    Sleep, 1000
    SendInput {Tab down}
    Sleep, 200
    SendInput {Tab up}
return

F6:: ; Loadout 6
    SendInput {Tab down}
    Sleep, 200
    SendInput {Tab up}
    Sleep, 1000
    SendInput {t down}
    Sleep, 200
    SendInput {t up}
    Sleep, 1000
    SendInput {6 down}
    Sleep, 200
    SendInput {6 up}
    Sleep, 1000
    SendInput {Tab down}
    Sleep, 200
    SendInput {Tab up}
return
; *********************** Perk Loadout Manager Macros END ***********************

; *********************** DISABLE ALL SPAM ON SPECIFIC KEYS BEGIN ***********************
~m::
~i::
~o::
~Tab::
~Esc::
    if (!GlobalInterrupt) {
        GlobalInterrupt := 1
        if (SpamEnabled) {
            SpamEnabled := 0
            change := 0
            if (SpamE) {
                SetTimer, PressESpam, Off
                SetTimer, E_Spam_Reminder, Off
                SpamE := 0
                change := 1
            }
            if (SpamR) {
                SetTimer, PressRSpam, Off
                SetTimer, R_Spam_Reminder, Off
                SpamR := 0
                change := 1
            }
            if (change) {
                ; Force key release to prevent stuck keys
                SendInput {e Up}
                SendInput {r Up}
                SoundPlay, notification_off.wav
            }
        }
    }
return
; *********************** DISABLE ALL SPAM ON M, TAB, or ESC END ***********************

#IfWinActive ; END OF FALLOUT76 CONTEXT
