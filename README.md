# Sprawozdanie z labolatorium nr 4

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
Tryby eksportowania
-
