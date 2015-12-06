Ta repozitorij je nastal tekom sekatona, ki je potekal na temo [zakonodajnega monitorja](http://www.zakonodajni-monitor.si/).

API je na voljo na [tem naslovu](http://www.zakonodajni-monitor.si/api).

Za inštalacijo paketa (ki ga še nisem čekiral, če se kompajla 100% ok) je najlažje:

```r
# install.packages("devtools") # poženeš samo enkrat
devtools::install_github("romunov/zakonodajalec")
library(zakonodajalec)
```

Rezultat klasificiranja procuderalnih izjav je na voljo v `/sandy/rezultat.html`.
