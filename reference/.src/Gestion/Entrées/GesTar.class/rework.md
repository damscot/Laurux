# GesTar — Rework

> Source : `.src/Gestion/Entrées/GesTar.class` · Message de commit (phase 4) : `reference/.src/Gestion/Entrées/GesTar.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 675 |
| Lignes de commentaire | 21 |
| Fonctions | 41 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 145 |
| Complexité max (fonction) | 14 (`EnrTar`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 675 | 145 | 14 | 0 | 29 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GESTAR-001 — [documentation] En-tête en français : formulaire incrusté dans `commande1`,
  trois tableaux `As "Tarif"`, observateurs et handlers associés, sens de `IgnoreTarif` (vrai =
  mettre à jour), valeurs de `temp_type`, représentation du coefficient (marge % saisie,
  multiplicateur stocké) · appelants : aucun · tests : aucun · sources : [GesTar.class:_new](../../../../../.src/Gestion/Entrées/GesTar.class#L24-L116), [GesTar.class:Tarif_ajou](../../../../../.src/Gestion/Entrées/GesTar.class#L380-L406), [GesTar.class:EnrTarTemp](../../../../../.src/Gestion/Entrées/GesTar.class#L645-L695)
- [ ] GESTAR-002 — [code mort] Supprimer l'observateur `As "Px_Rev"` sans handler de `_ready`,
  les variables locales inutilisées (`obs` de `_new`, 8 locales de `LecArt_Write`, `tx`/`col`
  d'`EnrTarTemp`, `res`/`col` d'`EnrEtiqu`) et le commentaire mort de `majtarif_Click` ·
  appelants : aucun · tests : T01, T05 · sources : [GesTar.class:125](../../../../../.src/Gestion/Entrées/GesTar.class#L125), [GesTar.class:LecArt_Write](../../../../../.src/Gestion/Entrées/GesTar.class#L353-L378), [GesTar.class:EnrTarTemp](../../../../../.src/Gestion/Entrées/GesTar.class#L645-L695)
- [ ] GESTAR-003 — [complexité] `EnrTar` : helper privé `EnrTarifs(lcol, table, colonne, ttype)`
  pour les blocs client et type client (mêmes requêtes, même ordre) · appelants : `commande1`
  (inchangé) · tests : T05, T07 · sources : [GesTar.class:EnrTar](../../../../../.src/Gestion/Entrées/GesTar.class#L594-L643)
- [ ] GESTAR-004 — [complexité] `EnrTarTemp` : helper privé `TarTempLigne(ttype, code)`
  (`Edit` sinon `Create9`) pour les trois blocs · appelants : `commande1` (inchangé) ·
  tests : T06 · sources : [GesTar.class:EnrTarTemp](../../../../../.src/Gestion/Entrées/GesTar.class#L645-L695)
- [ ] GESTAR-005 — [réarchitecture] `Cbase.Table(…)` pour les tables qui ont une clé (`TabArt`,
  `TabTvav`, `TabTarcli`, `TabTcli`, `TabCli`, `TabTypec`, `TabEtiqp`, `TabEtiqg`) ; SQL
  identique · appelants : aucun · tests : T01-T10 · sources : [GesTar.class:_new](../../../../../.src/Gestion/Entrées/GesTar.class#L24-L116), [GesTar.class:EnrTar](../../../../../.src/Gestion/Entrées/GesTar.class#L594-L643), [GesTar.class:EnrEtiqu](../../../../../.src/Gestion/Entrées/GesTar.class#L724-L748), [GesTar.class:climan](../../../../../.src/Gestion/Entrées/GesTar.class#L435-L458), [GesTar.class:typeman](../../../../../.src/Gestion/Entrées/GesTar.class#L460-L483)
- [ ] GESTAR-006 — [réduction de portée] `EnrTarArt` → `Private` (seul appelant `EnrTar`,
  vérifié par `grep -rn`) ; `Enreg_Click`/`majtarif_Click` (contrôles publics du `.form`) et
  `Bsel`/`Bval` restent `Public` · appelants : aucun · tests : T05 · sources : [GesTar.class:EnrTarArt](../../../../../.src/Gestion/Entrées/GesTar.class#L554-L592)
- [ ] GESTAR-007 — [séparation traitement/GUI] `EnrTarArt`/`EnrTar` : valeurs de la ligne d'achat
  (`Rem`, `TX_Conv`, `Frais`, `Px_Brut`) passées en paramètres, couleur du bouton laissée à
  l'appelant ; conversion coefficient ↔ prix de `Coef_lostfocus`/`Px_HT_lostfocus` dans des
  fonctions pures · appelants : aucun (signatures publiques inchangées) · tests : T01, T02, T05 ·
  sources : [GesTar.class:EnrTarArt](../../../../../.src/Gestion/Entrées/GesTar.class#L554-L592), [GesTar.class:Coef_lostfocus](../../../../../.src/Gestion/Entrées/GesTar.class#L270-L293), [GesTar.class:Px_HT_lostfocus](../../../../../.src/Gestion/Entrées/GesTar.class#L295-L304)
- [ ] GESTAR-008 — [commonalisation] Fabrique `PrixVente(pxrev, coef, tauxTva, arrondi) As LPrix`
  partagée avec `DateTar.EnrTouTar`, `VarMajTar.constructiontableau` et `TarTypeCli` ; équivalence
  `Marge x %` ≡ `Remise −x %` à prouver par gb.test avant substitution (phase 3, même lot que
  DATETAR-005 et TARTYPECLI-007) · appelants : aucun · tests : T01, T05, DATETAR-T05 · sources : [GesTar.class:Coef_lostfocus](../../../../../.src/Gestion/Entrées/GesTar.class#L270-L293), [GesTar.class:affichetarif](../../../../../.src/Gestion/Entrées/GesTar.class#L821-L874), [DateTar.class:EnrTouTar](../../../../../.src/Gestion/Entrées/DateTar.class#L172-L254), [VarMajTar.class:constructiontableau](../../../../../.src/Gestion/Stock/VarMajTar.class#L89-L143)
- [ ] GESTAR-009 — [commonalisation] Helper `CoefDepuisMarge(texte)` pour les quatre
  `1 + Val(Left(coef, -1)) / 100` (même valeur) · appelants : aucun · tests : T05, T06 ·
  sources : [GesTar.class:584](../../../../../.src/Gestion/Entrées/GesTar.class#L584), [GesTar.class:616](../../../../../.src/Gestion/Entrées/GesTar.class#L616), [GesTar.class:632](../../../../../.src/Gestion/Entrées/GesTar.class#L632), [GesTar.class:701](../../../../../.src/Gestion/Entrées/GesTar.class#L701)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] GESTAR-A01 — [anomalie] `SupTarTemp` n'a pas de paramètre et supprime les tarifs temporaires
  de l'article courant `$resart` ; `commande1.suppr_Click` l'appelle une fois par ligne sans
  changer d'article → tarifs temporaires des autres articles orphelins. Correction : paramètre
  article (appelant `commande1` à modifier dans le même commit) · tests : T08 · sources : [GesTar.class:SupTarTemp](../../../../../.src/Gestion/Entrées/GesTar.class#L718-L722), [commande1.class:508](../../../../../.src/Gestion/Stock/commande1.class#L508)
- [ ] GESTAR-A02 — [anomalie] `Px_HT_lostfocus` divise par `Px_Rev` sans test (prix de revient
  nul → erreur) · tests : T09 · sources : [GesTar.class:300](../../../../../.src/Gestion/Entrées/GesTar.class#L300)
- [ ] GESTAR-A03 — [anomalie] `EnrArt` : `art_dpa` reçoit `art_pbht` de la fiche lue **avant**
  `EnrTarArt` (ancien prix brut) ; à confirmer : le « dernier prix d'achat » attendu est-il celui
  de la réception ? · tests : T10 · sources : [GesTar.class:548](../../../../../.src/Gestion/Entrées/GesTar.class#L548)
- [ ] GESTAR-A04 — [anomalie] `Ligne_lostfocus` lit `$ligach.AutresObj` sans tester `$ligach`
  (focus dans un tableau de tarifs avant la lecture d'un article → erreur, à confirmer) ·
  tests : T03 · sources : [GesTar.class:230](../../../../../.src/Gestion/Entrées/GesTar.class#L230)
- [ ] GESTAR-A05 — [anomalie] `EnrTarArt` : `art_tr = Val(Left(Rem, -1))` suppose un `%` final ; une
  remise saisie `15` donne `1` · tests : T05 · sources : [GesTar.class:583](../../../../../.src/Gestion/Entrées/GesTar.class#L583)
- [ ] GESTAR-A06 — [anomalie] `_new` : base sans article → `Return` avant la création des tableaux,
  puis erreurs sur objets nuls (`_ready`, `Delete`) (à confirmer) · tests : aucun (base vide) ·
  sources : [GesTar.class:37](../../../../../.src/Gestion/Entrées/GesTar.class#L37), [GesTar.class:_ready](../../../../../.src/Gestion/Entrées/GesTar.class#L118-L131)
- [ ] GESTAR-A07 — [anomalie] `Enreg_Click` ouvre une transaction et lève `EnrTar`, dont le handler
  `commande1.Tarif_EnrTar` fait à nouveau `Begin`/`Commit` (imbrication, à confirmer selon le
  pilote) · tests : T05 · sources : [GesTar.class:Enreg_Click](../../../../../.src/Gestion/Entrées/GesTar.class#L516-L522), [commande1.class:Tarif_EnrTar](../../../../../.src/Gestion/Stock/commande1.class#L867-L876)
