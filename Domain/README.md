# Domain
![iOS version](https://img.shields.io/badge/iOS-13\+-blue) ![Swift version](https://img.shields.io/badge/Swift-v5.5-orange)

Toda a regra de negócio do aplicativo é criada nesse módulo. Ele é dividido por contexto, ou seja, cada contexto tem seu _use case_ (classe responsável por implementar as regras de negócios). Aqui também é declarado as interfaces dos _repositories_ que serão utilizados para obter os dados para os _use cases_. Além disso, os modelos que serão utilizados para implementar as regras de negócios do aplicativo também ficam aqui, ou seja, aqui centraliza toda a lógica da aplicação. Outro ponto importante é que essa camada __não possui nenhuma dependência__ (com exceção do _common_ para as utilidade em cima da linguagem nativas), ou seja, ela utiliza somente recursos nativos da linguagem.


### Improves
- `OperationsUseCase.operations`: É preciso otimizar para evitar percorrer muito os _arrays_. Na medida que a quantidade de transações aumentar ficará mais custoso. 
