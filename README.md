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
O NietteTTS está sendo desenvolvindo apenas por uma pessoa (Pallas13) sendo esse projeto para Trabalho de Conclusão de Curso (TCC) do Curso Técnico em Desenvolvimento de Sistemas devido ao tempo, falta de recursos compurtacionais.

As vozes do NietteTTS não são compartivel com speech-dispatcher, devido a problemas com API do speech-dispatcher para Festival.

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
