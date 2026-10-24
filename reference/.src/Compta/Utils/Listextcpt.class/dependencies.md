# Listextcpt — Dépendances

> Source : `.src/Compta/Utils/Listextcpt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Listextcpt.class` — classe, Create Static
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `litpointee`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Extrait.class` | `<type>`, `litleres`, `resext` |
| `.src/Compta/Impressions/EdNlettrees.class` | `<type>`, `resext` |
| `.src/Compta/Lettrages/Lettrage.class` | `<type>`, `letcpt`, `resext` |
| `.src/Compta/Pointage.class` | `<type>`, `enregistrepointage`, `requete`, `totalpointe` |
| `.src/Compta/Relances/FEditrel.class` | `<type>`, `resext` |
| `.src/Compta/Relances/Ligcli.class` | `<type>`, `resext` |
| `.src/Compta/Tresor.class` | `<type>`, `Controle`, `letcpt`, `letgroupe`, `resext` |
| `.src/Compta/Utils/EcrAuto.class` | `<type>`, `Controle`, `Ecart`, `letcpt`, `letgroupe`, `rechechelot`, `resext` |
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `resext` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>`, `rechechelot`, `rechedoc`, `resext` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LCoul` | `Ecr_DB_bgcolor` |
| `LDate` | `<type>`, `Apres`, `Avant`, `D`, `DT`, `FinJour`, `G`, `L`, `_call` |
| `Utils` | `arrondi`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`litpointee`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés par grep** (10 fichiers) : `Extrait.class:582-593` (3 modes `n`/`o`/`t`,
  `litleres` l. 1152), `Lettrage.class:330-339` et `letcpt` (l. 426, 444, 517), `Pointage.class:127`
  (`requete`, `totalpointe`, `enregistrepointage`), `Tresor.class:80`, `635`, `1665-1669`, `2174`,
  `2244`, `EcrAuto.class:607-656`, `SaiReg.class:197`, `416-425`, `Facture.class:10994`,
  `EdNlettrees.class:391`, `FEditrel.class:350`, `Ligcli.class:163` (origine `"relance"`).
- **Contrat textuel** : `Pointage.class:128` fait `Left($lst.requete, -14)` pour retirer la clause
  `ORDER BY` ; le texte SQL de `requete` doit rester identique (test LISTEXTCPT-T01 bloquant).
- `litpointee` : aucun appelant (grep `litpointee` → seule la définition). La « portée réductible »
  de `deps.py` est confirmée ; c'est du code mort.
- `Ecart` est lu par `EcrAuto` (l. 617-628) après `Controle` : couplage par état d'instance.
- **Tables non vues par `deps.py`** : `Fiches_Mvt1` … `Fiches_Mvt5`, construites par
  `"Fiches_Mvt" & si` et `$brn[i].nomfich`.
- `LCoul.Ecr_DB_bgcolor` injecte un fragment SQL qui dépend des couleurs de `/Coul/*` : le texte
  de `requete` dépend donc de la configuration (à fixer dans les tests).
- Aucun appel dynamique ; pas de dépendance circulaire.
- **Ordre de rework** : après `LDate` (LDATE-008 si la commonalisation des bornes est retenue) et
  avant ses appelants `Pointage`, `Extrait`, `Lettrage`, `Tresor`, `EcrAuto` (leurs replays servent
  de tests de non-régression).
