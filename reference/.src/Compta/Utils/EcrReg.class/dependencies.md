# EcrReg — Dépendances

> Source : `.src/Compta/Utils/EcrReg.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/EcrReg.class` — classe, Create Static, hérite de `EcrAuto`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `<type>` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `EcrAuto` | `<type>`, `Vecr`, `resjou` |
| `LDate` | `L` |
| `Utils` | `db` |
| `VarEcr` | `<type>`, `L_ajou`, `L_caisse`, `L_modif`, `L_sup`, `L_valide`, `Treso`, `compte`, `dte`, `dtee`, `dteech`, `etat`, `intitul`, `journal`, `libelle`, `montantc`, `montantd`, `numdoc`, `numero`, `numlot`, `type` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Reglements`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- **`_call` non utilisé** : `SaiReg.class:968`, `:1060` et `Moulinage.class:2561` instancient par
  `New EcrReg(…)` ; aucune forme `EcrReg(…)` sans `New` (grep). `deps.py` attribue ces `New` à
  `_call` (faux positif).
- Membres hérités utilisés par les appelants : `ecriture`, `Imp`, `Impression`, `FinImp`
  (`SaiReg`) ; `ecriture` seul (`Moulinage`).
- Ordre des constructeurs : `EcrAuto._new(njo, var)` s'exécute avant `EcrReg._new(nreg)`
  (arguments du parent en fin de liste) ; `reglement` peut donc lire `Me.Vecr` et `Me.resjou`.
- Dépend de l'API publique d'`EcrAuto` (`Vecr`, `resjou`) et de `VarEcr` : reworker après eux.
