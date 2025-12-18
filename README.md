# O que é NietteTTS?
NietteTTS é um MotorTTS (Text-To-Speech) que usar o software Festival Speech Synthesis System para síntese de fala em Português Brasileiro (futuramente suporte a outros idiomas). Usando FestVoz (kit de desenvolvimento para novas vozes) com algumas modificações de extração de (MCEP, F0, STR) para obter melhores resultados na síntese, a técnica de síntese usando Hidden Markov Model (HMM) ou Modelos Ocultos Markov. Sendo a técnica baseada em HMM é a mesma usanda no RHVoice e HTK.

Esse repositório, contém arquivos de suporte de idiomas, treinamento de modelo G2P, scripts modificados e novos para extração de MCEP, F0 e STR. As vozes feitas a partir desse projeto estão contidas na aba de *release*. 

Esse projeto é um projeto de Trabalho de Conclusão de Curso (TCC) sendo desenvolvindo unicamente por uma pessoa. Futuramente o código-fonte do NietteTTS será organizado em conjuto com sua documentação para ser possível com outras desenvolverem novas vozes para NietteTTS, ao suporte de novos idiomas e melhorias gerais do NietteTTS.

# Arquivos de Suporte de Idioma:
| Idioma | Descrição |
| ------------- | ------------- |
| vox_files/pt  | Arquivo de suporte de idioma do português brasileiro |

# Sobre Suporte ao Flite
Alguns problemas durante o desenvolvimento das vozes para Flite (Festival Lite) ocorreram, como dificultades para imprementação do Phonetisaurus, normalização de texto e entre outros. Foi encerrando o desenvolvimento e focará apenas no Festival Speech System.

# Melhorias Futuras
* Novos Idiomas
    * Espanhol Latino
    * Russo
    * Alemão
* Novos métodos de G2P
    * imprementação de G2P usado Marian-MNT
* Novas vozes usando grandes corporas de fala.
* Pos-Tagger
    * Pos-Tagger para obter melhores dados na geração de síntese. 

# Documentação
Para mais informações sobre as vozes do NietteTTS, manual de instalação e com suas amostras de aúdio visite a Wiki do NietteLabs [clicando aqui](https://niettelabs.github.io/).

# Monografia do Projeto

A monografia com o processo de criação do NietteTTS e outras informações no desenvolvimento estão disponivél em [monografia.pdf](https://github.com/NietteLabs/NietteTTS/blob/main/monografia.pdf)
