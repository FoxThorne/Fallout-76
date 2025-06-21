; *********************** Fallout 76 Hotkeys & Macros Script ***********************

Menu, Tray, Icon, C:\Program Files (x86)\Steam\steamapps\common\Fallout76\fallout76.exe, 2
#NoEnv
#MaxThreadsPerHotkey 3
SendMode Event
SetBatchLines -1
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2
#IfWinActive, ahk_class Fallout76
LWin::Return
RWin::Return
#IfWinActive


; ======================= HOTKEYS =======================

Pause::Pause

; ======================= GLOBAL FLAGS =======================
global SpamE := 0
global SpamR := 0
global SpamEnabled := 1
global GlobalInterrupt := 0
global CAfterX_Interrupt := 0

; *********************** Armor Naming Macros BEGIN ***********************

^1::SendInput, (L-Leg)
^2::SendInput, (R-Leg)
^3::SendInput, (L-Arm)
^4::SendInput, (R-Arm)
^5::SendInput, (Torso)
^6::SendInput, (Helmet)

; *********************** Armor Naming Macros END ***********************

; *********************** LOOT ALL THE THINGS!!! Begin ***********************

NumpadMult::
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

NumpadDiv::
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

; *********************** C after "X" Macros BEGIN ***********************

~r::
    CAfterX_Interrupt := 0
    ; Pause E-spam immediately if running
    if (SpamE) {
        GlobalInterrupt := 1
        SoundPlay, notification_pause.wav
        SetTimer, ResumeSpam, -10000
    }
    SetTimer, PressC_AfterR, -3000
return

~e::
    CAfterX_Interrupt := 0
    SetTimer, PressC_AfterE, -3000
return

PressC_AfterR:
    if (CAfterX_Interrupt)
        return
    SoundBeep 750, 150  ; Beep when C fires
    SendInput {c Down}
    Sleep, 20
    SendInput {c Up}
return

PressC_AfterE:
    if (CAfterX_Interrupt)
        return
    SoundBeep 750, 150  ; Beep when C fires
    SendInput {c Down}
    Sleep, 20
    SendInput {c Up}
return

; Wildcard hotkey for any key except R and E - only affects C-after-X macros
~*a::
~*b::
~*d::
~*f::
~*g::
~*h::
~*i::
~*j::
~*k::
~*l::
~*m::
~*n::
~*o::
~*p::
~*q::
~*s::
~*t::
~*u::
~*v::
~*w::
~*x::
~*y::
~*z::
~*1::
~*2::
~*3::
~*4::
~*5::
~*6::
~*7::
~*8::
~*9::
~*0::
~*Space::
~*Shift::
~*Ctrl::
~*Alt::
~*LWin::
~*RWin::
~*Up::
~*Down::
~*Left::
~*Right::
~*Enter::
~*Esc::
    CAfterX_Interrupt := 1
return

; *********************** C after "X" Macros END ***********************

; *********************** Perk Loadout Manager Macros BEGIN ***********************

F1::
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

F3::
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

F6::
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

; *********************** DISABLE ALL SPAM ON M, TAB, or ESC BEGIN ***********************

~m::
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
            if (change)
                SoundPlay, notification_off.wav
        }
    }
return

; *********************** DISABLE ALL SPAM ON M, TAB, or ESC END ***********************
