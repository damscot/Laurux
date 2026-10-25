# Fondcaisse — Dépendances

> Source : `.src/Caisse/Fondcaisse.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Fondcaisse.class` — classe, formulaire associé `Fondcaisse.form`
- Handlers GUI détectés : 21
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `PictureBox6_MouseDown`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `PictureBox6_MouseDown`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `<type>` |
| `.src/Caisse/Cmenu.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `LDate` | `_call` |
| `Ouverture` | `Rvdr` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Observers`, `PointBase`, `cpoint`, `db` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Caisses`, `Fiches_EntTicketz`, `Fiches_LigTicketz`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Calc_FdcTheo`, `SetObservers`, `ChkFDC`, `TotalFDC`, `PictureBox6_MouseDown`, `FDC_Ini_Update`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants (instances explicites, pas d'auto-instance) :
  - `Cmenu.Button10_Click` : `hForm = New Fondcaisse` puis `Showmodal` ([Cmenu.class:226](../../../../.src/Caisse/Cmenu.class#L226)) ;
  - `Caisse.button21_Click` : `hForm2 = New Fondcaisse` puis `Showmodal` ([Caisse.class:4594](../../../../.src/Caisse/Caisse.class#L4594)) —
    sans contrôle préalable de `Ncai` (contrairement à `Cmenu`).
- `Ouverture.Rvdr` est appelée sur l'**auto-instance** d'`Ouverture` : dépendance à reworker
  avec OUVERTURE-003.
- `PictureBox6_MouseDown` (`unused`, `handlers_inactifs`) : `PictureBox6` appartient au groupe
  `btn` du `.form` ; seul `btn_Enter` est levé. Vérifié : aucun autre appel.
- Les handlers de groupe `numpad_Click`, `Qte_KeyPress`, `Qte_GotFocus`, `Qte_LostFocus`,
  `btn_Enter` sont levés par les groupes du `.form` ; le membre `Qte As TextBox` porte le même
  nom que le groupe `Qte` (sans conflit en Gambas, mais à ne pas renommer).
- `Chainage` (classe `.src/Utils/chainage.class`) observe les 15 champs `Qte*` (navigation) en
  plus des handlers locaux : l'ordre des événements (observateur « avant ») est à préserver.
- Tables : `Fiches_Parametres` est écrite en dur (`deps.py` la détecte comme littéral).
- Jumelle fonctionnelle : requête « Mouvements » de `Moulinage` (ticket Z, [Moulinage.class:239](../../../../.src/Caisse/Moulinage.class#L239)).
  Aucune dépendance avec `Csolde.Solde_caisse` (solde comptable).
- Ordre de rework : après `Ouverture` (`Rvdr`) ; en même temps que `Moulinage` pour une
  éventuelle fonction commune de fond théorique.
