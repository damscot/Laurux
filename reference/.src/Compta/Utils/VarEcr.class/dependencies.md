# VarEcr — Dépendances

> Source : `.src/Compta/Utils/VarEcr.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/VarEcr.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `<type>`, `L_caisse`, `Treso`, `compte`, `dte`, `dtee`, `etat`, `intitul`, `libelle`, `montantc`, `montantd`, `numdoc`, `numlot`, `type` |
| `.src/Compta/Utils/EcrAuto.class` | `<type>`, `Autre`, `L_ajou`, `L_caisse`, `L_modif`, `L_sup`, `L_valide`, `Tlettrage`, `Treso`, `Vente`, `collectif`, `compte`, `divers`, `dte`, `dtee`, `dteech`, `etat`, `intitul`, `journal`, `libelle`, `lind`, `montantc`, `montantd`, `nb`, `numdoc`, `numero`, `numlot`, `plus`, `somme`, `type` |
| `.src/Compta/Utils/EcrReg.class` | `<type>`, `L_ajou`, `L_caisse`, `L_modif`, `L_sup`, `L_valide`, `Treso`, `compte`, `dte`, `dtee`, `dteech`, `etat`, `intitul`, `journal`, `libelle`, `montantc`, `montantd`, `numdoc`, `numero`, `numlot`, `type` |
| `.src/Gestion/Facturation/ObjFac.class` | `<type>`, `L_ajou`, `Vente`, `compte`, `divers`, `dte`, `dteech`, `etat`, `intitul`, `libelle`, `montantc`, `montantd`, `numdoc`, `numlot`, `plus`, `type` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>`, `Caisse`, `L_ajou`, `L_modif`, `L_sans`, `L_sup`, `L_valide`, `Max`, `Tbl`, `Tlettrage`, `Treso`, `collectif`, `compte`, `dte`, `dtee`, `dteech`, `etat`, `intitul`, `journal`, `libelle`, `lind`, `modifi`, `moins`, `montantc`, `montantd`, `nb`, `newTbl`, `numdoc`, `numero`, `numlot`, `plus`, `trouve`, `type` |
| `.src/Gestion/Impressions/EdReg.class` | `<type>`, `L_ajou`, `L_sup`, `etat`, `nb`, `plus`, `somme`, `trouve` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `Autre`, `L_ajou`, `collectif`, `compte`, `dte`, `etat`, `intitul`, `libelle`, `modifi`, `montantc`, `montantd`, `numdoc`, `numlot`, `plus`, `reccomp`, `trouve`, `type` |
| `.src/Gestion/Stock/commande1.class` | `<type>` |
| `.src/Gestion/option/ObjFacB.class` | `Caisse` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LDate` | `<type>` |
| `Utils` | `arrondi` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- **Faux positifs `<inconnu:…>` pour `ObjFac`** (`ttc`, `ht`, `pdfdupli`, `supprime`, `delalltag`,
  `addtag`, `addtags`, lignes 918-935) : la variable locale `lg` est typée `LGed` dans une fonction
  (`ObjFac.class:892`) et `VarEcr` dans une autre (`ObjFac.class:977`) ; l'heuristique attribue à
  `VarEcr` des membres de `LGed`. Aucun de ces membres n'existe dans `VarEcr`.
- `Moulinage.class:2545-2550` : `ecr1[…]` est une `Collection` de `VarEcr`, pas un appel à
  `_get`/`_put`.
- `_get` est utilisé par `SaiReg.class:1058` ; `_put` n'a aucun utilisateur.
- `ObjFac.class:990-991` : `type`/`etat` inversés, sans effet (même valeur 2).
- Dépendance circulaire fonctionnelle avec `EcrAuto`/`EcrReg` (VarEcr est leur structure d'entrée) :
  reworker les trois classes dans le même lot, après les tests de `SaiReg`, `ValidBR1`, `ObjFac`,
  `Moulinage`.
