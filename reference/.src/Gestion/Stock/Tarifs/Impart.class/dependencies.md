# Impart — Dépendances

> Source : `.src/Gestion/Stock/Tarifs/Impart.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Tarifs/Impart.class` — classe, formulaire associé `Impart.form`
- Handlers GUI détectés : 24
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Controle`, `InitCode`, `TrC`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `FamList_Click`, `fourList_Click`, `DefList_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CPrix` | `Cascade` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `EtiqRecpt` | `<hérité>` |
| `MajEqu` | `Maj` |
| `Serveur` | `Pass` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Cdate_Dbase`, `Fcolr`, `Next_Code`, `Observers`, `SetEditColor`, `convBool`, `cpoint`, `db` |
| `Variables` | `SMajArt`, `Sexport`, `Sprix` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_CdBarre`, `Fiches_Centrales`, `Fiches_Cequ`, `Fiches_Comptes`, `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_Fam`, `Fiches_Four`, `Fiches_ImpArtDef`, `Fiches_ImpArtDef2`, `Fiches_Parametres`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Fam_LostFocus`, `Txchg_LostFocus`, `Four_LostFocus`, `FamMan`, `fourMan`, `Fam2`, `Controle`, `Maj_Equ`, `Maj_Divers`, `Maj_Centrale`, `Maj_Ref_fournisseur`, `Import`, `Maj_Etiqp`, `Maj_Etiqg`, `InitCode`, `Initialisation`, `prix_base`, `TrC`, `Prix_achat`, `Tva_Calcul`, `Calc_Marge`, `PvTTC_arrondi`, `ChargementFichierDef`, `rechercheKey`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu186_Click` (`Fmenu.class:1733`, `Impart.ShowModal()`).
- `unused` confirmés : `Controle` (vide), `InitCode`, `TrC`. Conséquence non détectée :
  `Button4_MouseDown` (handler de `Panel3`, rendu visible seulement par `InitCode`) est
  inatteignable.
- `scope_reducible` : les homonymes `.Import` de `Etigond.class:1059`, `Majcasier.class:59`
  (`Portable.Import`) et `commande1.class:863` (`tbl.Import`) visent d'autres classes : `Import`
  n'a pas d'appelant externe. `Fam_LostFocus`, `Txchg_LostFocus`, `Four_LostFocus` sont des
  pseudo-handlers (contrôles du groupe `Cmpt`), appelés explicitement.
- `replay_dynamic` : `FamList_Click`, `fourList_Click`, `DefList_Click` restent `Public`.
- Appels sortants : `MajEqu.Maj` (lignes 670 et 1290, la seconde avec les arguments inversés),
  `CPrix.Cascade`, `Utils.Next_Code`, `Editeur.Prog_Editeur`, `EtiqRecpt.Show`, `Doc.Open`,
  `Serveur.Pass`.
- **Dépendances de données** : définitions écrites par `ImpartParam` ; `art_pbfbt`/`art_datefbt`
  lus ensuite par `Etiqfbtarif` et `MajFbtarif2` ; `Fiches_Parametres.dnart` écrit par
  `Parametre` (jamais par `Impart`).
- Tables en dur hors `Cbase` : `Fiches_ImpArtDef`, `Fiches_ImpArtDef2`, `Fiches_Parametres`,
  `Fiches_Tvaav`, `Fiches_Comptes`, `Fiches_EtiProd`, `Fiches_EtiGond`, `Fiches_Art` (dans
  `Maj_Equ`/`Maj_Divers`).
- Fichiers : lecture du fichier d'import ; écriture de `~/tmp/Artnew.txt`, `~/tmp/Artmaj.txt`.
- Ordre de rework : avec `ImpartParam` (`LImpDef`), après `MajEqu`, ARTICLES-012, MAJFBTARIF2-005,
  SERVEUR-008.
