# TriEcritures — Rework

> Source : `.src/Affichages/TriEcritures.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriEcritures.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 602 |
| Lignes de commentaire | 2 |
| Fonctions | 65 |
| Fonctions Public | 65 |
| Complexité cyclomatique totale | 198 |
| Complexité max (fonction) | 11 (`Ecrit_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 602 | 198 | 11 | 0 | 65 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIECRITURES-001 — [documentation] En-tête : rôle, paramètres `_new($Type, $sel, $tr)`
  (valeurs `"0"`/`"1"`), filtres appliqués, protocole `Comptabilite.Bsel`/`snum`/`libelle`/`journal`
  et appelants (`Saisecrit`, `Tresor`) · appelants : aucun · tests : T01, T02 · sources : [TriEcritures.class:_new](../../../../.src/Affichages/TriEcritures.class#L15-L37), [TriEcritures.class:Ecrit_Click](../../../../.src/Affichages/TriEcritures.class#L631-L639)
- [ ] TRIECRITURES-002 — [code mort] Supprimer `Debe1`, `Debe2`, `Debe3`, `Debe4` (jamais
  appelées, vérifié), les variables `numero`/`modif` (jamais lues) ; remplir `CoTable` une fois ·
  appelants : aucun · tests : T01-T04 · sources : [TriEcritures.class:Debe1](../../../../.src/Affichages/TriEcritures.class#L733-L738), [TriEcritures.class:Debe4](../../../../.src/Affichages/TriEcritures.class#L754-L759), [TriEcritures.class:Ecrit_Data](../../../../.src/Affichages/TriEcritures.class#L578-L612)
- [ ] TRIECRITURES-003 — [complexité] `Debn1`≡`Debn3` et `Debn2`≡`Debn4` (aux espaces près) →
  `Charge(bDesc)` ; suppression des tests `If Type = 0` qui choisissent entre deux requêtes
  identiques (SQL modifié aux espaces près, dump identique) · appelants : aucun · tests : T03, T04,
  T06 · sources : [TriEcritures.class:Debn1](../../../../.src/Affichages/TriEcritures.class#L761-L770), [TriEcritures.class:Debn3](../../../../.src/Affichages/TriEcritures.class#L783-L792), [TriEcritures.class:Dbclk2](../../../../.src/Affichages/TriEcritures.class#L53-L73), [TriEcritures.class:Deplacement](../../../../.src/Affichages/TriEcritures.class#L722-L731)
- [ ] TRIECRITURES-004 — [complexité] Les 27 méthodes d'en-tête (`*_Click`, `*_Dblclick`,
  `*_KeyPress` des 9 colonnes) délèguent à `ActiverColonne(sTri, hEntete)`, `InverserOrdre(sTri)` et
  `SaisieFiltre()` ; noms et portées conservés · appelants : aucun · tests : T03, T04 · sources : [TriEcritures.class:JO_Click](../../../../.src/Affichages/TriEcritures.class#L186-L199), [TriEcritures.class:COM_KeyPress](../../../../.src/Affichages/TriEcritures.class#L294-L313), [TriEcritures.class:INTITULE_KeyPress](../../../../.src/Affichages/TriEcritures.class#L555-L576)
- [ ] TRIECRITURES-005 — [complexité] `DA2_KeyPress` : une seule requête après conversion de la date
  (aujourd'hui `Debn1` puis `Debn1`/`Debn3`) — une requête de moins, dump identique · appelants :
  aucun · tests : T03 · sources : [TriEcritures.class:DA2_KeyPress](../../../../.src/Affichages/TriEcritures.class#L336-L359)
- [ ] TRIECRITURES-006 — [réduction de portée] `Entete`, `Dbclk2`, `Tris2`, `Deplacement`, `Debn1`, `Debn2`, `Debn3`, `Debn4` → `Private` (aucun appelant externe, vérifié) · appelants : aucun · tests : T01-T05 · sources : [TriEcritures.class:Entete](../../../../.src/Affichages/TriEcritures.class#L39-L51), [TriEcritures.class:Tris2](../../../../.src/Affichages/TriEcritures.class#L614-L629), [TriEcritures.class:Debn2](../../../../.src/Affichages/TriEcritures.class#L772-L781), [TriEcritures.class:Debn4](../../../../.src/Affichages/TriEcritures.class#L794-L803)
- [ ] TRIECRITURES-007 — [séparation traitement/GUI] `RequeteEcritures(sValidee, sTresorerie,
  sTri, sFiltre, bDesc, iDebut, iNb) As String` pure (texte identique), appelée par `Charge` ·
  appelants : aucun · tests : T06 · sources : [TriEcritures.class:Debn1](../../../../.src/Affichages/TriEcritures.class#L761-L770), [TriEcritures.class:Debn2](../../../../.src/Affichages/TriEcritures.class#L772-L781)
- [ ] TRIECRITURES-008 — [commonalisation] Pagination vers `PaginationListe` (voir TRIFAC-007,
  TRICARTES-005) ; handlers conservés · appelants : aucun · tests : T04 · sources : [TriEcritures.class:Descendre_Click](../../../../.src/Affichages/TriEcritures.class#L680-L690), [TriEcritures.class:Remonter_Click](../../../../.src/Affichages/TriEcritures.class#L692-L700), [TriEcritures.class:Ecrit_MouseWheel](../../../../.src/Affichages/TriEcritures.class#L669-L678)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIECRITURES-A01 — [anomalie] Filtre concaténé (`LIKE "%<sel>%"`, colonne `Tri`, `validee`,
  `tresorerie`) : un `"` ou `\` saisi → erreur SQL ; `%`/`_` jokers. Paramétrer change ces cas ·
  tests : T03 · sources : [TriEcritures.class:764](../../../../.src/Affichages/TriEcritures.class#L764), [TriEcritures.class:766](../../../../.src/Affichages/TriEcritures.class#L766), [TriEcritures.class:775](../../../../.src/Affichages/TriEcritures.class#L775)
- [ ] TRIECRITURES-A02 — [anomalie] `DA2_Click` n'appelle pas `Entete()` : l'en-tête vidé par un
  clic précédent (ex. `COM`) reste vide quand on passe à la colonne date (affichage seulement) ·
  tests : T03 · sources : [TriEcritures.class:DA2_Click](../../../../.src/Affichages/TriEcritures.class#L315-L327)
- [ ] TRIECRITURES-A03 — [anomalie] `Ecrit_Click` sur une grille vide (Entrée après un filtre sans
  résultat) : les `Try` de lecture échouent mais `Comptabilite.Bsel` passe à `True` ; l'appelant
  reprend alors l'écriture `snum` de la sélection précédente (valeur résiduelle du module) · tests :
  T05 · sources : [TriEcritures.class:Ecrit_Click](../../../../.src/Affichages/TriEcritures.class#L631-L639), [Saisecrit.class:641](../../../../.src/Compta/Saisecrit.class#L641)
