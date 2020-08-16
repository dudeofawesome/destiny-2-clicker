#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Constants
PressDelay := 500

RButton::
Enabled := !Enabled

Loop {
	if (Enabled = 0)
		break

	Send I
	Sleep PressDelay
	Send L
	Sleep PressDelay
}

stopProg() {
	ExitApp
}

Esc::stopProg()
