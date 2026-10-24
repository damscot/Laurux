# Saisecrit — Rework

> Source : `.src/Compta/Saisecrit.class` · Message de commit (phase 4) : `reference/.src/Compta/Saisecrit.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2528 |
| Lignes de commentaire | 210 |
| Fonctions | 102 |
| Fonctions Public | 101 |
| Complexité cyclomatique totale | 654 |
| Complexité max (fonction) | 72 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 2528 | 654 | 72 | 0 | 101 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Fichier legacy (3148 lignes, CC 654) : reworks **minimaux et ciblés**, sans réécriture de la
logique de navigation (`LF`, `B`), ni changement de nom de handler ou de pseudo-handler.

- [ ] SAISECRIT-001 — [documentation] En-tête de classe en français : rôle, cycle d'une écriture
  (provisoire → validée), groupes `Cmpt`/`Btn` et liste des pseudo-handlers jamais levés par
  Gambas, colonnes cachées 7 à 10 de `Ecrit1`, signification de `LF`, `B`, `Modif`, `ecrA`, `Nv` ·
  appelants : aucun · tests : T01 · sources : [Saisecrit.class:_new](../../../../.src/Compta/Saisecrit.class#L82-L159), [Saisecrit.class:Cmpt_LostFocus](../../../../.src/Compta/Saisecrit.class#L1083-L1151)
- [ ] SAISECRIT-002 — [code mort] Supprimer les fonctions sans appel `renlig`, `Masque_Click`,
  `Compdate`, `FileFilter`, `Ecr2` et `numcompte_LostFocus` (nommé comme un handler mais inactif :
  `Numcompte` appartient au groupe `Cmpt` et `ReplayObserver` n'appelle dynamiquement que des
  `<Contrôle>_Click`) · appelants : aucun (grep) · tests : T01-T04, T11 · sources : [Saisecrit.class:renlig](../../../../.src/Compta/Saisecrit.class#L2393-L2409), [Saisecrit.class:Masque_Click](../../../../.src/Compta/Saisecrit.class#L2753-L2757), [Saisecrit.class:Compdate](../../../../.src/Compta/Saisecrit.class#L982-L992), [Saisecrit.class:FileFilter](../../../../.src/Compta/Saisecrit.class#L3141-L3148), [Saisecrit.class:Ecr2](../../../../.src/Compta/Saisecrit.class#L703-L733), [Saisecrit.class:numcompte_LostFocus](../../../../.src/Compta/Saisecrit.class#L1561-L1581)
- [ ] SAISECRIT-003 — [code mort] Variables d'instance écrites mais jamais lues (`ecriture`,
  `supp`, `Prg`, `sLind`, `Tri`, `n`), jamais renseignée (`txt`, après SAISECRIT-002), inutilisée
  (`$cpt`, masquée par la locale de `Button5_Click`) ; blocs `With Utils`/`With utils` sans usage
  de `.` (`Movt`, `ToggleButton8_Click`, `Button2_Click`) · appelants : aucun · tests : T01-T07 ·
  sources : [Saisecrit.class:30-74](../../../../.src/Compta/Saisecrit.class#L30-L74), [Saisecrit.class:Movt](../../../../.src/Compta/Saisecrit.class#L246-L286)
- [ ] SAISECRIT-004 — [commonalisation] Noms de tables par `Cbase.Table` : `Sha1Calc.CalcSha1`
  avec `Cbase.Table("TabMvt")` (2 appels, même valeur `Fiches_Mvt`), `Fiches_MvtM` →
  `Cbase.Table("TabMvtM")` (3 requêtes), `Fiches_Echeances` → `Cbase.Table("TabEch")`,
  `numcompte.champs("Fiches_Comptes", …)` → `Cbase.Table("TabComptes")` ; SQL émis identique ·
  appelants : aucun · tests : T01, T02, T05, T06 · sources : [Saisecrit.class:2087](../../../../.src/Compta/Saisecrit.class#L2087), [Saisecrit.class:2642](../../../../.src/Compta/Saisecrit.class#L2642), [Saisecrit.class:2491](../../../../.src/Compta/Saisecrit.class#L2491), [Saisecrit.class:2580](../../../../.src/Compta/Saisecrit.class#L2580), [Saisecrit.class:2695](../../../../.src/Compta/Saisecrit.class#L2695), [Saisecrit.class:dateEcheance](../../../../.src/Compta/Saisecrit.class#L179-L208), [Saisecrit.class:89](../../../../.src/Compta/Saisecrit.class#L89)
- [ ] SAISECRIT-005 — [commonalisation] Séquence `LVar` (`New Collection`, `New LVar`, `AddDate`,
  `ParseResult`, `Evaluate`, `Left`) remplacée par le helper commun proposé avec `Tresor`,
  `EcrAuto`, `ValidBR`, `ValidBR1` (4 occurrences ici) · appelants : `Tresor`, `EcrAuto`, `ValidBR`,
  `ValidBR1` (via leurs propres cases) · tests : T02, T09 · sources : [Saisecrit.class:406-416](../../../../.src/Compta/Saisecrit.class#L406-L416), [Saisecrit.class:LignAbt](../../../../.src/Compta/Saisecrit.class#L2962-L3055), [Tresor.class:LignAbt](../../../../.src/Compta/Tresor.class#L2470-L2563), [EcrAuto.class:293](../../../../.src/Compta/Utils/EcrAuto.class#L293)
- [ ] SAISECRIT-006 — [séparation traitement/GUI] `Calctva` : extraire la fonction pure
  `MontantTva(sClasse, sTypeJour, bGntva, sMontant, fMontantHt, sTaux) As Variant` et
  `CompteTva(sTable, sCode) As String` ; conversions (`Val` avec ou sans `Utils.cpoint`) et
  comparaison `montant.Text <> 0` conservées à l'identique · appelants : aucun · tests : T01, T02,
  T16 · sources : [Saisecrit.class:Calctva](../../../../.src/Compta/Saisecrit.class#L822-L888)
- [ ] SAISECRIT-007 — [complexité] Helper privé `AjouteLigneGrille(rResult As Result)` (colonnes 0
  à 10 de `Ecrit1` depuis une ligne de `Fiches_Mvt`) utilisé par `Movt`, `Ecrit1_Keypress`,
  `ecrit2` et `Ecrit3` (4 copies de la boucle de chargement ; traitements spécifiques à chaque
  appelant conservés dans la boucle) · appelants : aucun · tests : T04, T05, T07 · sources : [Saisecrit.class:Movt](../../../../.src/Compta/Saisecrit.class#L246-L286), [Saisecrit.class:Ecrit1_Keypress](../../../../.src/Compta/Saisecrit.class#L2277-L2321), [Saisecrit.class:ecrit2](../../../../.src/Compta/Saisecrit.class#L2449-L2518), [Saisecrit.class:Ecrit3](../../../../.src/Compta/Saisecrit.class#L2523-L2658)
- [ ] SAISECRIT-008 — [séparation traitement/GUI] Extraire de `QuitteDate` la fonction pure
  `ControleDate(sDate, dDebut, dFin) As Integer` (0 valide, 1 avant, 2 après) et de `Button5_Click`
  la fonction `MontantsGed(lignes As String[][]) As LPrix[]` (TTC, TVA, HT) ; messages et focus
  restent dans les appelants · appelants : aucun · tests : T08, T13, T16 · sources : [Saisecrit.class:QuitteDate](../../../../.src/Compta/Saisecrit.class#L997-L1059), [Saisecrit.class:Button5_Click](../../../../.src/Compta/Saisecrit.class#L3074-L3139)
- [ ] SAISECRIT-009 — [complexité] `Ecrit3` : délettrage par un seul `UPDATE … WHERE numlot = &2`
  au lieu de sa répétition pour chaque ligne trouvée ; `Enrg_Ecr` : `UPDATE Fiches_MvtA SET validee`
  sorti de la boucle des lignes (SQL modifié, dump identique) · appelants : aucun · tests : T03,
  T05, T12 · sources : [Saisecrit.class:2628-2633](../../../../.src/Compta/Saisecrit.class#L2628-L2633), [Saisecrit.class:2057](../../../../.src/Compta/Saisecrit.class#L2057)
- [ ] SAISECRIT-010 — [commonalisation] Lecture et sauvegarde des largeurs de colonnes
  (`/Soc<XX>/Col/LcolS`) par `Utils.LitLargeurs(cv, cle)` / `Utils.SauveLargeurs(cv, cle)`, partagés
  avec `Tresor`, `Extrait`, `Archives`, `Facture` ; supprime la double copie de `Button1_Click`
  (chaîne écrite identique, `col0` forcée à 0 et `col6` plafonnée à 80 conservés) · appelants :
  `Tresor`, `Extrait`, `Archives`, `Facture` (via leurs cases) · tests : T14 · sources : [Saisecrit.class:_new](../../../../.src/Compta/Saisecrit.class#L82-L159), [Saisecrit.class:Button1_Click](../../../../.src/Compta/Saisecrit.class#L2826-L2843)
- [ ] SAISECRIT-011 — [réduction de portée] → `Private` : `Cleanchamps`, `dateEcheance`, `Movt`,
  `compte`, `compteman`, `compteGman`, `Leccompteg`, `Journauxman`, `Journaux`, `Ecritures`,
  `Majnum`, `ecritnv`, `ecritv`, `Ecr1`, `ventil`, `ventilAuto`, `Lib`, `Calctva`, `aff_tva`,
  `QuitteDate`, `QuitteDate2`, `Type_compte`, `Enrg_Ecr`, `Calculsolde`, `Recup_Type`, `DelEcr`,
  `Ecrit_Click`, `ecrit2`, `Ecrit3`, `DelMvt`, `DelMvt2`, `clear`, `Sens_Ecr`, `Aff_Mask`, `Deb3`,
  `LignAbt` (aucun appelant externe, comportement couvert par les replays). `Bsel`/`Bval` restent
  `Public` (écrits par `TriCpt` via `Object.SetProperty`) · appelants : aucun · tests : T01-T15 ·
  sources : [Saisecrit.class:compteman](../../../../.src/Compta/Saisecrit.class#L323-L442), [Saisecrit.class:Enrg_Ecr](../../../../.src/Compta/Saisecrit.class#L2031-L2090), [Saisecrit.class:LignAbt](../../../../.src/Compta/Saisecrit.class#L2962-L3055), [TriCpt.class:112-113](../../../../.src/Affichages/TriCpt.class#L112-L113)
- [ ] SAISECRIT-012 — [réduction de portée] Variables d'instance à usage local → locales :
  `TypeAbt` (`Deb3`), `Cle` (affecté avant usage dans `Button4_Click`, `Enrg_Ecr`, `LignAbt`) ·
  appelants : aucun · tests : T01, T09 · sources : [Saisecrit.class:54](../../../../.src/Compta/Saisecrit.class#L54), [Saisecrit.class:63](../../../../.src/Compta/Saisecrit.class#L63)
- [ ] SAISECRIT-013 — [complexité] `Cmpt_KeyPress` (CC 72) : un `Select Case Last.Tag` délégant à
  des fonctions privées par champ (`ToucheJournal`, `ToucheDate`, `ToucheCompte`, `ToucheLibelle`,
  `ToucheDocument`, `ToucheLot`, `ToucheMontant`, `ToucheEcheance`) et une fonction pour les touches
  de fonction, ordre des tests et `Stop Event` inchangés (raccourcis du montant laissés sous
  l'échéance tant que SAISECRIT-A06 n'est pas validée) · appelants : aucun · tests : T08, T10, T11 ·
  sources : [Saisecrit.class:Cmpt_KeyPress](../../../../.src/Compta/Saisecrit.class#L1153-L1380)
- [ ] SAISECRIT-014 — [séparation traitement/GUI] `Enrg_Ecr` : extraire `ValideLigne(...)`
  (INSERT de la ligne, solde du compte, ligne et solde du collectif) appelée pour chaque ligne lue
  dans `Ecrit1` ; ordre des requêtes inchangé · appelants : aucun · tests : T01-T03, T05 ·
  sources : [Saisecrit.class:Enrg_Ecr](../../../../.src/Compta/Saisecrit.class#L2031-L2090)
- [ ] SAISECRIT-015 — [commonalisation] Phase 3 : fonctions communes avec `Tresor` (quasi
  identiques) dans un module partagé, contrôles passés en paramètre : `Deb3` (liste des masques),
  `Calculsolde`, calcul des lignes de `LignAbt`, `MontantsGed` (après SAISECRIT-008) · appelants :
  `Tresor` · tests : T09, T13 + replays de `Tresor` · sources : [Saisecrit.class:Deb3](../../../../.src/Compta/Saisecrit.class#L2904-L2929), [Tresor.class:Deb3](../../../../.src/Compta/Tresor.class#L2411-L2434), [Saisecrit.class:Calculsolde](../../../../.src/Compta/Saisecrit.class#L2253-L2272), [Tresor.class:Calculsolde](../../../../.src/Compta/Tresor.class#L1529-L1548)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAISECRIT-A01 — [anomalie] Numéro d'écriture lu puis écrit sans verrou (`Ecritures` +
  `Majnum`) : deux postes peuvent obtenir le même numéro ; correction par
  `DB_Connection.LockIncrement("numecriture", Cbase.Table("TabParam"))` (verrou et `Message.Error`
  supplémentaires) · tests : T08, T17 · sources : [Saisecrit.class:1035-1044](../../../../.src/Compta/Saisecrit.class#L1035-L1044), [Saisecrit.class:Ecritures](../../../../.src/Compta/Saisecrit.class#L611-L620), [Saisecrit.class:Majnum](../../../../.src/Compta/Saisecrit.class#L625-L629), [DB_Connection.class:LockIncrement](../../../../.src/Utils/DB_Connection.class#L553-L592)
- [ ] SAISECRIT-A02 — [anomalie] `Enrg_Ecr` sans transaction (écriture et soldes incohérents en cas
  d'erreur) ; soldes en lecture-modification-écriture (concurrence) ; suppression de la ligne de
  collectif soldée seulement pour le **dernier** collectif rencontré · tests : T01, T03 · sources : [Saisecrit.class:Enrg_Ecr](../../../../.src/Compta/Saisecrit.class#L2031-L2090), [Saisecrit.class:2083-2086](../../../../.src/Compta/Saisecrit.class#L2083-L2086)
- [ ] SAISECRIT-A03 — [anomalie] SQL par concaténation de saisies : `LIKE '<compte>%'`
  (`compteman`, `compteGman`), préfixe de journal (`Journaux`), `WHERE fo_code = <compte>` sans
  quotes (`Button5_Click`, comparaison numérique, erreur SQL si le compte contient une lettre) ;
  paramétrer par `&1` change le résultat dans ces cas limites · tests : T10, T13 · sources : [Saisecrit.class:383](../../../../.src/Compta/Saisecrit.class#L383), [Saisecrit.class:385](../../../../.src/Compta/Saisecrit.class#L385), [Saisecrit.class:451](../../../../.src/Compta/Saisecrit.class#L451), [Saisecrit.class:586](../../../../.src/Compta/Saisecrit.class#L586), [Saisecrit.class:3107](../../../../.src/Compta/Saisecrit.class#L3107), [Saisecrit.class:3113](../../../../.src/Compta/Saisecrit.class#L3113)
- [ ] SAISECRIT-A04 — [anomalie] `Dateech_DblClick` jamais levé (`Dateech` dans le groupe `Cmpt`,
  pas de `Cmpt_DblClick`) : le sélecteur `DateChooser1` n'apparaît jamais ; correction par un
  `Cmpt_DblClick` aiguillé sur `Tag` 8 (nouveau comportement visible) · tests : T11 · sources : [Saisecrit.class:Dateech_DblClick](../../../../.src/Compta/Saisecrit.class#L3057-L3065), [Saisecrit.class:DateChooser1_Activate](../../../../.src/Compta/Saisecrit.class#L3067-L3072)
- [ ] SAISECRIT-A05 — [anomalie] `Ecr1` : `LOCK TABLES Ecrs WRITE` posé avant `DROP`/`CREATE`
  et lecture de `Fiches_Mvt` non verrouillée pendant le verrou (erreurs masquées par `Try`, à
  confirmer sous MySQL) ; table `Ecrs` partagée entre postes ; colonne `intitule` remplie avec
  `libelle` · tests : T04 · sources : [Saisecrit.class:Ecr1](../../../../.src/Compta/Saisecrit.class#L672-L698)
- [ ] SAISECRIT-A06 — [anomalie] Raccourcis du montant (`<` → solde, `D` → débit, `C` → crédit)
  placés sous `Case 8` (échéance) au lieu de `Case 7` (montant) dans `Cmpt_KeyPress` · tests : T11 ·
  sources : [Saisecrit.class:1289-1308](../../../../.src/Compta/Saisecrit.class#L1289-L1308)
- [ ] SAISECRIT-A07 — [anomalie] `numdoc_LostFocus` : la réponse à « Voulez-vous continuer ? »
  (numéro de document déjà utilisé) est ignorée · tests : T10 · sources : [Saisecrit.class:1656-1657](../../../../.src/Compta/Saisecrit.class#L1656-L1657)
- [ ] SAISECRIT-A08 — [anomalie] `Ecrit1_Activate` sur grille vide exécute `DelEcr` et
  `Ecrit1.Current.Delete` (erreur probable) ; `Ecrit1_Keypress` recharge l'écriture par `num` au lieu
  de `numecrit.Text` (à confirmer) · tests : T07 · sources : [Saisecrit.class:2366-2367](../../../../.src/Compta/Saisecrit.class#L2366-L2367), [Saisecrit.class:2292](../../../../.src/Compta/Saisecrit.class#L2292)
- [ ] SAISECRIT-A09 — [anomalie] Appelants `Extrait.Necrit_Click`, `Ecritures.Necrit_Click`,
  `Fmontant` : `New Saisecrit(num, Me.Parent, True)` passe trois arguments à
  `_new(num2, Optional ecrmodif)` ; la répartition entre `_new` et le constructeur hérité de
  `Window` (parent) est à confirmer (T05) : `bmodif` (archivage `Fiches_MvtM`) pourrait ne pas être
  positionné comme prévu · appelants : `Extrait`, `Ecritures`, `Fmontant` · tests : T05 · sources : [Saisecrit.class:_new](../../../../.src/Compta/Saisecrit.class#L82-L159), [Extrait.class:1215](../../../../.src/Compta/Extrait.class#L1215), [Ecritures.class:397](../../../../.src/Compta/Utils/Ecritures.class#L397), [Fmontant.class:199](../../../../.src/Compta/Utils/Fmontant.class#L199)
