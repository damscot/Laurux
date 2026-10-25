# Svendeur — Rework

> Source : `.src/Caisse/Svendeur.class` · Message de commit (phase 4) : `reference/.src/Caisse/Svendeur.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 44 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 15 |
| Complexité max (fonction) | 6 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 44 | 15 | 6 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SVENDEUR-001 — [documentation] En-tête en français : rôle (changement de vendeur en début
  de ticket), échange par `Start.$Cai` et `Caisse.$Vendeur`, absence de mot de passe, anomalie
  A01 signalée · appelants : aucun · tests : T01-T04 · sources : [Svendeur.class:_new](../../../../.src/Caisse/Svendeur.class#L3-L19), [Svendeur.class:Button2_Click](../../../../.src/Caisse/Svendeur.class#L42-L52)
- [ ] SVENDEUR-002 — [séparation traitement/GUI] Extraire `VendeurExiste(sCode) As Boolean` de
  `Caissiere_Click` ; `Do … Loop Until` → `Repeat … Until` · appelants : aucun · tests : T01, T04 ·
  sources : [Svendeur.class:Caissiere_Click](../../../../.src/Caisse/Svendeur.class#L21-L40), [Svendeur.class:_new](../../../../.src/Caisse/Svendeur.class#L3-L19)
- [ ] SVENDEUR-003 — [commonalisation] Liste et recherche des vendeurs via le helper `LVendeur`
  (avec `Ouverture`, `Fvendeurs`, `Cmenu`, `ConVendeurs`), longueur de code 1 conservée ·
  appelants : aucun · tests : T01, T04, OUVERTURE-T01 · sources : [Svendeur.class:_new](../../../../.src/Caisse/Svendeur.class#L3-L19), [Svendeur.class:Caissiere_Click](../../../../.src/Caisse/Svendeur.class#L21-L40), [ConVendeurs.class:_new](../../../../.src/Gestion/Facturation/ConVendeurs.class#L6-L26)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SVENDEUR-A01 — [anomalie, à confirmer à l'exécution] (même constat que CAISSE-A04, à corriger
  dans le même commit ; `Caisse.$Vendeur` doit rester `Public`) `Caisse.$Vendeur` (variable
  d'instance) est écrit sur l'auto-instance de `Caisse`, alors que la saisie ouverte est
  `New Caisse` (`Cmenu`) : le changement de vendeur par `Alt+V`/`Ctrl+X` n'est jamais appliqué et
  une instance cachée de `Caisse` est construite. Correction : rendre le choix lisible par
  l'appelant (propriété de `Svendeur`, ou `Static` sur `$Vendeur`) ; modification minimale de
  `Caisse` · appelants : `Caisse` · tests : T02 · sources : [Svendeur.class:46](../../../../.src/Caisse/Svendeur.class#L46), [Svendeur.class:48](../../../../.src/Caisse/Svendeur.class#L48), [Svendeur.class:56](../../../../.src/Caisse/Svendeur.class#L56), [Caisse.class:139](../../../../.src/Caisse/Caisse.class#L139), [Caisse.class:920](../../../../.src/Caisse/Caisse.class#L920), [Cmenu.class:253](../../../../.src/Caisse/Cmenu.class#L253)
- [ ] SVENDEUR-A02 — [anomalie] Recherche du vendeur par `Left$(Caissiere.Text, 1)` (code
  `char(2)`) alors que `Caisse` relit `Left$(Start.$Cai, 2)` : le vendeur `12` est contrôlé sous le
  code `1` (même défaut que CONVENDEURS-A02, OUVERTURE-A02) · tests : T04 · sources : [Svendeur.class:26](../../../../.src/Caisse/Svendeur.class#L26), [Caisse.class:922](../../../../.src/Caisse/Caisse.class#L922)
