# Treinar G2P usando WikiPron corpus.

Treinamento de Modelo G2P do NietteTTS usando KenLM e Phonetisaurus

## Treinar modelo G2P separando o corpus em train.dic e test.dic

```bash
bash setup_g2p.sh
```

## Treinar modelo G2P usando todo o corpus

```bash
bash setup_g2p_full.sh
```

## Resultados

| Metricas | Modelo "Parcial" | Modelo "Completo" |
|:------------------:|:------------------:|:------------------:|
| CER 	   | 0.08554427519319109 | 0.060699529083816484 |
| WER     | 0.16379791389449286 | 0.11590333519337254 |
| BLEU	   | 70.1 | 79.1 |

**Observações:** O modelo "Completo" foi testado usando mesmo arquivo test.dic do modelo "Parcial"
