# Sha1Calc — Tests

> Source : `.src/Utils/Sha1Calc.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `gbtest` sur base MariaDB Docker (et SQLite pour T05). Les clés attendues sont **produites par
le clone Laurux non modifié** sur le même jeu de données (dump de la colonne `control`), jamais
recalculées à la main.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SHA1CALC-T01 | gbtest | `CalcSha1_all` sur `Fiches_Mvt` | `Laurux01.sql` | dump `numero;lind;control` de `Fiches_Mvt` | `tests/recalcul_complet/` | à faire |
| SHA1CALC-T02 | gbtest | `CalcSha1` écriture isolée | première écriture de l'exercice ; écriture intermédiaire ; `lind` précisé ; `update = False` | clé renvoyée ; base inchangée si `update = False` | `tests/ecriture_isolee/` | à faire |
| SHA1CALC-T03 | gbtest | Chaînage avec modifications | jeu dérivé : écriture modifiée (lignes dans `Fiches_MvtM`), écriture précédente supprimée, écriture précédente modifiée | clés de référence | `tests/chainage_modifs/` | à faire |
| SHA1CALC-T04 | gbtest | `CalcSha1_Verify` | base saine ; une ligne altérée (`libelle` modifié) ; `control` NULL | `True`/`False` par écriture | `tests/verification/` | à faire |
| SHA1CALC-T05 | gbtest | Indépendance du moteur | même jeu sous MySQL et SQLite (`Laurux01.sqlite`) | figer les clés des deux moteurs (égalité ou écart documenté) | `tests/moteurs/` | à faire |
| SHA1CALC-T06 | gbtest | `CalcSha1T` tickets | tickets consécutifs dans `Fiches_EntTicketz` ; précédent dans `Fiches_HisEntTickets` ; précédent absent | `control`, `prev_numero` en base ; clé renvoyée | `tests/tickets/` | à faire |
| SHA1CALC-T07 | gbtest | Tables `Fiches_Mvt1-5` | `CalcSha1_all("Fiches_Mvt3")` sur jeu dérivé | dump de `control` ; usage de `Fiches_MvtM3` | `tests/tables_exercices/` | à faire |
| SHA1CALC-T08 | gbtest | Performance | `CalcSha1_all` sur 10 000 écritures ; `CalcSha1_Verify` sur 1 000 | durées de référence (`gbx3 -p`) | `tests/perf_sha1/` | à faire |
| SHA1CALC-T09 | replay | Contrôle des anomalies | Compta → Impressions → Anomalies sur base avec une écriture altérée | PDF/lignes listées ; base inchangée | `tests/anomalies_cles/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ; le jeu dérivé (`derive.sql`) ajoute des écritures modifiées dans
  `Fiches_MvtM`, supprime une écriture et altère un libellé.
- **`CalcSha1_all`** ouvre une `ProgBar` : test exécuté avec un affichage virtuel (Xvfb) ou après la
  séparation SHA1CALC-004 en appelant la boucle pure.
- **Comparaison** : `check_output.py` compare les dumps triés par `(numero, lind)`.
