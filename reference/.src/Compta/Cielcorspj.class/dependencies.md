# Cielcorspj — Dépendances

> Source : `.src/Compta/Cielcorspj.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Cielcorspj.class` — classe, formulaire associé `Cielcorspj.form`
- Handlers GUI détectés : 7
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ChkInput`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcpt_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Listecompte`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Utils/impfec.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `TextReg` | `<form>`, `Select`, `Text` |
| `Utils` | `Ciel`, `Observers`, `db` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Journaux`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`, `Cpt_man`, `ChkInput`, `Compte_delete`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants : `Fmenu.Menu181_Click` (`Fmenu.class:1709`) et `impfec.Buttonjo_Click`
  (`impfec.class:81`), en `ShowModal` sur l'auto-instance.
- Table `Ciel_Lrx_Jo` non détectée par `deps.py` (hors préfixe `Fiches_`) ; lue par `Cielimp`
  (l. 184, 334, 477) et `impfec` (l. 141, 278).
- `Button2_Click`/`Button3_Click` : appelés par `Btn_Click` (boutons du groupe `Btn`) ; pas de
  handler inactif.
- Ordre de rework : dans le même commit que `Cielcorsp` pour la commonalisation.
