#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Constants
ClickHold := 3100
ClickDelay := 600

RButton::
Enabled := !Enabled

Loop {
	if (Enabled = 0)
		break

	MouseClick, left, 0, 0, 1, 0, D, R
	Sleep ClickHold
	MouseClick, left, 0, 0, 1, 0, U, R
	Sleep ClickDelay
}

stopProg() {
	MouseClick, left, 0, 0, 1, 0, U, R
	ExitApp
}

Esc::stopProg()
