# Data
![iOS version](https://img.shields.io/badge/iOS-13\+-blue) ![Swift version](https://img.shields.io/badge/Swift-v5.5-orange)

A implementação da obtenção de dados são feitas nesse módulo por meio de _repositories_, _local data sources_ e _remote data sources_, o objetivo de cada classe dessa é:
- _Remote Data Sources_: São responsáveis por integrar com APIs ou qualquer outro meio de comunicação com aplicações externas. Aqui são utilizados modelos _DTO_ para fazer a comunicação entre as aplicações.
- _Local Data Sources_: São responsáveis por integrar com uma base de dados local (e.g. banco de dados e estrutura em memoria). Aqui são utilizados modelos _Entity_ para representar o objeto salvo na estrutura de dados.
- _Repositories_: São as implementações das interfaces declaradas no módulo ___domain___, utilizam _data sources_ (podendo ser qualquer tipo) para obter os dados e trata-los para entregar ao módulo de ___domain___, ou seja, os modelos _DTOs_ ou _Entities_ são convertidos para o modelo declarado no ___domain___.
