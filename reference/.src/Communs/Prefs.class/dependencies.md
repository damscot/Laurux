# Prefs — Dépendances

> Source : `.src/Communs/Prefs.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Prefs.class` — classe, formulaire associé `Prefs.form`
- Handlers GUI détectés : 53
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Copie_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>`, `ApplyGlobal`, `ReadGlobal`, `ReadSettings` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Copie` | `<hérité>` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Fmenu` | `Menu2showhide`, `Menu3showhide`, `Menu4showhide`, `Menushowhide` |
| `Start` | `GlobalSettings`, `Societe`, `son` |
| `Utils` | `Observers`, `cpoint`, `db`, `totobs` |
| `hexdblKey` | `Crypt` |
| `modfichier` | `fichierboisson`, `fichiercarbu`, `supf` |

### Tables SQL référencées

`Fiches_Echeances`, `Fiches_Parametres`, `Fiches_Tvaav`, `Fiches_Txtmo`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Mdp_LF`, `NmBr_pays`, `Echeances`, `Typeclient`, `aff_logo`, `Copie_Click`, `Affichage`, `Masquage`, `aff_logo2`, `afffam`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique : `Fmenu`** (vérifié par `grep -rn "Prefs"`). `Menu110` (local, protégé par
  `MDP` si `Admin`), `Menu329` (global, protégé par `MDP(Null, True)` si `AdminG`) et
  `Form_Open` l.191-194 (surcharge globale au démarrage). `Menu329` passe trois arguments
  `(Start.GlobalSettings, Null, True)` à un constructeur qui en déclare deux : la répartition avec
  le constructeur hérité de `Form` est à confirmer (test PREFS-T05).
- **Dépendance circulaire `Prefs` ↔ `Fmenu`** : Fmenu instancie Prefs, Prefs appelle
  `Fmenu.Menushowhide`/`Menu2showhide`/`Menu3showhide`/`Menu4showhide` sur l'auto-instance de la
  fenêtre principale. Les reworks de ces quatre méthodes doivent être faits avec ceux de Prefs.
- **Dépendances par configuration** (invisibles pour `deps.py`) : 122 fichiers lisent les
  clés écrites ici. Le tableau exhaustif est en fin d'[architecture.md](architecture.md). Les plus
  sensibles : `DB_Connection` (`ServerLogIP`/`ServerLogPort`, voir
  [DB_CONNECTION-A06](../../Utils/DB_Connection.class/rework.md) et
  [NetHandler](../../Utils/NetHandler.class/architecture.md)), `Variables.module` (lu à
  l'initialisation), `Start.module` (police, son, `Replique`), `Facture`/`ObjFac`/`Cdocuments*`
  (édition des documents), `EnvMail` (SMTP), `SauvesAuto` (FTP), `LGed`/`LScript` (scan).
- **Écrivains concurrents des mêmes clés** : `Fmenu.preferences()` et `LauruxConf` (valeurs de
  création), `LauruxMaj` (migrations : `nbfam`, `ipr`, `pp`, `bois`, `Impbl`, `Fichiers`…),
  `MDP` (lecture dynamique du nom `MdpPrefs`/`MdpPrefsG`).
- **Modification de schéma indirecte** : `pp_Click`/`bois_Click` → `modfichier.fichiercarbu`,
  `fichierboisson`, `supf` (`ALTER TABLE`, `CREATE TABLE Art_Tipp`). Non signalé par `deps.py`
  comme accès SQL de `Prefs`.
- **Faux positif `deps.py`** : `Copie.<inconnu:value>` (l.1044) n'est pas un usage du module
  `Copie` voulu par l'auteur : le handler `Copie_Click` vise un contrôle absent du `.form`.
- **Table en dur** : `Fiches_Tvaav` (l.186, sans `Cbase.Table`) est bien détectée.
- **Fichiers externes** : `Pays.txt` (projet), `Temp$("global_Laurux.conf")`, `~/tmp/sms.txt`,
  `msg.wav` ; commandes `gbx3 -V`, `pico2wave`, `aplay`, `curl`.
- **Ordre de rework** : après `Fmenu` (méthodes `Menu*showhide`) et `modfichier` ; avant toute
  évolution des lecteurs de clés. Les tests de `Prefs` (fichiers `Laurux.conf` de référence)
  servent de données d'entrée aux tests des lecteurs.

