# TarArt — Dépendances

> Source : `.src/Utils/TarArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/TarArt.class` — classe, formulaire associé `TarArt.form`
- Handlers GUI détectés : 3
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `detail`, `prixht`, `prixrht`, `promo` |
| `.src/Gestion/Impressions/Edart4.class` | `<type>`, `cdr`, `nego`, `prixht` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `ArtPromo` | `Prix_Promo`, `art_Promo` |
| `DB_Connection` | `Exec` |
| `Utils` | `Option`, `db` |
| `calculdroit` | `<type>`, `droit`, `drsurfac`, `secu`, `suspendu` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`, `Fiches_CoeffTypec`, `Fiches_Fam`, `Fiches_RemCliFam`, `Fiches_RemTypec`, `Fiches_TarTypcli`, `Fiches_Tarcli`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`remise`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants confirmés : `Facture.class:4967,4969` (`New TarArt(Cart, code, Me, typeclient, Cpromo)
  As "trf"`, handler `trf_selec` ligne 5109, `Show` ligne 5121) et `Edart4.class:141`.
- Les deux appelants passent `Me` en **3ᵉ position**, alors que `_new` déclare `(nart, ncli,
  Optional typec, Optional cpromo)` : cet argument est consommé par le constructeur hérité de la
  fenêtre (parent) selon la répartition des arguments de Gambas — à confirmer en phase 2 ; c'est un
  point d'attention si la signature de `_new` change.
- `remise` est réellement sans usage externe (ligne `Facture:4977` commentée).
- Événement `selec` : consommé par `Facture.trf_selec` (lien par nom d'événement `As "trf"`).
- **Ordre de rework** : après `ArtPromo`, `Calculdroit` ; `Facture` (gros fichier legacy) ne doit
  recevoir que des modifications minimales.
