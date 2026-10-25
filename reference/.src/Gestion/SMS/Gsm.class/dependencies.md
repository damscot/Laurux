# Gsm — Dépendances

> Source : `.src/Gestion/SMS/Gsm.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/SMS/Gsm.class` — classe, formulaire associé `Gsm.form`
- Handlers GUI détectés : 8
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Gestion/Facturation/OptFac.class` | `<type>` |
| `.src/Gestion/Tables/FClient.class` | `<type>` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Sms`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** : `Fmenu.Menu319_Click` (`New Gsm("")`), `FClient.Button19_Click`,
  `FFournisseur.Button19_Click` (onglets 0 et 4, `New Gsm(Telp)`), `OptFac.sms_Click`. Signature
  `_New(Tel As String)` à préserver.
- **Remarque hors fichier** : `OptFac.class:537-538` applique les deux `Replace$` à
  `$vfac.resent!tel` séparément ; le second écrase le premier, les points ne sont pas retirés
  (à signaler dans la documentation d'OptFac).
- **Table** : `Fiches_Sms` (`Cbase.Table("TabSms")`), écrite par `Sms`.
- **Groupe sans handler** : `Comcode` est dans le groupe `Com`, qu'aucun `Com_*` ne traite :
  la saisie d'un code au clavier ne charge pas le texte.
- **Dépendances externes non vues par `deps.py`** : `gammu` (modem GSM), `curl`, API HTTP
  Spot-Hit et Hosteur, `~/tmp/sms.txt`.
- **Clés de configuration** : `/Hidentifiant`, `/Hmdp` ne sont plus écrites par `Prefs`
  (`Prefs.class:403-404`, `717-718` commentées) ; le support 3 n'est atteignable que par édition
  manuelle de `Laurux.conf`.
- **Appels dynamiques** : `Colcol_Click` appelé par `ReplayObserver` (doit rester `Public`).
- **Ordre de rework** : après `Sms` (helper de lecture des textes) ; le module SMS commun avant
  `Emailing` (mode SMS) et `Psms`/`Prefs`.
