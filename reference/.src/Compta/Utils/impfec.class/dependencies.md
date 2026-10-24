# impfec — Dépendances

> Source : `.src/Compta/Utils/impfec.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/impfec.class` — classe, formulaire associé `impfec.form`
- Handlers GUI détectés : 6

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Calcsolde` | `<hérité>` |
| `Cielcorsp` | `<hérité>` |
| `Cielcorspj` | `<hérité>` |
| `DB_Connection` | `Create9`, `Exec` |
| `ProgBar` | `<type>`, `Avancement` |
| `Sha1Calc` | `CalcSha1` |
| `TextReg` | `<form>`, `EstNum`, `Text`, `Type`, `Value`, `reg` |
| `Utils` | `Ciel`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Parametres`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menuimpfec_Click` (`Fmenu.class:2494`, `impfec.Show`, menu « Import
  fichier FEC »), vérifié par `grep -rniw impfec .src`.
- Tables non détectées par `deps.py` : `Ciel_Lrx`, `Ciel_Lrx_Jo` (lecture, noms en dur, sans clé
  `Cbase`), créées par `Utils.Ciel()`. `Fiches_Journaux` est bien lue (contrôle des journaux).
- Formulaires ouverts : `Calcsolde` (recalcul des soldes après import, voir
  [Calcsolde](../../../Utils/Calcsolde.class/dependencies.md)), `Cielcorsp`, `Cielcorspj`
  (correspondances, partagées avec `Cielimp`).
- `Sha1Calc.CalcSha1("Fiches_Mvt", …)` : nom de table en dur ; une migration de `Sha1Calc` vers
  `Cbase` doit rester compatible.
- `DB_Connection.Create9` est une méthode spécifique du projet (création d'un enregistrement avec
  journalisation `Exec_SQL`) : tout rework de `DB_Connection.Create9` impacte ce fichier.
- Aucun appel dynamique ; aucune dépendance circulaire.
- Ordre de rework : après `Utils` (`Ciel`), `Sha1Calc`, `Calcsolde` ; en même temps que `Cielimp`
  pour la commonalisation des correspondances.
