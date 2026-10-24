# Expcontact — Architecture

> Source : `.src/Utils/Exports-Imports/Expcontact.class` · Form : `Expcontact.form`

## Vue d'ensemble

Fenêtre d'**export des contacts au format vCard 3.0** vers le fichier fixe `~/Contacts.vcf`.
Selon `RadioButton1`, elle exporte les clients (`Fiches_Cli`, puis les contacts clients de
`Fiches_ContactC`) ou les fournisseurs (`Fiches_Four`). Une carte `BEGIN:VCARD … END:VCARD` est
écrite par fiche (nom, prénom, mail, téléphones, adresse, raison sociale en `TITLE`, observations
en `NOTE`, site web).

Ouverte par `Fmenu.Menu283_Click` (« Export des contacts ») et `Prgm` (programme `Expcontact`).
Nature globale : **mixte** (lecture SQL + formatage + écriture fichier dans le handler).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `statut` | var | Private |  | String | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-9 | Public | 1 | 3 | 0 | méthode spéciale |
| `Button2_Click` | 11-15 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 17-125 | Public | 9 | 103 | 0 | handler GUI |
| `Aff_Statut` | 127-136 | Public | 3 | 7 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre (pas de
  `Music.Load`, contrairement aux fenêtres voisines).
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : mixte].
  - `SELECT * FROM Fiches_Cli` ou `Fiches_Four` (noms en dur) ; si vide : `Message.Error` et le
    fichier **n'est pas ouvert**.
  - Ouvre `User.Home & "/Contacts.vcf"` (écrasé), écrit une vCard par ligne. Pour les clients,
    `Aff_Statut(cli_statut)` est appelé mais le libellé obtenu n'est **pas écrit** (seule la ligne
    CSV commentée l.90 l'utilisait). `Pays`, `Fx` et `cpt` sont lus mais non exportés.
  - Clients seulement : `SELECT * FROM Cbase.Table("TabContact")` (`Fiches_ContactC`) et une vCard
    par contact ; `Poste` et `Portable` reçoivent tous deux `tel` ; `Teldom` n'est pas réinitialisé
    (valeur du dernier client).
  - Musique (sans test de `Start.Son` et sans `Music.Load`), `Message.Info`, `Close`, fermeture.
  Partie extractible : `VCard(...) As String` (formatage pur, dupliqué l.89 et l.115) et
  `ExporterContacts(bClients, sFichier) As Integer`.
- **`Aff_Statut(sStatut)`** [portée : réductible (aucun appelant externe)] [nature : calcul].
  `SELECT * FROM Cbase.Table("TabStatut") WHERE code = &1` ; écrit le libellé dans la variable
  d'instance `statut`. Le test `If Not Error` n'est précédé d'aucun `Try` (inopérant).

## État global utilisé

- `Utils.db`, `Cbase.Table("TabContact")`, `Cbase.Table("TabStatut")`.
- Variable d'instance `statut` (String) partagée entre `Button1_Click` et `Aff_Statut`.

## Anomalies relevées

- Table client/fournisseur vide : le fichier n'est pas ouvert, mais la boucle des contacts (clients)
  et `Close #HFil` s'exécutent quand même → erreur d'exécution (`Null object`).
- `Teldom` des contacts = téléphone domicile du dernier client exporté.
- Aucune protection des caractères spéciaux vCard (`,`, `;`, retours ligne dans `NOTE`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Un seul `Private Function VCard(...)` au lieu des deux lignes `Print` de 400 caractères.
- Supprimer les lectures de `Pays`, `Fx`, `cpt` non exportées. L'appel `Aff_Statut` est sans effet
  sur le fichier produit mais émet une requête : sa suppression modifie les lignes `Exec_SQL` du
  log ; le replay doit alors comparer le fichier `.vcf` et non le log SQL.

### Commonalisation avec d'autres fichiers

- [`Expclient`](../Expclient.class/architecture.md) lit les mêmes colonnes client
  (`cli_rs_soc`, `cli_nom`, `cli_pnm`, `cli_adr1/2`, `cli_cd_ptl`, `cli_ville`, `cli_email`) : une
  fonction commune de lecture d'adresse client peut servir aux deux exports.
- Socle commun d'import/export (voir [`Impclient`](../Impclient.class/architecture.md)) :
  `FinTraitement`, ouverture/fermeture sûre du fichier de sortie.

### Réduction de portée

- `Aff_Statut` → `Private`.

### Séparation traitement / GUI

- Le choix client/fournisseur (`RadioButton1.Value`) est lu deux fois dans la boucle : le lire une
  fois dans le handler et le passer en paramètre à une fonction d'export sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_ContactC` n'a qu'un champ `tel` : des colonnes distinctes (fixe, portable, poste)
  permettraient un export vCard fidèle.
