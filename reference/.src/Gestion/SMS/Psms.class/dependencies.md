# Psms — Dépendances

> Source : `.src/Gestion/SMS/Psms.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/SMS/Psms.class` — classe, formulaire associé `Psms.form`
- Handlers GUI détectés : 6
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 48 (4 argument(s), marqueurs [1, 2, 3, 4, 5])

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Psms`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (vérifié : `grep -rnw Psms .src` ne renvoie que `Psms.class`/`Psms.form` ;
  ni `New Psms`, ni `Psms.Show`, ni entrée de menu). `deps.py` ne signale pas de fonction
  `unused` car toutes sont des handlers du formulaire ; c'est le **formulaire entier** qui est
  mort.
- **Table fantôme** : `Fiches_Psms` n'existe ni dans `db_control.csv`, ni dans `Laurux01.sql`,
  ni dans `LauruxMaj.module`, et n'a pas de clé `Cbase`.
- **Paramétrage réellement utilisé** : `Prefs` écrit `/Soc<XX>/Support`, `/Api`, `/Type`,
  `/Expediteur` (`Prefs.class:703-707`), lus par `Gsm` et `Emailing`.
- **Dépendances externes non vues** : `curl`, API Spot-Hit, `~/tmp/sms.txt`.
- **Ordre de rework** : indépendant ; à traiter par l'anomalie PSMS-A01 avant toute
  commonalisation SMS (GSM-005) pour ne pas mutualiser du code mort.
