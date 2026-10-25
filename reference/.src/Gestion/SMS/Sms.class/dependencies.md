# Sms — Dépendances

> Source : `.src/Gestion/SMS/Sms.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/SMS/Sms.class` — classe, formulaire associé `Sms.form`
- Handlers GUI détectés : 6
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button3_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button3_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `son` |
| `Utils` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Sms`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button3_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Point d'entrée** (vérifié) : `Fmenu.Menu315_Click` (`Sms.Show()`, l. 2394-2398) ;
  `Menu315` masqué si `/Soc<XX>/Sms = 0` (`Fmenu.class:138-139`).
- **`Button3_Click`** : `handlers_inactifs` confirmé — `Button3` appartient au groupe `Btn`
  (`Sms.form`), sa fermeture passe par `Btn_Click` tag 4. Code mort.
- **`Button1_Click`, `Button2_Click`, `Button4_Click`** : appelés seulement par `Btn_Click` /
  `Btn_KeyPress` / `Lib_KeyPress` (boutons groupés) : la « portée réductible » est juste.
- **Table** : `Fiches_Sms` via `Cbase.Table("TabSms")`, créée par `LauruxMaj.Maj341`
  (`LauruxMaj.module:4107`), présente dans `db_control.csv`. Également lue par `Gsm`.
- **Copie de** `ComMail.class` (diff vérifié : seuls le nom de table, le mode « choix » et le
  `Catch` de `Form_Open` diffèrent).
- **Appels dynamiques** : `colcol_Click` appelé par `ReplayObserver` (doit rester `Public`).
- **Ordre de rework** : avec `ComMail` et `Comment` (module partagé), avant `Gsm` si le helper de
  lecture des textes est mutualisé.
