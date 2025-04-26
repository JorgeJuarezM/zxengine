main:
    call clear_screen
    call print
    jr  .


clear_screen:
  ld    hl, #0x4000
  ld    de, #0x4001
  ld    bc, #0x17FF

  ld    (hl), 0x00
  ldir
  ret


print:
  ld    hl, #string
loop:
  ld    a,  (hl)
  cp    #0x00
  jp    z,  #fin
  rst   #0x10
  inc   hl
  jp    loop
fin:
  ret


string: .asciz "ZXEngine, Hello World!"