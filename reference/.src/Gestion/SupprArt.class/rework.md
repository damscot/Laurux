# SupprArt — Rework

> Source : `.src/Gestion/SupprArt.class` · Message de commit (phase 4) : `reference/.src/Gestion/SupprArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 336 |
| Lignes de commentaire | 27 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 90 |
| Complexité max (fonction) | 18 (`button8_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 336 | 90 | 18 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SUPPRART-001 — [documentation] En-tête en français : 4 modes, délégation à
  `Articles.art_Suppr`, tables touchées (renvoi au tableau d'architecture.md), rapport
  `~/tmp/Artsuppr.txt`, table de travail `Artsup` · appelants : aucun · tests : aucun · sources :
  [SupprArt.class:_new](../../../../.src/Gestion/SupprArt.class#L13-L27), [SupprArt.class:button8_Click](../../../../.src/Gestion/SupprArt.class#L347-L405)
- [ ] SUPPRART-002 — [code mort] Supprimer `ChkPrx` (jamais appelé), les membres `Tri`, `Coulfc`,
  `Coulfond` et le `Frmt` de `_new` · appelants : aucun · tests : T01 · sources :
  [SupprArt.class:ChkPrx](../../../../.src/Gestion/SupprArt.class#L295-L303), [SupprArt.class:_new](../../../../.src/Gestion/SupprArt.class#L13-L27)
- [ ] SUPPRART-003 — [commonalisation] Helper privé `SupprimeCode(code, hRapport)` + synthèse
  commune pour `button8_Click` et `Suppression` (même rapport, mêmes messages, même ordre SQL) ·
  appelants : aucun · tests : T01, T03, T05 · sources : [SupprArt.class:button8_Click](../../../../.src/Gestion/SupprArt.class#L347-L405), [SupprArt.class:Suppression](../../../../.src/Gestion/SupprArt.class#L410-L440)
- [ ] SUPPRART-004 — [complexité] `button8_Click` : construire la requête de sélection une seule
  fois (condition `art_suspendu` optionnelle), SQL émis identique (CC 18 → ≤ 10 visé) ·
  appelants : aucun · tests : T01, T02, T03 · sources : [SupprArt.class:367](../../../../.src/Gestion/SupprArt.class#L367), [SupprArt.class:369](../../../../.src/Gestion/SupprArt.class#L369)
- [ ] SUPPRART-005 — [séparation traitement/GUI] Extraire `SelectionArticles(…) As Result` et
  `VenduApres(code, dte) As Boolean` sans accès aux contrôles · appelants : aucun · tests : T01 à
  T05 · sources : [SupprArt.class:button8_Click](../../../../.src/Gestion/SupprArt.class#L347-L405)
- [ ] SUPPRART-006 — [réarchitecture] Table de travail `Artsup` : constante unique (nom répété
  dans `Liste_Click`, `art_man`, `button8_Click`) ; SQL identique · appelants : aucun · tests : T03,
  T04 · sources : [SupprArt.class:Liste_Click](../../../../.src/Gestion/SupprArt.class#L29-L61), [SupprArt.class:art_man](../../../../.src/Gestion/SupprArt.class#L308-L345)
- [ ] SUPPRART-007 — [réduction de portée] `Aff`, `SelectionArt`, `art_man`, `Suppression` →
  `Private` ; `Bsel`/`Bval` restent `Public` (écrits par `TriCpt`/`TriArticles` via
  `Object.SetProperty`) · appelants : aucun · tests : T01 à T05 · sources : [SupprArt.class:Aff](../../../../.src/Gestion/SupprArt.class#L206-L237), [SupprArt.class:SelectionArt](../../../../.src/Gestion/SupprArt.class#L282-L293), [SupprArt.class:art_man](../../../../.src/Gestion/SupprArt.class#L308-L345), [SupprArt.class:Suppression](../../../../.src/Gestion/SupprArt.class#L410-L440)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SUPPRART-A01 — [anomalie] Rapport erroné en mode sélection : pour un article vendu après la
  date, la ligne est écrite **avant** l'affectation du message (ligne vide ou message de l'article
  précédent) · tests : T01 · sources : [SupprArt.class:386](../../../../.src/Gestion/SupprArt.class#L386), [SupprArt.class:387](../../../../.src/Gestion/SupprArt.class#L387)
- [ ] SUPPRART-A02 — [anomalie] Bornes strictes `art_fam > Fam1 AND art_fam < Fam2` et
  `art_four > Cp1 AND art_four < Cp2` : les familles et fournisseurs saisis comme bornes sont
  exclus · tests : T01, T02 · sources : [SupprArt.class:367](../../../../.src/Gestion/SupprArt.class#L367), [SupprArt.class:369](../../../../.src/Gestion/SupprArt.class#L369)
- [ ] SUPPRART-A03 — [anomalie] Contrôle de stock inopérant : `art_Suppr` teste
  `stocke.value`/`qte.Text` du formulaire `Articles` (auto-instance) et non de l'article ; des
  articles avec stock ≠ 0 sont supprimés malgré l'avertissement · tests : T01 · sources : [SupprArt.class:377](../../../../.src/Gestion/SupprArt.class#L377), [Articles.class:4082](../../../../.src/Gestion/Tables/Articles.class#L4082)
- [ ] SUPPRART-A04 — [anomalie] Liste manuelle : les articles supprimés restent dans `Artsup`
  (le texte du formulaire annonce que seuls les refusés y restent) ; un nouveau passage produit des
  erreurs « Article inconnu » · tests : T03 · sources : [SupprArt.class:Liste_Click](../../../../.src/Gestion/SupprArt.class#L29-L61), [SupprArt.class:368](../../../../.src/Gestion/SupprArt.class#L368)
- [ ] SUPPRART-A05 — [anomalie] Références orphelines : `art_Suppr` ne traite ni ne contrôle
  `Fiches_LigblM`, `Fiches_Mvtexpdc`, `Fiches_HisInvT`, `Fiches_CdFour`, `Fiches_PrdComp`,
  `Fiches_Rpl1.coderpl1`/`Rpl2.coderpl2`, `Fiches_ArtPromo`, `Fiches_EtiGond`, `Fiches_EtiProd`,
  `Fiches_Tarcli`, `Fiches_TarTypcli` (comparaison avec `Changefam.Modifart`) ; correction à porter
  dans `Articles` · tests : T07 · sources : [Articles.class:art_Suppr](../../../../.src/Gestion/Tables/Articles.class#L4060-L4155), [Changefam.class:Modifart](../../../../.src/Utils/Changefam.class#L500-L555)
- [ ] SUPPRART-A06 — [anomalie] Écran non journalisé (`Utils.Observers(Me)` absent) : à ajouter
  dans les deux clones avant l'enregistrement des replays si la phase 2 le confirme ; le rapport est
  aussi ouvert (tronqué) avant la confirmation et jamais fermé en cas d'abandon · tests : T06 ·
  sources : [SupprArt.class:_new](../../../../.src/Gestion/SupprArt.class#L13-L27), [SupprArt.class:363](../../../../.src/Gestion/SupprArt.class#L363)
