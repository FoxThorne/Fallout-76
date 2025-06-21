~r::
    CAfterX_Interrupt := 0
    SetTimer, PressC_AfterR, -2500
return

~e::
    CAfterX_Interrupt := 0
    SetTimer, PressC_AfterE, -2500
return

PressC_AfterR:
    if (CAfterX_Interrupt)
        return
    SendInput {c Down}
    Sleep, 20
    SendInput {c Up}
    if (SpamE) {
        GlobalInterrupt := 1
        SoundPlay, notification_pause.wav
        SetTimer, ResumeSpam, -5000
    }
return

PressC_AfterE:
    if (CAfterX_Interrupt)
        return
    SendInput {c Down}
    Sleep, 20
    SendInput {c Up}
return
