# Facturefm — Dépendances

> Source : `.src/Gestion/Facturation/Facturefm.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/Facturefm.class` — classe, formulaire associé `Facturefm.form`
- Handlers GUI détectés : 23
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_Click`, `Coldetail_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `AFacture` | `<type>` |
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `LDate` | `_call` |
| `ObjFac` | `finmois` |
| `OptFac` | `<type>` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client` |
| `Utils` | `Cdate_Aff`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `Option`, `cpoint`, `db`, `lastday`, `orientation`, `totobs` |
| `VerifDate` | `<type>`, `ClotFac` |
| `rechtour` | `<type>` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_Cli`, `Fiches_Commerciaux`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Parametres`, `Fiches_Tvaav`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`recup_bl`, `supclient`, `affclient`, `Quittedate`, `requete`, `Cclient`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants : `Fmenu.Menu138_Click` et `Fmenu.lblFacfm_MouseDown` (`Facturefm.ShowModal`,
  auto-instance ; le second sans contrôle de réplication, FMENU-A10).
- Aucune fonction n'est appelée de l'extérieur : les 6 membres « portée réductible » de `deps.py`
  sont confirmés, sauf `Bsel`/`Bval` (non listés, positionnés par `TriCpt` via
  `Object.SetProperty`). `Cclient` est mort.
- `replay_dynamic` : `Colbl_Click`, `Coldetail_Click` (ColumnView) → `Public` obligatoire.
- **Tables de travail** `Facturefm` et `Bl` (sans clé `Cbase`, hors `db_control.csv`) : écrites
  ici, lues par `ObjFacB.editefm`/`mail` ([ObjFacB.class:626](../../../../../.src/Gestion/option/ObjFacB.class#L626), [ObjFacB.class:822](../../../../../.src/Gestion/option/ObjFacB.class#L822)) et
  `ObjFac.calcul` ([ObjFac.class:481-484](../../../../../.src/Gestion/Facturation/ObjFac.class#L481-L484)). Elles sont **détruites et recréées** par
  `FacturefmA`, `Facturergbl`, `SaiReg.Facture`, `Visimpayes` (VISIMPAYES-A02) et
  `Visreglements`, avec des structures différentes pour les quatre derniers (`Facturefm` sans
  `adr1/adr2/gestbl` ou avec `totald/totalc` ; `Bl` sans `nom` ou avec `numbl`). Elles doivent
  être exclues du dump normalisé (phase 2).
- Dépendances : `OptFac` (édition), `AFacture` (consultation), `TriCpt`, `Rechtour`,
  `VerifDate.ClotFac`, `ObjFac.finmois` (constante).
- Ordre de rework : la commonalisation avec `FacturefmA`/`Facturergbl` se fait après les trois
  documentations ; le helper des tables de travail touche aussi `SaiReg`, `Visimpayes`,
  `Visreglements` (lots différents : à ordonner en phase 3).
