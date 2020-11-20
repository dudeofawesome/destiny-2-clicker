#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreadsPerHotkey 2 ; Allows the hotkey to toggle the reader

MOD_WIDTH := 126
MOD_SPACE_BETWEEN := 12
MOD_TOTAL := MOD_WIDTH + MOD_SPACE_BETWEEN
MOD_TRAY_WIDTH := 7
MOD_SLOT_Y_JUMP := 103

mod_slot_1 := 0
mod_slot_2 := 0
mod_slot_3 := 0
; mod_slot_1 := 2
; mod_slot_2 := 5
; mod_slot_3 := 3

mouse_origin_x := 0
mouse_origin_y := 0

#IfWinActive, Destiny 2
RButton::
  Enabled := !Enabled
  if (Enabled = 1) {
    InputBox, mod_slot_1, Mod Slot, Prey Mod Slot number from the left., , 240, 128
    InputBox, mod_slot_2, Mod Slot, Weak Mutation Slot number from the left. This is the one that will be duplicated., , 240, 160
    InputBox, mod_slot_3, Mod Slot, Strong Mutation Slot number from the left., , 250, 128

    mod_slot_1 := mod_slot_1 - 1
    mod_slot_2 := mod_slot_2 - 1
    mod_slot_3 := mod_slot_3 - 1

    MsgBox, 0, , Now position your mouse over the center of the Prey Mod Slot and hit enter.
    Sleep 100
    MouseGetPos, mouse_origin_x, mouse_origin_y
  }
#IfWinActive

Loop {
  WinGetActiveTitle, active_window
  if (Enabled = 1 and instr(active_window, "Destiny 2")) {
    ; Move mouse to origin position
    MouseMove, mouse_origin_x, mouse_origin_y
    Sleep 100

    ; Move mouse down to select a mod
    MouseMove, 0, MOD_TOTAL, , R
    ; Move mouse over the chosen mod
    MouseMove, mod_slot_1 * MOD_TOTAL, 0, , R
    SelectMod(1100)
    ; Move mouse back to mod slot
    MouseMove, -mod_slot_1 * MOD_TOTAL, -MOD_TOTAL, , R

    ; Move mouse to next slot
    MouseMove, MOD_TOTAL, 0, , R
    Sleep 100
    ; Move mouse down and left to select the first mod
    MouseMove, 0, MOD_TOTAL, , R
    MouseMove, -MOD_TOTAL, 0, , R
    ; Move mouse over the chosen mod
    y := Floor(mod_slot_2 / MOD_TRAY_WIDTH) * MOD_TOTAL
    x := (mod_slot_2 - y * MOD_TRAY_WIDTH) * MOD_TOTAL
    MouseMove, x, y, , R
    SelectMod(1100)
    ; Move mouse back to mod slot
    MouseMove, -x + MOD_TOTAL, -y - MOD_TOTAL, , R

    ; Move mouse to next slot
    MouseMove, MOD_TOTAL, 0, , R
    Sleep 100
    ; Move mouse down and left to select the first mod
    MouseMove, 0, MOD_TOTAL, , R
    MouseMove, -MOD_TOTAL * 2, 0, , R
    ; Move mouse over the chosen mod
    y := Floor(mod_slot_3 / MOD_TRAY_WIDTH) * MOD_TOTAL
    x := (mod_slot_3 - y * MOD_TRAY_WIDTH) * MOD_TOTAL
    MouseMove, x, y, , R
    SelectMod(1100)

    ; Wait for lure to update its state
    Sleep 250

    ; Move mouse to first mod (aka Reset Lure slot)
    MouseMove, -x, -y - MOD_SLOT_Y_JUMP, , R
    SelectMod(1100)

    ; Wait for lure to update its state
    Sleep 250
  }
}

SelectMod(delay) {
  Sleep 50
  MouseClick, left, 0, 0, 1, 0, D, R
  Sleep delay
  MouseClick, left, 0, 0, 1, 0, U, R
}
