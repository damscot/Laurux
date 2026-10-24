# Ligcli — Dépendances

> Source : `.src/Compta/Relances/Ligcli.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Relances/Ligcli.class` — classe, formulaire associé `Ligcli.form`
- Handlers GUI détectés : 4
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `couleur`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Relances/FEditrel.class` | `<type>`, `sold` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Creleve` | `<type>`, `Entete`, `Entete2`, `Level5`, `Level6`, `Level7`, `Level8` |
| `DB_Connection` | `Exec` |
| `EnvMail` | `Envoi2` |
| `LDate` | `<type>`, `L` |
| `Ligext` | `<type>` |
| `Listextcpt` | `<type>`, `resext` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Cdate_Aff`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Societes`, `Fiches_Txt_Relances`, `Fiches_relances`

### Membres Public sans usage externe détecté (portée réductible ?)

`couleur`, `visext`, `EnvMail`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul créateur : `FEditrel.affiche` (`FEditrel.class:146`), avec `ScrollView1` comme parent et le
  groupe d'événements `"lig"` → handlers `FEditrel.Lig_up`, `lig_Down`, `lig_GotF`.
- **Faux positifs « portée réductible »** : `couleur` et `visext` sont appelées par `FEditrel` via
  des `Variant` (`tab[i].couleur(…)` l. 50, 67, 85, 289 ; `tab[nlig].visext` l. 53, 72, 90) ; les
  propriétés `selection`, `numero`, `lib`, `imp`, `traitement`, `rellet`, `numlet` sont lues de la
  même façon (l. 115, 191, 238, 519, 533-534). Seul `EnvMail` est réellement sans appelant.
- **Homonymie** : la méthode `EnvMail()` porte le nom du module `Gestion/Mails/EnvMail.module` ;
  vérifié par compilation d'un projet minimal (`gbc3`/`gbx3`) : `EnvMail.Envoi2` vise le module.
- `Fiches_relances` et `Fiches_Txt_Relances` sans clé `Cbase` ; `Fiches_Cli`, `Fiches_Comptes`,
  `Fiches_Societes`, `Fiches_Mvt` en dur (clés `TabCli`, `TabComptes`, `TabSoc`, `TabMvt` existent).
- Ordre de rework : avec `FEditrel` et `Ligext` ; la commonalisation de l'impression des relances
  doit précéder ou accompagner celle de `FEditrel`.
