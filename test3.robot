*** Variables ***
${WIADOMOSC}   to jest drugi update testu pokazujacy odwolanie sie do zmiennej

*** Test Cases ***
test pierwszy
   Log to console   udalo Ci sie puscic pierwszy test

test drugi odwolujacy sie do zmiennej
   Log to console   ${WIADOMOSC}

test trzeci pokazuje odwolanie sie do parametru
   komunikat   test3 dotyczacy keywords

*** Keywords ***
komunikat
   [ARGUMENTS]   ${KOMUNIKAT}
   Log to console   ${KOMUNIKAT}
