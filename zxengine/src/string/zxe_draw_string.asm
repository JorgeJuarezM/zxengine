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
;;
;;  Draws a string on the screen.
;;  Input:
;;      HL  => Address where the string is stored.
;;
zxe_draw_string::
  ld    a,    (hl)                  ;;  Load the current character.
  cp    #0x00                       ;;  Compare to know if the string has finished.
  jp    z,   end_draw_string        ;;  Jump to end if string has finished.
  rst   #0x10                       ;;  Call the print interruption.
  inc   hl                          ;;  Get next character address.
  jp    zxe_draw_string             ;;  Continue printing.

end_draw_string:
  ret                               ;;  Done.