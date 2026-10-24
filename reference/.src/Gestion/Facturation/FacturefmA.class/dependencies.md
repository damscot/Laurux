# FacturefmA — Dépendances

> Source : `.src/Gestion/Facturation/FacturefmA.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/FacturefmA.class` — classe, formulaire associé `FacturefmA.form`
- Handlers GUI détectés : 22
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `EnvoiFTP`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_Click`, `Coldetail_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cdocuments` | `<type>` |
| `Copie` | `spiece` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `LDate` | `_call` |
| `ObjFac` | `finmois` |
| `OptFac` | `<type>` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Cli`, `Fiches_Ligbl`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`recup_bl`, `Quittedate`, `EnvoiFTP`, `Cclient`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelant unique : `Fmenu.Menu299_Click` (`FacturefmA.ShowModal`, auto-instance).
- `unused` de `deps.py` : `EnvoiFTP` est réellement morte (aucun appel, ni dynamique) ;
  `FtpClient1_Connect` est un **faux positif** (gestionnaire de l'événement `Connect` du contrôle
  `FtpClient1` du `.form`, type `#FtpClient` de gb.net.curl, non reconnu comme événement par
  l'outil alors que `Ftpclient1_read`/`_Error`/`_Finished` le sont).
- `Copie.spiece` n'est utilisé que dans `EnvoiFTP` (morte) : COPIE-A02 est sans effet tant que
  l'envoi FTP n'est pas réactivé (à reporter dans la doc de `Copie`).
- `replay_dynamic` : `Colbl_Click`, `Coldetail_Click` → `Public` obligatoire.
- Tables de travail `Facturefm` et `Bl` : créées ici avec une structure réduite (pas de
  `adr1/adr2/gestbl` dans `Facturefm`, pas de `nom` dans `Bl`), puis lues par `ObjFacB.editefm`
  et `ObjFac.calcul` ([ObjFac.class:481](../../../../../.src/Gestion/Facturation/ObjFac.class#L481) filtre sur `nom` pour un client divers). Elles sont
  partagées avec `Facturefm`, `Facturergbl`, `SaiReg`, `Visimpayes` (VISIMPAYES-A02),
  `Visreglements`.
- `OptFac` est appelé en mode `ObjFac.finmois` ; le mode `ObjFac.abonnement` prévu par `OptFac`
  et `ObjFac` n'est utilisé par aucun appelant (à confirmer avec `ObjFacB`).
- Ordre de rework : avec `Facturefm` et `Facturergbl` (base commune).
