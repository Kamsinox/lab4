# Sprawozdanie z labolatorium nr 4

Link do DockerHuba: https://hub.docker.com/u/kamsinox

Zadanie obowiązkowe
-
* Uruchomienie kontenera z repozytrium obrazów: </br>

``` docker run -d -p 5000:5000 --restart always --name registry registry:2 ```

![Zrzut ekranu 2022-11-16 200709](https://user-images.githubusercontent.com/92575198/202275870-500b7754-b45e-4763-a086-4e0eb75c3c94.png)

* Budowa obrazu lokalnie 
Przesyłanie obrazu i cache oddzielnie:
``` 
buildctl build 
--frontend=gateway.v0 
--opt source=docker/dockerfile 
--local context=. 
--local dockerfile=. 
--output type=image,name=localhost:5000/localrepository:Lab4,push=true 
--export-cache type=registry,ref=localhost:5000/localrepository:Lab4 
```

![Zrzut ekranu 2022-11-16 201611](https://user-images.githubusercontent.com/92575198/202276386-d6ae7fb4-44aa-49db-920b-1955e19598ee.png)

Czyszczenie cache: </br>

``` buildctl prune ```

![Zrzut ekranu 2022-11-16 201655](https://user-images.githubusercontent.com/92575198/202276549-9857fb6b-f884-4338-ad19-5108153c776b.png)

Ponowne zbudowanie obrazu korzystając z zapisanych wcześniej danych:
``` 
buildctl build 
--frontend=gateway.v0 
--opt source=docker/dockerfile 
--local context=. 
--local dockerfile=. 
--output type=image,name=localhost:5000/localrepository:Lab4,push=true 
--import-cache type=registry,ref=localhost:5000/localrepository:Lab4
```

![Zrzut ekranu 2022-11-16 201810](https://user-images.githubusercontent.com/92575198/202276964-7200f22a-416a-48aa-933f-87436b177275.png)

* Budowa obrazu w oparciu o publiczne repozytorium na platformę DockerHub
Przesyłanie obrazu i cache oddzielnie:
```
buildctl build 
--frontend=gateway.v0 
--opt source=docker/dockerfile 
--local context=. 
--local dockerfile=. 
--output type=image,name=docker.io/kamsinox/lab4:dockerhublab4,push=true 
--export-cache type=registry,ref=docker.io/kamsinox/lab4:dockerhublab4
```

![Zrzut ekranu 2022-11-16 202140](https://user-images.githubusercontent.com/92575198/202277300-ebea7f43-020f-4c6e-8b7d-923eb87daa0d.png)

Czyszczenie cache: </br>

``` buildctl prune ```

![Zrzut ekranu 2022-11-16 202203](https://user-images.githubusercontent.com/92575198/202277414-e06e830c-8cb1-46bd-9f87-638687d95481.png)

Ponowne zbudowanie obrazu korzystając z zapisanych wcześniej danych:
``` 
buildctl build 
--frontend=gateway.v0 
--opt source=docker/dockerfile 
--local context=. 
--local dockerfile=. 
--output type=image,name=docker.io/kamsinox/lab4:dockerhublab4,push=true 
--import-cache type=registry,ref=docker.io/kamsinox/lab4:dockerhublab4
```

![Zrzut ekranu 2022-11-16 202254](https://user-images.githubusercontent.com/92575198/202277560-b2214ce6-b7d9-41f2-95e2-a1159d912785.png)


Zadania dodatkowe
-
Test3
-
Żeby użyć pliku Dockerfile, który nie ma nazwy domyślnej "Dockerfile" używamy polecenia : ``` --opt filename=nazwapliku ```. </br>
Dla pliku "Dockerfile_test", korzystając z buildkita, tworzymy obraz o nazwie "test3" i przesyłamy do reporzytorium na DockerHuba:
``` 
buildctl build 
--ssh default=/mnt/c/Users/kamsinox/.ssh/id_ed25519 
--frontend=dockerfile.v0 
--local context=. 
--local dockerfile=. 
--opt filename=Dockerfile_test3 
--output type=image,name=docker.io/kamsinox/test3,push=true
```

Tryby eksportowania
-
* Pytanie:  </br>
Czym różni się tryb (ang. mode) eksportowania cache min od max? </br>

* Odpowiedź:  </br>
Eksportowanie cache w trybie "min" eksportuje tylko warstwy wynikowego obrazu. </br>
Eksportowanie cache w trybie 'max' eksportuje wszystkie warstwy wszystkich etapów pośrednich.

* Budowanie obrazu do repozytorium na DockerHub korzystając z eksportowania cache w trybie "min"
Przesyłanie przechowując cache lokalnie:
```
buildctl build 
--frontend=dockerfile.v0 
--local context=. 
--local dockerfile=. 
--output type=image,name=docker.io/kamsinox/zaddodatkowe:min,push=true 
--export-cache type=local,dest=.,mode=min
```

![Zrzut ekranu 2022-11-16 205106](https://user-images.githubusercontent.com/92575198/202281106-872a9821-7f65-4d79-8fc6-4285fe6e15a7.png)

Czyszczenie cache: </br>

``` buildctl prune ```

![Zrzut ekranu 2022-11-16 205125](https://user-images.githubusercontent.com/92575198/202281298-3de69853-5f80-485d-a548-ec7987027878.png)

Budowa obrazu, wykorzystując wcześniej zapisany cache:
```
buildctl build 
--frontend=dockerfile.v0 
--local context=. 
--local dockerfile=. 
--output type=image,name=docker.io/kamsinox/zaddodatkowe:min2,push=true 
--import-cache type=local,src=.
```

![Zrzut ekranu 2022-11-16 205230](https://user-images.githubusercontent.com/92575198/202281321-a2ff0c11-91cc-4251-9769-bdb92dfb5f34.png)

* Budowanie obrazu do repozytorium na DockerHub korzystając z eksportowania cache w trybie "max"
Przesyłanie przechowując cache lokalnie:
```
buildctl build 
--frontend=dockerfile.v0 
--local context=. 
--local dockerfile=. 
--output type=image,name=docker.io/kamsinox/zaddodatkowe:max,push=true 
--export-cache type=local,dest=.,mode=max
```

![Zrzut ekranu 2022-11-16 205901](https://user-images.githubusercontent.com/92575198/202282208-f083c5a3-a27d-42fd-8b38-c375ac2d8e67.png)


Czyszczenie cache: </br>

``` buildctl prune ```

![Zrzut ekranu 2022-11-16 205925](https://user-images.githubusercontent.com/92575198/202282230-7f64f243-5d2a-4e43-85d5-1875ec459932.png)

Budowa obrazu, wykorzystując wcześniej zapisany cache:
```
buildctl build 
--frontend=dockerfile.v0 
--local context=. 
--local dockerfile=. 
--output type=image,name=docker.io/kamsinox/zaddodatkowe:max2,push=true 
--import-cache type=local,src=.
```

![Zrzut ekranu 2022-11-16 210006](https://user-images.githubusercontent.com/92575198/202282261-50f50f26-cf2f-4a9f-824e-054b919ee659.png)


