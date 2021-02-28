*** Settings ***
Library   dodawanie.py
Library   odwracanie_stringa.py
Library   SSHLibrary
Library   SeleniumLibrary

*** Variables ***
${WIADOMOSC}   to jest drugi test pokazujacy odwolanie sie do zmiennej
${REMOTEHOST}   127.0.0.1
${REMOTE_USERNAME}   student
${REMOTE_PASSWORD}   tester
${BROWSER}   Firefox
${SELECTOR_USER}   //*[@id="login"]
${SELECTOR_PASSWD}  //*[@id="password"]
${SELECTOR_ZALOGUJ}   css:.nSubmit
${URL}   https://poczta.wp.pl
${USER_WP}   testerwsb_t1
${PASSWORD_WP}   adam1234

*** Test Cases ***
test pierwszy
   Log to console   udalo CI sie puscic pierwszy test

test drugi odwoluje sie do zmiennej
   lOG TO CONSOLE   ${WIADOMOSC}

test trzeci odwolujacy sie do parametru
   komunikat   test3 dotyczacy keywords

test czwarty wykorzystujacy skrypt pytona
   ${rezultat} =   dodawanie   Cho  mik
   Should Be Equal   ${rezultat}   Chomik

test piaty odwolujacy sie do funkcji w pythonie odwracajacej stringi
   ${odwrocony} =   odwracanie dowolnego stringa   Kitku
     Should Be Equal   ${odwrocony}   uktiK

test sprawdzajacy poprawnosc komendy na komputerze lokalnym
   Polaczenie z komputerem
   Wprowadzenie uzytkownika i hasla
   Wpisanie komendy i sprawdzenie czy poprawnie sie wykonala
   Wylogowanie sie, wylaczenie hosta
   
test sprawdzajacy polacznie internetowez hostem 8.8.8.8 na komputerze lokalnym
   Polaczenie z komputerem
   Wprowadzenie uzytkownika i hasla
   Weryfikacja polaczenia internetowego
   Wylogowanie sie, wylaczenie hosta

test laczacy sie do strony poczta.wp.pl z uzytkownikiem tester i wchodzacy do folderu odebrane
   otwarcie przegladarki
   polaczenie sie ze stron www.poczta.wp.pl
   wpisanie w okienko login loginu testerwsb_t1
   wpisanie w okienko haslo hasla adam1234
   klikniecie zaloguj
   klikniecie w odebrane
   zamkniecie przegladarki  

*** Keywords ***
komunikat
   [ARGUMENTS]   ${KOMUNIKAT}
   Log to console   ${KOMUNIKAT}

Polaczenie z komputerem
   Open Connection   ${REMOTE_HOST}
Wprowadzenie uzytkownika i hasla
   Login   ${REMOTE_USERNAME}   ${REMOTE_PASSWORD}
Wpisanie komendy i sprawdzenie czy poprawnie sie wykonala
   ${wynik_komendy} =   Execute Command   uname -a
   Should Contain   ${wynik_komendy}   GNU/Linux
Wylogowanie sie, wylaczenie hosta
   Close All Connections
Weryfikacja polaczenia internetowego
   ${wynik_pinga} =   Execute Command   ping -q -c1 8.8.8.8
   Should Contain   ${wynik_pinga}   1 received
   Should not contain   ${wynik_pinga}   100% packet loss

otwarcie przegladarki
   Open browser   about:blank   ${BROWSER}
polaczenie sie ze stron www.poczta.wp.pl
   Go to   ${URL}  
wpisanie w okienko login loginu testerwsb_t1
   Input text   ${SELECTOR_USER}   ${USER_WP} 
wpisanie w okienko haslo hasla adam1234
   Input text   ${SELECTOR_PASSWD}   ${PASSWORD_WP}
klikniecie zaloguj
   Click element   css:.nSubmit
klikniecie w odebrane
   sleep   20
   Page Should Contain   Odebrane
zamkniecie przegladarki
   Close All Browsers
