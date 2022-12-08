# WarCraft 3

Mindenkinél volt egy olyan játék, amelyre visszagondolva nosztalgiaérzés fogja el. Nálam a Warcraft 3 pont ilyen. A játék maga a stratégián alapul. Bázist kell építeni, annak érdekében, hogy a legnagyobb fölényre tegyünk szert. Ezt a koncepciót kicsit átgondolva jött létre a beadandó feladata.

Halmaz:

- Napok száma

Adott paraméterek:

- Épület felépítéséhez szükséges arany
- Épület felépítéséhez szükséges idő
- Épület értéke a felépítés után
- Bányászásért kapott arany
- Bányászás időtartama
- Munkások száma
- Játék maximális időtartama

Változók:

- Hány munkás épít egy időben
- Hány munkás bányászik egy időben
- Birtokolt arany a nap végén

Játék menete:

A játék lényege az lenne, hogy mielőtt a játék véget érne, addigra a legtöbb értékkel rendelkező bázist építsük fel.
Korlátás jött létre annak érdekében, hogy a munkásoknak kell bányászniuk vagy építeniük. Ha bányásznak és megépült a Lumber Mill épület, akkor további aranyat tudnak bányászni. Építeni csak a kibányászott aranyból lehet, és nincsen kezdeti arany. Végül pedig meg van adva, hogy mennyi idő áll rendelkezésre.
