# Emailing — Dépendances

> Source : `.src/Gestion/Mails/Emailing.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Mails/Emailing.class` — classe, formulaire associé `Emailing.form`
- Handlers GUI détectés : 30
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `EnvoiSms`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColCli_Click`, `ColCli2_Click`, `ColType_Click`, `ColType2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `EnvMail` | `Envoi`, `Extension` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Base`, `Fcolr`, `Observers`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Statut`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Tris2`, `colinit`, `AffClients`, `AffClients2`, `Cli_Man`, `ChkInput`, `Button2_Click`, `EnvoiSms`, `SetObservers`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Points d'entrée** (vérifiés) : `Fmenu.Menu175_Click` (`New Emailing("mail")`, l. 1664-1670)
  et `Fmenu.Menu320_Click` (`New Emailing("sms")`, l. 2415-2420 ; menu `Menu316` masqué si
  `/Soc<XX>/Sms = 0`, `Fmenu.class:138-141`). Signature de `_New(sType)` à préserver.
- **Code mort confirmé** : `EnvoiSms` (aucune occurrence hors de sa définition). Variables
  écrites sans lecture : `CoulZnaf`, `credit` ; jamais affectées : `$gsm`, `mesg`.
- **`Button2_Click`** : `Button2` est dans le groupe `btn` (le `.form` écrit `btn`, les handlers
  `Btn_*` ; Gambas ignore la casse) : l'événement `Click` est levé sur `Btn_Click`, qui rappelle
  `Button2_Click`. La « portée réductible » de `deps.py` est donc juste.
- **Branches inatteignables** : tags 7 et 8 d'`Etiq_KeyPress` (aucun contrôle ne les porte) ;
  `Btn_Click` tag 1 (`Button1` n'est pas groupé).
- **Homonyme** : `Statut` désigne ici le **ComboBox** du formulaire (`Emailing.form`, groupe
  `Cmpt` sans handler), pas le formulaire `Statut` ; le lien `Fiches_Statut` passe par
  `Cbase.Table("TabStatut")`.
- **Tables non vues par `deps.py`** : table de travail `Cli_Mailing` (nom par variable `Tab`/`Tab2`),
  partagée avec `EmailingCarte`.
- **Appels dynamiques** : aucun dans le fichier ; `ReplayObserver` appelle `ColCli_Click`,
  `ColCli2_Click`, `ColType_Click`, `ColType2_Click` par `Object.Call` (doivent rester `Public`).
- **Dépendances externes non vues** : `curl` et l'API HTTP Spot-Hit (`Label7_GotFocus`,
  `EnvoiSms`), `gammu` (`EnvoiSms`, mort), fichier `~/tmp/sms.txt`.
- **Contrat avec `EnvMail.Envoi`** : passe le chemin complet dans `chemin` (voir EMAILING-A02 et
  la documentation d'`EnvMail`).
- **Ordre de rework** : après `EnvMail` (contrat de pièce jointe) ; en même temps
  qu'`EmailingCarte` et `Eticli` si la commonalisation de la sélection est retenue ; le module SMS
  commun (GSM-005) avant la réécriture du mode SMS.
