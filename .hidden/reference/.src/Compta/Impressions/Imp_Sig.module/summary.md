# Imp_Sig — Synthèse

> Source : `.src/Compta/Impressions/Imp_Sig.module` · Synthèse des autres documents.

## Rôle

Édition PDF des **soldes intermédiaires de gestion** (`~/tmp/SIG.pdf`, `Csig`, paysage) à partir des
rubriques `S…` et des écritures d'un exercice. Appelé uniquement par `RubImp` (bouton radio « SIG »).

## Points clés

- Une fonction `Lancement` (CC 60) : initialisation, table de travail `centralisation`,
  centralisation (Σ crédit − débit par rubrique), impression.
- Produits à gauche, charges à droite ; la chaîne marge → production → valeur ajoutée → EBE →
  résultat d'exploitation → résultat courant → résultat exceptionnel est codée par numéro de
  rubrique.
- Variables de calcul déclarées `String` (conversions implicites à chaque addition).
- Paramètres `Detail`, `dte1`, `dte2` sans effet ; pas de colonne N-1.
- Nombreuses variables mortes, un bloc jamais exécuté, une branche morte.

## Dépendances principales

- Appelé par : `RubImp.Button2_Click`.
- Utilise : `Csig` (PdfWriter), `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Dbase`,
  `Visualiseur.Prog`, `Start.Societe`, `Cbase.Table("TabComptes")`.
- Tables : `Fiches_Rubriques`, `Fiches_RubCompt`, une table `Fiches_Mvt…`, `Fiches_Societes` ; table
  de travail `centralisation`.

## Risques

- Écritures non validées incluses (A01) ; erreur de conversion possible sur un compte `709`
  (A02) ; signe dépendant de l'ordre des écritures (A03).
- Dépendance aux numéros de rubrique (A05) ; table de travail partagée (A06).
- Réécriture : conserver les conversions texte ↔ nombre à l'identique.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 403 |
| Lignes de commentaire | 66 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 61 |
| Complexité max (fonction) | 60 (`Lancement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (IMP_SIG-T01 à T07) : 6 replays depuis `RubImp` (exercice courant, exercice antérieur avec
écritures non validées, signes, pagination, éditions successives, rien à imprimer) comparant le
texte du PDF et le dump de `centralisation` ; 1 gbtest sur la chaîne des soldes après extraction.

## Rework

8 étapes (IMP_SIG-001 à 008) : documentation, code mort, helpers communs avec `Imp_Bilan`,
impression pilotée par table, découpage sans changement SQL, `Cbase`, variables locales,
séparation du message et du visualiseur. 6 anomalies (A01 à A06).
