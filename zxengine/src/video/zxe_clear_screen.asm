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
;;  Clear the screen.
;;
zxe_clear_screen::
  ld    hl,   #0x4000               ;; Video memory, start address.
  ld    de,   #0x4001               ;; Next video memory address.
  ld    bc,   #0x17FF               ;; Video memory size, in bytes.
  ld    (hl), 0x00                  ;; Clear the first byte in video memory.
  ldir                              ;; Copy from Hl to DE, N times defined by BC.
  ret
