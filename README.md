# Chmura Obliczeniowa Lab 5



## Table of Contents
- [Build](#build)
- [Screens](#screens)


## Build

Budowanie obrazu:

```bash
docker build -t <image_name> .  
```

Uruchamianie kontenera:
```bash
docker run -p 80:80 --name=<name> -e VERSION=v1.0 <image_name>
```

Sprawdzenie kontenera:
```bash
docker ps -a  
```


## Screens
Efekt działania aplikacji node.js

![Działająca aplikacja node](img%2Fpage_node.png)

Efekt działania aplikacji na nginx

![Zrzut ekranowy strony uruchomionej na nginx](img%2Fpage.png)!
