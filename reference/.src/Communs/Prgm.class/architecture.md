# Prgm — Architecture

> Source : `.src/Communs/Prgm.class` (+ `Prgm.form`)

## Vue d'ensemble

`Prgm` est la fenêtre **« Appel de programme »** : l'utilisateur saisit le nom d'un programme dans
`Prg` (éventuellement suivi d'arguments séparés par des espaces) puis valide (`Lancer` ou Entrée).
`Button1_Click` compare le premier mot à une liste de noms codés en dur et lance l'écran ou le
script correspondant. Elle est ouverte par l'auto-instance (`Prgm.Show`) depuis
[`Fmenu`](../Fmenu.class/architecture.md) : menu « Gestion > Outils > Appel programme »
(`Menu282`) et le séparateur inatteignable `Menu141`.

C'est la porte d'entrée de **scripts de maintenance et de réparation**, dont plusieurs modifient
massivement la base **sans confirmation ni transaction**. Si `/Soc<XX>/Admin` est actif, un
panneau de mot de passe (`HBox1`, superposé au champ de saisie) est affiché à l'ouverture.

Nature globale : **GUI** (dispatcher), plus un `TRUNCATE` direct (`RazDocactif`).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 3-15 | Public | 2 | 11 | 0 | méthode spéciale |
| `Mdp_KeyPress` | 20-24 | Public | 4 | 3 | 0 | handler GUI |
| `Mdp_LF` | 26-45 | Public | 5 | 17 | 0 | portée réductible ? |
| `Button1_Click` | 47-116 | Public | 38 | 64 | 0 | handler GUI |
| `Button2_Click` | 118-122 | Public | 1 | 3 | 0 | handler GUI |
| `Prg_KeyPress` | 124-128 | Public | 3 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre, enregistre les observateurs de
  replay ; si `/Admin`, affiche `HBox1` et place le focus sur `Mdp`, sinon sur `Prg`.
- **`Mdp_KeyPress()`** [handler] [GUI]. Entrée, Retour ou **Tab** → `Mdp_LF()`.
- **`Mdp_LF()`** [portée : réductible, mais nom de type handler : conservé] [nature : mixte].
  Déchiffre `/Soc<XX>/MdpPrefs` (`hexdblKey.Crypt("de", …, "Laurux")`) et le compare à la saisie.
  Échec : son (si `Start.son`), `Message.Error`, sélection du texte. Succès : efface la saisie et
  masque `HBox1`. Quasi identique à [`MDP.Mdp2_LF`](../MDP.class/architecture.md) (sans la variante
  globale ni `Start.Motdepasse`).
- **`Button1_Click()`** [handler] [mixte] (CC 38). `Split(Prg.Text, " ")`, premier mot = nom du
  programme, le reste = arguments ; puis 36 tests `If Prog = "…"` successifs (au plus un vrai), et
  `Me.Close` final. Ne vérifie **pas** que le mot de passe a été validé (seul le recouvrement
  visuel par `HBox1` empêche la saisie, à confirmer : PRGM-A01). Comparaison **sensible à la casse**.
- **`Button2_Click()`** [handler] [GUI]. Ferme.
- **`Prg_KeyPress()`** [handler] [GUI]. Entrée ou Retour → `Button1_Click()`.

### Liste exhaustive des noms acceptés

« Destructeur » = écrit en base (ou dans des fichiers) sans demander de confirmation ; « écran » =
ouvre une fenêtre qui porte ses propres contrôles. Les appels `.Show` / `.ShowModal` / `.run`
visent l'auto-instance ou la méthode statique de la classe.

| Nom saisi | Appel (ligne) | Classe cible | Effet | Confirmation |
|---|---|---|---|---|
| `Exprub` | `Exprub.run` (58) | `Compta/Utils/Exprub.class` | génère les fichiers texte de paramétrage (comptes de résultat, bilan, SIG) `~/Bcr.txt`, `~/Bcrcpt.txt` | oui (écrasement des fichiers) |
| `Impclient` | `Impclient.show` (59) | `Utils/Exports-Imports/Impclient.class` | écran d'import clients (aussi `Fmenu.Menu152`) | écran |
| `Calcsolde` | `Calcsolde.show` (60) | [`Utils/Calcsolde.class`](../../Utils/Calcsolde.class/architecture.md) | écran de recalcul des soldes (aussi `Menu76`) | écran |
| `CalcRem` | `CalcRem.show` (61) | [`Utils/CalcRem.class`](../../Utils/CalcRem.class/architecture.md) | écran de recalcul des remises | écran |
| `Expcontact` | `Expcontact.show` (62) | `Utils/Exports-Imports/Expcontact.class` | export des contacts (aussi `Menu283`) | écran |
| `Impcpostaux` | `Impcpostaux.Show` (63) | `Utils/Exports-Imports/Impcpostaux.class` | import des codes postaux (aussi `Menu284`) | écran |
| `RecupN` | `RecupN.run()` (64) | [`Utils/RecupN.class`](../../Utils/RecupN.class/architecture.md) | recopie les écritures 1 à 424 de `Fiches_Mvt1` vers `Fiches_Mvt` | **non — destructeur** (RECUPN-A01) |
| `Pmp` | `VisPmp.Show` (65) | [`Utils/VisPmp.class`](../../Utils/VisPmp.class/architecture.md) | visualisation des PMP | écran |
| `Dcfour` | `Dcfour.Show` (66) | [`Utils/Dcfour.class`](../../Utils/Dcfour.class/architecture.md) | doublons de références fournisseurs | écran |
| `Epurfour` | `Epurfour.run()` (67) | [`Utils/Epurfour.class`](../../Utils/Epurfour.class/architecture.md) | vide `art_cfour` de tous les articles | **non — destructeur** (EPURFOUR-A01) |
| `Papmp` | `Papmp.run()` (68) | [`Utils/Papmp.class`](../../Utils/Papmp.class/architecture.md) | PMP = prix de revient pour tous les articles ; met `Prgm.Mouse` en attente | oui (`Message.Question`) |
| `Tbord` | `TBord.Show()` (70) | `Statistiques/TBord.class` | tableau de bord (aussi `Menu251`) | écran |
| `eff` | `RazHistoFac.Show()` (71) | `Archivages/RazHistoFac.class` | épuration des factures archivées (aussi `Menu259`) | écran |
| `eft` | `RazHistoTk.Show()` (72) | `Archivages/RazHistoTk.class` | épuration des tickets (aussi `Menu260`) | écran |
| `efb` | `RazHistoFbl.Show()` (73) | `Archivages/RazHistoFbl.class` | épuration des BL fournisseurs (aussi `Menu261`) | écran |
| `RenAN` | `RenAN.run()` (74) | `Compta/Utils/RenAN.class` | renumérote à 1 les « Report a nouveau » de `Fiches_Mvtoc` — **table absente de `db_control.csv`** : erreur SQL attendue (PRGM-A06) | non — destructeur |
| `Impdep` | `ImpDepots.Show()` (75) | `Gestion/Depots/ImpDepots.class` | impression du stock des dépôts (aussi `Menu272`) | écran |
| `Edsdep` | `Edsdepots.Show()` (76) | `Gestion/Depots/Edsdepots.class` | impression des mouvements de dépôts (aussi `Menu273`) | écran |
| `Raz` | `Raz.Showmodal()` (77) | [`Communs/Raz.class`](../Raz.class/architecture.md) | remise à « non stocké » de tous les articles | oui (dans l'écran) |
| `RazEcr` | `RazEcr.Showmodal()` (78) | `Compta/Utils/RazEcr.class` | écran `RazEcr` (non documenté à ce stade, lot Compta) | écran |
| `RazClos` | `RazClos.Showmodal()` (79) | `Compta/Utils/RazClos.class` | déblocage des écritures (aussi `Menu311`) | écran |
| `Blocsoc` | `Fblocsoc.ShowModal()` (80) | [`Communs/Fblocsoc.class`](../Fblocsoc.class/architecture.md) | blocage de la table des sociétés | écran |
| `Fsoc` | `Fsoc.ShowModal()` (81) | `Communs/Fsoc.class` | **auto-instance impossible** : `Fsoc._New(hform As Form)` exige un argument → erreur d'exécution attendue (PRGM-A03) | — |
| `RenMvt` | `RenMvt.Run()` (82) | `Compta/Utils/RenMvt.module` | déplace les écritures du journal `80` de `Fiches_Mvt` vers `Fiches_Mvt1` (INSERT + DELETE) | **non — destructeur** |
| `RecupDech` | `RecupDech.Run()` (83) | `Compta/Utils/RecupDech.class` | exporte les dates d'échéance 401/411 vers `~/tmp/Dtech.txt` | non (fichier) |
| `Renech` | `Renech.Run()` (84) | `Compta/Utils/Renech.class` | réimporte `~/Dtech.txt` (chemin différent de `RecupDech`) dans `dateech` de `TabMvt` | **non — destructeur** |
| `ImptartypeC` | `ImptartypeC.ShowModal()` (85) | `Utils/Exports-Imports/ImptartypeC.class` | import de tarifs par type client | écran |
| `CompArt` | `CompArt.ShowModal()` (86) | [`Utils/CompArt.class`](../../Utils/CompArt.class/architecture.md) | comparaison d'articles | écran |
| `ImportStk` | `ImportStk.ShowModal()` (87) | `Utils/Exports-Imports/ImportStk.class` | comparaison des articles avec un fichier texte (écarts dans `~/tmp/Diff.txt`) | écran |
| `CalcSha1` [*suffixe*] | `Sha1Calc.CalcSha1_all("Fiches_Mvt" & Arga[0])` ou `("Fiches_Mvt")` (88-94) | `Utils/Sha1Calc.module` | recalcule la colonne `control` (clé SHA1) de `Fiches_Mvt` ou `Fiches_Mvt<suffixe>` ; suffixe **concaténé** sans contrôle (PRGM-A04) | non (barre de progression interruptible) |
| `RazDocactif` | `Truncate table Fiches_Docactif` (95-99) | — | vide **tous** les verrous de documents (tous postes), `Message.Info`, fermeture | **non — destructeur** |
| `MajEqu` | `MajEqu.Recup()` (100-105) | `Gestion/Stock/Tarifs/MajEqu.module` | complète les équivalences d'articles (`TabCequ`) par symétrie/transitivité (`Try INSERT`) | non |
| `HistoCom` | `HistoCom.run()` (106-110) | [`Utils/HistoCom.class`](../../Utils/HistoCom.class/architecture.md) | réparation 3.16 des commentaires de factures | **non — destructeur** (HISTOCOM-A01) |
| `RenumBl` | `RenumBl.run()` (111) | [`Utils/RenumBl.class`](../../Utils/RenumBl.class/architecture.md) | réparation des doublons de numéros de facture | **non — destructeur** (RENUMBL-A01) |
| `Equilibrage` | `Equilibrage.ShowModal()` (112) | `Compta/Utils/Equilibrage.class` | équilibrage des écritures | écran |
| `Deblockbl` | `Deblockbl.ShowModal` (113) | [`Communs/Deblockbl.class`](../Deblockbl.class/architecture.md) | déblocage d'un document (non fonctionnel, DEBLOCKBL-A01) | écran |

Ligne 69 : `'IF Prog = "Import"…` est commentée. Tout autre nom ne fait rien d'autre que fermer la
fenêtre. 36 noms au total.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Admin"]`, `["/Soc<XX>/MdpPrefs"]`, `Start.Societe`, `Start.son`.
- `hexdblKey.Crypt` (déchiffrement du mot de passe), `Utils.Observers`, `Utils.db.Exec`.
- `Papmp.run` modifie `Prgm.Mouse` (auto-instance de cette fenêtre).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer les 36 `If Prog = …` par un `Select Case Prog` : même résultat (les noms sont
  distincts, un seul test peut réussir), lecture plus simple. La complexité mesurée baisse peu (le
  compteur compte les `Case`), mais l'évaluation s'arrête au premier cas trouvé.
- Constante `Tab` : `Cbase.Table("TabActif")` renvoie déjà `Fiches_Docactif` (SQL identique).
- Supprimer la ligne commentée `Import` et `'Arga = New String[]`.

### Commonalisation avec d'autres fichiers

- `Mdp_LF` et [`MDP.Mdp2_LF`](../MDP.class/architecture.md) : même déchiffrement et même message ;
  une fonction pure `MDP.Verifie(sSaisie, Optional bGlobal) As Boolean` (MDP-003) servirait aux deux.
- Les scripts `run` lancés ici (`RecupN`, `Epurfour`, `Papmp`, `HistoCom`, `RenumBl`, `RenAN`,
  `Renech`, `RecupDech`, `RenMvt`, `Exprub`) pourraient être regroupés dans un module
  `Maintenance` (proposition [PAPMP-003](../../Utils/Papmp.class/rework.md)) ; `Prgm` n'aurait
  alors qu'une table nom → procédure.

### Réduction de portée

- `Mdp_LF` n'a pas d'appelant externe, mais son nom suit le schéma `Objet_Evenement` : on le
  conserve `Public` (prudence vis-à-vis du replay).

### Séparation traitement / GUI

- `RazDocactif` : le `TRUNCATE` va dans une procédure privée `VideVerrous()`, le handler garde le
  `Message.Info` et la fermeture.
- Le découpage du texte (`Split`, arguments) devient une fonction pure `Commande(sTexte) As
  String[]` testable en gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : `Prgm` ne lit pas le schéma. Une table de paramétrage des scripts autorisés (nom, niveau
  de danger, confirmation) remplacerait la liste codée en dur.
