# Treinar G2P usando WikiPron corpus.

Treinamento de Modelo G2P do NietteTTS usando KenLM e Phonetisaurus

## Treinar modelo G2P separando o corpus em train.dic e test.dic

```
bash
bash setup_g2p.sh
```

## Treinar modelo G2P usando todo o corpus

```bash
bash setup_g2p_full.sh
```

## Resultados

| Metricas | Modelo "Parcial" | Modelo "Completo" |
|:------------------:|:------------------:|:------------------:|
| CER 	   | 0.08833183508861636 | 0.06059231524168474 |
| WER     | 0.16960982100699662 | 0.11608361591621238 |
| BLEU	   | 69.1 | 79.1 |

**Observações:** O modelo "Completo" foi testado usando mesmo arquivo test.dic do modelo "Parcial"
