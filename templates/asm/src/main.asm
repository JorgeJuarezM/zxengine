;;-----------------------------LICENSE NOTICE-----------------------------------
;; This file is part of ZXEngine https://github.com/JorgeJuarezM/zxengine
;; Copyright (C) 2025  Jorge Luis Juárez Mandujano (@JorgeJuarezM)

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.
;;------------------------------------------------------------------------------

.globl  zxe_clear_screen
.globl  zxe_draw_string

;;
;;  Application Entry Point.
;;
main:
    ;; Clear the screen.
    call  zxe_clear_screen

    ;; Load the string address in HL
    ld    hl, string

    ;; Draw the string.
    call  zxe_draw_string
    jr  .

;;
;;  Define the string to be drawed.
;;
string: .asciz "ZXEngine, Hello World!"