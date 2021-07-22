#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; =========== USAGE ===========
; 1. Place your cursor over the "Increase Reputation" token button
; 2. Right click
; 3. Check postmaster after 21 deposits

; Constants
TokenClickDelay := 716
EngramClickDelay := 1100
ResetDelay := 2300
EngramOffsetX := 610
EngramOffsetY := -186

deposits_to_go := 21

RButton::
Enabled := !Enabled

Loop {
	if (Enabled = 0)
		break
	if (deposits_to_go < 1) {
		SoundPlay, *16
		stopProg()
	}

	Sleep 100
	MouseClick, left, 0, 0, 1, 0, , R
	Sleep TokenClickDelay
	MouseClick, left, 0, 0, 1, 0, , R
	Sleep EngramClickDelay - 100
	MouseMove, EngramOffsetX, EngramOffsetY, , R
	Sleep 100
	MouseClick, left, 0, 0, 1, 0, , R
	Sleep ResetDelay / 2
	MouseMove, -EngramOffsetX, -EngramOffsetY, , R
	Sleep ResetDelay / 2

	deposits_to_go := deposits_to_go - 1
}

stopProg() {
	; Release the mouse in case it's still held down
	MouseClick, left, 0, 0, 1, 0, U, R
	ExitApp
}

Esc::stopProg()
