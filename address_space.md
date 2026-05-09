RX address space:

BANK 0 (BSH 0, BSL 0):
$0000-7FFF - Program memory
$4000-7FFF - Extra memory
$8000-BFFF - Output
    $8000-9FFF - VRAM
    $A001 - S5HA voice 1
    $A002 - S5HA voice 2
$C000-FFFF (Read) - RX ROM
$C001 (Write) - Bank select (Data bits 1-2)
$C002 (Write) - Colour select (Data bits 6-7)

BANK 1 (BSH 0, BSL 1):
$0000-7FFF - Program memory
$4000-7FFF - Extra memory
$8000-BFFF - Input
    $8000-9FFF - Keyboard register
    $A000-BFFF - I/O register
$C000-FFFF (Read) - RX ROM
$C001 (Write) - Bank select (Data bits 1-2)
$C002 (Write) - Colour select (Data bits 6-7)

BANK 2 (BSH 1, BSL 0):
$0000-3FFF - Program memory
$4000-BFFF - Drive
$C000-FFFF (Read) - RX ROM
$C001 (Write) - Bank select (Data bits 1-2)
$C002 (Write) - Colour select (Data bits 6-7)

BANK 3 (BSH 1, BSL 1):
$0000-3FFF - Program memory
$4000-BFFF - Storage
$C000-FFFF (Read) - RX ROM
$C001 (Write) - Bank select (Data bits 1-2)
$C002 (Write) - Colour select (Data bits 6-7)