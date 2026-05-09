collumn = $04
row = $05
tmp0 = $06
tmp1 = $07
tmp2 = $08
rowLow = $09
keyCode = $0a
menuSelected = $0b

BANK_REG = $c001
COLOUR_REG = $c002
VOICE_1_REG = $a000
VOICE_2_REG = $a001
KEY_REG = $8000

START
    org $c000

    LDA #0
    STA BANK_REG
    STA VOICE_1_REG
    STA VOICE_2_REG
    STA collumn
    LDA %11000000
    STA COLOUR_REG
    JSR CLEAR
    CLI
    LDA #$00
    STA $00
    LDA #$f0
    STA $01
    JSR PRINTSTR
    LDA #1
    STA menuSelected
MENU
    LDA #$5a
    CMP keyCode
    BEQ MENU_ENTER
    LDA #$e0
    CMP keyCode
    BNE MENU
MENU_e0
    LDA #$e0
    CMP keyCode
    BEQ MENU_e0
    LDA #$72
    CMP keyCode
    BEQ MENU_DOWN
    LDA #$75
    CMP keyCode
    BEQ MENU_UP
    JMP MENU

MENU_ENTER
    LDA #1
    CMP menuSelected
    BEQ BASIC_START
    LDA #2
    CMP menuSelected
    BEQ FILE_START
    JMP CART_LOAD
MENU_DOWN
    DEC menuSelected
    LDA menuSelected
    CMP #0
    BNE MENU
    LDA #3
    STA menuSelected
    JMP MENU
MENU_UP
    INC menuSelected
    LDA menuSelected
    CMP #4
    BNE MENU
    LDA #0
    STA menuSelected
    JMP MENU
    
BASIC_START
    JSR CLEAR
    LDA #$14
    STA $00
    LDA #$f0
    STA $01
    JSR PRINTSTR

FILE_START
    JSR CLEAR

CART_LOAD
    JSR CLEAR


PRINTSTR
    LDY #0
    LDA ($00),Y
    CMP #92
    BEQ PRINTSTR_END
    JSR PRINTC
PRINTSTR_END
    RTS

PRINTC
    SEI
    STA tmp0
    LDA #0
    STA rowLow
PRINTC_LOOP
    LDA tmp0
    ASL
    ASL
    ASL
    STA $00
    LDA tmp0
    LSR
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC $fb
    STA $01

    LDY rowLow
    LDA ($00),Y
    STA tmp1

    LDA rowLow
    ASL
    ASL
    ASL
    ASL
    ASL
    CLC
    ADC rowLow
    STA $00
    LDA row
    ADC $80
    STA $01

    SEI
    LDA #%00000000
    STA BANK_REG
    LDA tmp1
    LDY collumn
    STA ($00),Y
    CLI

    LDY rowLow
    INY
    TYA
    CMP #8
    BNE PRINTC_LOOP

    INC collumn

    CLI
    RTS    

CLEAR
    SEI
    LDA #0
    LDX #32
    LDY #0
    STY $00
    LDA #$80
    STA $01
CLEAR_LOOP
    STA ($00),Y
    INY
    BNE CLEAR_LOOP
    INC $01
    DEX
    BNE CLEAR_LOOP
    CLI
    RTS

KEY
    LDA #1
    STA BANK_REG
    LDA KEY_REG
    STA keyCode
    RTI

KEY_TO_ASCII
    LDX keyCode
    LDA $ef00,X
    STA keyCode
    RTS



    org $ef00
    text "abcdefghijklmnopqrstuvwxyz"

    org $f000

    text "RX-22 Home Computer\"
    text "RX BASIC\"
    text "File browser\"
    text "Loading from cartridge...\"

    org $fffc
    word START 
    word KEY
