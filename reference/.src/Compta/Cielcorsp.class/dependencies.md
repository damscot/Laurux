# Cielcorsp — Dépendances

> Source : `.src/Compta/Cielcorsp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Cielcorsp.class` — classe, formulaire associé `Cielcorsp.form`
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

`Fiches_Comptes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`, `Cpt_man`, `ChkInput`, `Compte_delete`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants : `Fmenu.Menu180_Click` (`Fmenu.class:1715`) et `impfec.Buttoncpt_Click`
  (`impfec.class:75`), tous deux en `ShowModal` sur l'auto-instance.
- Table `Ciel_Lrx` (hors préfixe `Fiches_`) non détectée par `deps.py` ; elle est aussi lue par
  `Cielimp` et `impfec` (l. 186, 302).
- `Button2_Click` et `Button3_Click` : boutons du groupe `Btn` dans le `.form`, méthodes appelées
  par `Btn_Click` (Tag 2 et 3). La version actuelle de `deps.py` ne les signale plus comme
  handlers inactifs (`handlers_inactifs` vide) ; ce ne sont pas des handlers morts.
- `ChkInput` : aucun appel dans ce fichier ; les autres `ChkInput` du projet sont locaux.
- `Chainage` : objet local de `_New`, maintenu en vie par les observateurs qu'il pose (à
  confirmer) ; ne pas le supprimer.
- Ordre de rework : avec `Cielcorspj` (commonalisation commune) et après UTILS si `Utils.Ciel`
  évolue.
