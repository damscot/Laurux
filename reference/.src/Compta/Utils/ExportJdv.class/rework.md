# ExportJdv — Rework

> Source : `.src/Compta/Utils/ExportJdv.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/ExportJdv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 839 |
| Lignes de commentaire | 60 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 205 |
| Complexité max (fonction) | 103 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 839 | 205 | 103 | 0 | 33 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EXPORTJDV-001 — [documentation] En-tête en français : tableau des 6 formats (fichier, champs,
  encodage), fichier clients, effets de bord (`export = '1'`, `centralisations`, réglages, copie
  `JDV`), couplage avec ImpJdv/ImpSage · appelants : aucun · tests : aucun · sources : [ExportJdv.class:Button2_Click](../../../../../.src/Compta/Utils/ExportJdv.class#L502-L934)
- [ ] EXPORTJDV-002 — [code mort] Supprimer `finmois`, `donnees7`, le handler inactif
  `cpt_LostFocus` (contrôle du groupe `Cmpt`, aucun appel ; pas de modification du `.form`), les
  membres `Changedte`/`Changedate`/`Changedate2`/`debhp`/`credhp`/`totsldhp`, les locales
  `soldej`, `dateedition`, `Intit`, `p1` avec le bloc l.688-692 (jamais vrai), les affectations
  écrasées de `dte` (l.580-582) et d'`Intitcompte` (l.632) · appelants : aucun · tests : T01-T06, T12 · sources : [ExportJdv.class:finmois](../../../../../.src/Compta/Utils/ExportJdv.class#L152-L163), [ExportJdv.class:donnees7](../../../../../.src/Compta/Utils/ExportJdv.class#L472-L476), [ExportJdv.class:cpt_LostFocus](../../../../../.src/Compta/Utils/ExportJdv.class#L278-L282), [ExportJdv.class:580-583](../../../../../.src/Compta/Utils/ExportJdv.class#L580-L583), [ExportJdv.class:632](../../../../../.src/Compta/Utils/ExportJdv.class#L632), [ExportJdv.class:688-692](../../../../../.src/Compta/Utils/ExportJdv.class#L688-L692), [ExportJdv.class:862-863](../../../../../.src/Compta/Utils/ExportJdv.class#L862-L863)
- [ ] EXPORTJDV-003 — [réduction de portée] `Ex1`, `Exo`, `Compdate`, `compdate2`,
  `donnees1`…`donnees8`, `Raz`, `Controle`, `export` → `Private` (seul `Fmenu` ouvre la fenêtre ;
  couverts par les replays) · appelants : aucun · tests : tous · sources : [ExportJdv.class:Ex1](../../../../../.src/Compta/Utils/ExportJdv.class#L114-L147), [ExportJdv.class:Exo](../../../../../.src/Compta/Utils/ExportJdv.class#L165-L183), [ExportJdv.class:Controle](../../../../../.src/Compta/Utils/ExportJdv.class#L936-L971), [ExportJdv.class:export](../../../../../.src/Compta/Utils/ExportJdv.class#L985-L1012)
- [ ] EXPORTJDV-004 — [commonalisation] `dteN0_LostFocus`/`dteN1_LostFocus` : helper privé
  `NormaliseDate(sTexte) As String` (complétion `JJ`/`JJ.MM`, `Cdate_calc`, `Cdate_aff`, défaut du
  jour) ; `Compdate`/`compdate2` fusionnées (paramètre : champ à refocaliser) ; handlers conservés ·
  appelants : aucun · tests : T12 · sources : [ExportJdv.class:dteN0_LostFocus](../../../../../.src/Compta/Utils/ExportJdv.class#L292-L317), [ExportJdv.class:dteN1_LostFocus](../../../../../.src/Compta/Utils/ExportJdv.class#L325-L357), [ExportJdv.class:Compdate](../../../../../.src/Compta/Utils/ExportJdv.class#L359-L371), [ExportJdv.class:compdate2](../../../../../.src/Compta/Utils/ExportJdv.class#L373-L385)
- [ ] EXPORTJDV-005 — [commonalisation] Code client exporté (`cli_sage` si `/Soc<XX>/Sage`) dans un
  helper privé `CodeClientExport(r As Result) As String` (2 copies identiques) · appelants : aucun ·
  tests : T06 · sources : [ExportJdv.class:598-606](../../../../../.src/Compta/Utils/ExportJdv.class#L598-L606), [ExportJdv.class:789-797](../../../../../.src/Compta/Utils/ExportJdv.class#L789-L797)
- [ ] EXPORTJDV-006 — [commonalisation] Liste des journaux (`ToggleButton3_Click`, `coljour_Click`,
  `coljour_KeyPress`) via un helper commun `RemplitJournaux(hVue, Optional sType)` partagé avec
  `ImpJdv` (et `Intjdv` si conservé) ; `Svs2_Click` via le socle `ImpExp` (`ChoisirRepertoire`,
  annulation → `User.Home` ici) · appelants : `ImpJdv` · tests : T12 + IMPJDV-T01 · sources : [ExportJdv.class:ToggleButton3_Click](../../../../../.src/Compta/Utils/ExportJdv.class#L185-L213), [ExportJdv.class:Svs2_Click](../../../../../.src/Compta/Utils/ExportJdv.class#L973-L983), [ImpJdv.class:ToggleButton3_Click](../../../../../.src/Compta/Utils/ImpJdv.class#L625-L653)
- [ ] EXPORTJDV-007 — [réarchitecture] SQL : `Cbase.Table` pour `Fiches_Parametres`,
  `Fiches_Journaux`, `Fiches_Comptes`, `Fiches_Mvt` (`Tab0`) ; suppression de la clause `OR`
  redondante et du double test `jour` dans les sélections (résultat identique) · appelants :
  aucun · tests : T01-T08 · sources : [ExportJdv.class:616-625](../../../../../.src/Compta/Utils/ExportJdv.class#L616-L625), [ExportJdv.class:945](../../../../../.src/Compta/Utils/ExportJdv.class#L945), [ExportJdv.class:E0_Click](../../../../../.src/Compta/Utils/ExportJdv.class#L418-L423)
- [ ] EXPORTJDV-008 — [réarchitecture] `UPDATE Fiches_Mvt SET export` une seule fois par numéro
  d'écriture au lieu d'une fois par ligne (SQL modifié, dump identique) · appelants : aucun ·
  tests : T01, T08, T11 · sources : [ExportJdv.class:855](../../../../../.src/Compta/Utils/ExportJdv.class#L855)
- [ ] EXPORTJDV-009 — [complexité] `Button2_Click` (CC 103) : `Select Case` sur le code format
  calculé une fois ; fonctions **pures** `LigneTexte`, `LigneQuadra`, `LigneCiel`, `LigneWinner`,
  `LigneCador`, `LigneSage` (renvoient la chaîne, l'appelant l'écrit), `AjusteArrondi`,
  `ExporteClients(hFichier, iFormat)` ; fichiers produits identiques octet pour octet · appelants :
  aucun · tests : T01-T07, T14 · sources : [ExportJdv.class:Button2_Click](../../../../../.src/Compta/Utils/ExportJdv.class#L502-L934), [ExportJdv.class:donnees1](../../../../../.src/Compta/Utils/ExportJdv.class#L436-L440), [ExportJdv.class:donnees6](../../../../../.src/Compta/Utils/ExportJdv.class#L466-L470)
- [ ] EXPORTJDV-010 — [séparation traitement/GUI] Cœur `ExporteJournal(sJournal, dDeb, dFin,
  iFormat, sRep, bNonExportees) As Integer` sans contrôles ni messages (curseur, messages,
  éditeur, réglages et envoi restent dans `Button2_Click`) ; `Controle` renvoie la liste des
  clients sans code Sage au lieu d'écrire dans le fichier · appelants : aucun · tests : T01-T11 · sources : [ExportJdv.class:Button2_Click](../../../../../.src/Compta/Utils/ExportJdv.class#L502-L934), [ExportJdv.class:Controle](../../../../../.src/Compta/Utils/ExportJdv.class#L936-L971)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EXPORTJDV-A01 — [anomalie] Contrôle d'équilibre inopérant : `totsld = totdeb - totdeb` vaut
  toujours 0, un journal déséquilibré est exporté sans message (la branche « solde différent de 0 »
  est inatteignable) · tests : T10 · sources : [ExportJdv.class:864](../../../../../.src/Compta/Utils/ExportJdv.class#L864), [ExportJdv.class:886-893](../../../../../.src/Compta/Utils/ExportJdv.class#L886-L893)
- [ ] EXPORTJDV-A02 — [anomalie] Écritures marquées `export = '1'` à la lecture, avant tout
  contrôle : aussi en ré-export complet, et même si l'export est ensuite interrompu (exception attrapée
  par le `Catch`) ou déclaré vide (message « Aucune écriture », EXPORTJDV-A03) · tests : T08, T11, T13 · sources : [ExportJdv.class:855](../../../../../.src/Compta/Utils/ExportJdv.class#L855), [ExportJdv.class:931-932](../../../../../.src/Compta/Utils/ExportJdv.class#L931-L932)
- [ ] EXPORTJDV-A03 — [anomalie] `NbEcritures` est décrémenté à chaque ligne écrite pour les formats
  4 et 6 : sans ligne collectif, il vaut 0 et le message « Aucune écriture pour cette demande »
  s'affiche alors que le fichier a été écrit (et laissé ouvert) et les écritures marquées ; le
  premier champ du format 4 compte les lignes collectif (à confirmer) · tests : T04, T11 · sources : [ExportJdv.class:757](../../../../../.src/Compta/Utils/ExportJdv.class#L757), [ExportJdv.class:802](../../../../../.src/Compta/Utils/ExportJdv.class#L802), [ExportJdv.class:861](../../../../../.src/Compta/Utils/ExportJdv.class#L861), [ExportJdv.class:894-897](../../../../../.src/Compta/Utils/ExportJdv.class#L894-L897)
- [ ] EXPORTJDV-A04 — [anomalie] Format Sage, clients sans `cli_sage` : la liste est écrite **dans
  le fichier des écritures** puis ouverte dans l'éditeur sans fermeture ni vidage du fichier ;
  `hFile` reste ouvert · tests : T07 · sources : [ExportJdv.class:953](../../../../../.src/Compta/Utils/ExportJdv.class#L953), [ExportJdv.class:966](../../../../../.src/Compta/Utils/ExportJdv.class#L966)
- [ ] EXPORTJDV-A05 — [anomalie] Fin de traitement exécutée même en erreur (journal inexistant,
  code vide, aucune écriture) : réglages `Dte_exprt`/`Dte2_exprt`/`Numdoc_exprt` écrasés et
  `Shell "cp …"` lancé ; chemins non protégés (espaces) ; pour Sage, copie d'un `.txt` inexistant
  au lieu du `.pnm` · tests : T06, T09 · sources : [ExportJdv.class:920-923](../../../../../.src/Compta/Utils/ExportJdv.class#L920-L923)
- [ ] EXPORTJDV-A06 — [anomalie] `export()` : fichier clients toujours `clients.txt` (Sage :
  `clients.pnc`), chemins relus dans les réglages et non dans `Chmexport.Text` (modifié mais pas
  encore enregistré) ; le fichier clients n'est envoyé que pour le format 2 · tests : manuel · sources : [ExportJdv.class:991-1003](../../../../../.src/Compta/Utils/ExportJdv.class#L991-L1003)
- [ ] EXPORTJDV-A07 — [anomalie] `_New` lit `Fiches_Societes` sans `WHERE cd_sc = Start.Societe` ni
  test `Available` : en multi-sociétés, l'en-tête des fichiers porte l'intitulé de la première
  société · tests : T01 · sources : [ExportJdv.class:72-74](../../../../../.src/Compta/Utils/ExportJdv.class#L72-L74)
- [ ] EXPORTJDV-A08 — [anomalie] Table de travail `centralisations` jamais relue (code mort à effet
  sur le dump) ; SQL construit par concaténation (apostrophe dans l'intitulé d'un collectif →
  erreur, export interrompu) ; l'`UPDATE` des comptes non collectifs n'ajoute pas le crédit.
  Proposition : supprimer la table et son alimentation (le dump ne contient plus `centralisations`) ·
  tests : T13 · sources : [ExportJdv.class:570-577](../../../../../.src/Compta/Utils/ExportJdv.class#L570-L577), [ExportJdv.class:817-853](../../../../../.src/Compta/Utils/ExportJdv.class#L817-L853)
- [ ] EXPORTJDV-A09 — [anomalie] Contrôles de saisie seulement au clavier : `DteN0`, `Dten1`, `Cpt`
  étant dans le groupe `Cmpt`, leurs handlers nominaux `*_LostFocus` ne sont jamais déclenchés par
  un changement de focus à la souris (date non normalisée, fond vert persistant) ; un
  `Cmpt_LostFocus` les rétablirait · tests : T12 · sources : [ExportJdv.class:Cmpt_KeyPress](../../../../../.src/Compta/Utils/ExportJdv.class#L215-L252), [ExportJdv.class:dteN0_LostFocus](../../../../../.src/Compta/Utils/ExportJdv.class#L292-L317)
- [ ] EXPORTJDV-A10 — [anomalie] Contenu des formats à faire valider par un utilisateur des
  logiciels cibles : format 2 (Quadra) avec le montant écrit dans les deux colonnes, format 1 avec
  apostrophes échappées `\'` dans un CSV, intitulé société en 1re ligne (incompatible avec
  `ImpJdv`, IMPJDV-A05), ajustement silencieux des écarts < 0,03 sur les montants exportés · tests :
  T01, T02, T15 · sources : [ExportJdv.class:747](../../../../../.src/Compta/Utils/ExportJdv.class#L747), [ExportJdv.class:744](../../../../../.src/Compta/Utils/ExportJdv.class#L744), [ExportJdv.class:588-589](../../../../../.src/Compta/Utils/ExportJdv.class#L588-L589), [ExportJdv.class:697-709](../../../../../.src/Compta/Utils/ExportJdv.class#L697-L709)
- [ ] EXPORTJDV-A11 — [anomalie] Format 4 (CCMX Winner) : `Button2_Click` appelle `Donnees4` avec
  **9 arguments** alors que la méthode en déclare 8 (`p1` à `p8`) : erreur Gambas « Too many
  arguments » dès la première ligne non collectif, l'export CCMX Winner n'aboutit jamais (à confirmer
  par T16). Détecté par le contrôle d'arité de `deps.py` · tests : T16 · sources : [ExportJdv.class:758](../../../../../.src/Compta/Utils/ExportJdv.class#L758), [ExportJdv.class:donnees4](../../../../../.src/Compta/Utils/ExportJdv.class#L454-L458)
- [ ] EXPORTJDV-A12 — [anomalie] (ajoutée après le lot Gestion-2, voir ENVMAIL-A01) Format 2 : `export()`
  appelle `EnvMail.Envoi3` avec **5 arguments** pour 4 : « Too many arguments » (vérifié sur un projet
  minimal) capté par le `Catch`, l'export en deux fichiers n'est jamais envoyé par courriel. Correction
  proposée : `Envoi2(…, Fle1, Fle2)`, puis suppression d'`Envoi3` (ENVMAIL) · tests : T16 · sources : [ExportJdv.class:1000](../../../../../.src/Compta/Utils/ExportJdv.class#L1000), [EnvMail.module:Envoi3](../../../../../.src/Gestion/Mails/EnvMail.module#L87-L122)
