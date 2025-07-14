# NietteTTS
MotorTTS para Android (Apenas Linux no momento) usando Festival com suporte ao Português Brasileiro com vozes de alta qualidade.

# Funções/Qualidades 

1. Fonemas em IPA:
Transcrições fóneticas de palavras retiradas da Wikipedia usando o projeto WikiPron, para obter atualidade e qualidade.
2. G2P melhorado:
Usando Phonetisaurus G2P para treinamento rápido e melhorado em comparação com LTS Rules (Árvore de Decisão) do Festival.
3. Extração de F0 (Pitch EstimatoR) usando REAPER:
Extração de F0 usando REAPER, sendo melhor que o SPTK-3.6 usado por padrão pelo projeto FestVox. 
4. Script diversos:
Scripts para instalação de ferramentas, treinamento de modelo g2p e vocal.

# Observações 
- O NietteTTS está sendo desenvolvindo apenas por uma pessoa (Pallas13) sendo esse projeto para Trabalho de Conclusão de Curso (TCC) do Curso Técnico em Desenvolvimento de Sistemas devido ao tempo, falta de recursos compurtacionais.
- Para as vozes serem usadas no Speech Dispatcher é necessario seguir passo a passo de instalação. O funcionamento é instavél.


# Vozes do NietteTTS

| Nome  | Idioma | Descrição | MCD | Recursos Extras | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Niette   | Português Brasileiro (pt) | Voz Feminina treinada usando o corpos CETUC | Completo: 4.05 - Trainamento/Teste(90/10): 4.615773 | Modelos SpamF0 e Phrasig |
| Pieroni  | Português Brasileiro (pt) | Voz Masculina treinada usando o corpos THLS | Completo: 4.19 - Trainamento/Teste(90/10): 4.561331 | Modelo SpamF0 e Phrasig |

MCD: Mais menor esse número, melhor.

# Arquivos de Idioma:

| Idioma | Descrição |
| ------------- | ------------- |
| vox_files/pt  | Arquivo de Suporte de idioma do português brasileira |

# Sobre Suporte ao Flite
Devido alguns problemas referente ao modo de como o Flite funcionar, dificultades para imprementação do novo G2P usando Phonetisaurus e quantização das vozes, o desenvolvimento focará no Festival.

# Usar vozes do NietteTTS com Speech Dispatcher

**Fonte:** 
https://wiki.archlinux.org/title/Festival_(Portugu%C3%AAs)
https://wiki.archlinux.org/title/Speech_dispatcher

## Instalar as vozes no seu sistema (Baseado em Debian/Ubuntu)

### Exemplo para usar voz Niette.

```bash
sudo apt-get install ./niette.deb speech-dispatcher-festival
```

## Instalar versão modificado do festival-freebsoft-utils

```bash
git clone https://github.com/NietteLabs/festival-freebsoft-utils
cd festival-freebsoft-utils
sudo cp *.scm /usr/share/festival 
```

### Para usar Festival com PulseAudio/Alsa
Edite o arquvivo ```~/.festivalrc```

**PulseAudio:**
```scheme
(Parameter.set 'Audio_Required_Format 'aiff)
(Parameter.set 'Audio_Method 'Audio_Command)
(Parameter.set 'Audio_Command "paplay $FILE --client-name=Festival --stream-name=Speech")
```

**Alsa:**
```scheme
(Parameter.set 'Audio_Method 'Audio_Command)
(Parameter.set 'Audio_Command "aplay -q -c 1 -t raw -f s16 -r $SR $FILE")
```

## Adicionar suporte ao Festival ao Speech Dispatcher

### Abrar o seguinte arquivo de configuração:

```bash
nano ~/.config/speech-dispatcher/speechd.conf
```

Procure pela linha:

```
#AddModule "festival"
```

para:

```
AddModule "festival"
```

## Listar vozes instaladas

```bash
spd-say -L
```

Caso houver algum erro ao executar é necessario iniciar o Festival em modo servidor:

```bash
festival --server
```



