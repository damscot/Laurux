# DocActif — Architecture

> Source : `.src/Communs/DocActif.class`

## Vue d'ensemble

`DocActif` a deux rôles dans une seule classe de fenêtre :

1. **Service de verrous applicatifs** sur les documents (`Is_Lock`, `Get_Lock`, `Free_Lock`),
   appelé par 9 fichiers via l'**auto-instance** de la fenêtre (`DocActif.Get_Lock(…)` sans
   `New`) : facturation, caisse (avoirs, acomptes), achats, règlements, paramètres. Un verrou est
   une ligne de `Fiches_Docactif` (`Cbase.Table("TabActif")`), clé primaire `(doc_type, doc_num)`,
   qui enregistre le propriétaire : utilisateur système, PID Gambas, `/etc/machine-id`,
   `hostname(hostid)` et login de la base.
2. **Fenêtre d'administration des verrous** (Fmenu `Menu328`, `DocActif.Show()`) : liste des
   verrous et suppression manuelle par clic.

L'identité du poste est calculée une fois par instance dans `_new` (trois commandes `Shell`).
Les sections critiques utilisent `LOCK TABLES … WRITE` / `UNLOCK TABLES` (neutralisés sous SQLite
par `DB_Connection`, où seule la clé primaire protège des doublons).

Nature globale : **mixte** ; les fonctions de verrou mêlent SQL et boîtes de dialogue modales
(affichées **pendant** que la table est verrouillée).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `user_name` | var | Private |  | String | 3 |
| `process_id` | var | Private |  | Integer | 4 |
| `machine_id` | var | Private |  | String | 5 |
| `host_id` | var | Private |  | String | 6 |
| `userdb_name` | var | Private |  | String | 7 |
| `Tactive` | var | Private |  | String | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 10-19 | Public | 1 | 9 | 0 | méthode spéciale |
| `Form_Open` | 21-46 | Public | 1 | 20 | 0 | handler GUI |
| `Deb1` | 48-53 | Public | 1 | 4 | 0 | portée réductible ? |
| `listdoc_Data` | 56-72 | Public | 1 | 14 | 0 | handler GUI |
| `Is_Lock` | 77-89 | Public | 3 | 10 | 4 |  |
| `Get_Lock` | 94-136 | Public | 13 | 39 | 8 |  |
| `Free_Lock` | 138-173 | Public | 12 | 30 | 8 |  |
| `listdoc_Click` | 175-193 | Public | 4 | 14 | 0 | handler GUI |
| `Button1_Click` | 196-200 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Identité du poste

- **`_new()`** [portée : nécessaire] [nature : calcul] : `Shell "cat /etc/machine-id"`,
  `Shell "hostname"`, `Shell "hostid"` ; tronque `machine_id`, `host_id` (« hostname(hostid) ») et
  `userdb_name` (`Utils.db.Login`) à 50 caractères. Les membres `user_name` (`User.Name`) et
  `process_id` (`Application.Id`) sont initialisés à la déclaration ; `Tactive` vaut
  `Cbase.Table("TabActif")`. L'auto-instance est créée au premier appel statique ; si l'utilisateur
  ferme la fenêtre d'administration, elle est recréée (et les `Shell` relancés) au prochain appel
  (à confirmer).

### Service de verrous

- **`Is_Lock(DocType, DocNum, msg = True)`** [portée : nécessaire : Tresor, EcrAuto, Facture,
  Materiel] [nature : mixte]. SQL `SELECT * FROM TabActif WHERE doc_type = &1 AND doc_num = &2`.
  Renvoie `True` si une ligne existe (avec `Message.Info` si `msg`), quel qu'en soit le
  propriétaire.
- **`Get_Lock(DocType, DocNum)`** [portée : nécessaire : Caisse, Parametre, Tresor, EcrAuto,
  Facture, Facturergbl, commande1, ObjFacB] [nature : mixte] (CC 13). Sous `LOCK TABLES WRITE` :
  - pas de ligne → `INSERT` du propriétaire courant, renvoie `True` ;
  - ligne du même utilisateur/machine/hôte/login et même PID → `Message.Info` « déjà pris par le
    process courant », `True` ;
  - même propriétaire, autre PID : `ps -p <pid>` ; si le processus n'existe plus, `Message.Warning`
    « Supprimer / Annuler » ; « Supprimer » → `UPDATE … SET process_id = <pid courant>`, `True` ;
    si le processus existe, avertissement et `False` ;
  - autre propriétaire → avertissement et `False`.
  Puis `UNLOCK TABLES`. ⚠️ La variable de retour `bok` est déclarée `String` : `True`/`False` sont
  convertis en « T »/« » puis reconvertis en booléen au `Return` ; le résultat est correct mais
  repose sur cette conversion implicite (à confirmer par test). ⚠️ Les dialogues sont modaux
  alors que la table est verrouillée en écriture : les autres postes attendent.
- **`Free_Lock(DocType, DocNum)`** [portée : nécessaire : Caisse, Parametre, Tresor, EcrAuto,
  Facture, Facturergbl, commande1, ObjFacB] [nature : mixte] (CC 12). Sous `LOCK TABLES WRITE` :
  ligne absente → avertissement « Lock inexistant » ; plusieurs lignes (impossible avec la clé
  primaire) → question, et **`Return False` sans `UNLOCK TABLES`** ; propriétaire différent ou
  autre PID → « Forcer Libérer / Annuler » ; sinon `DELETE`. ⚠️ Déclarée `As Boolean` mais **ne
  renvoie jamais de valeur** (donc toujours `False`) : `Facture` (l.1523, l.1946) teste ce retour
  et sa branche `If bok Then … Return` n'est jamais exécutée.

### Fenêtre d'administration

- **`Form_Open()`** [handler] [GUI] : titres et largeurs des 7 colonnes de `listdoc`, puis `Deb1`.
- **`Deb1()`** [portée : réductible] [mixte] : `Utils.Base2(listdoc, "SELECT * FROM TabActif")`,
  qui charge le résultat dans le **global partagé** `Utils.rs2`.
- **`listdoc_Data(Row, Column)`** [handler] [GUI] : reconstruit à chaque cellule le tableau des 7
  noms de colonnes, puis `Utils.rs2.MoveTo(Row)` et `Str(valeur)`. Si un autre écran réutilise
  `Utils.rs2` pendant que la fenêtre est ouverte, l'affichage devient incohérent.
- **`listdoc_Click()`** [handler] [mixte] : confirmation, puis
  `DELETE FROM TabActif WHERE doc_type = &1 AND doc_num = &2` **sans contrôle de propriétaire**,
  sous `Try` (`Message.Error` en cas d'échec) ; rechargement.
- **`Button1_Click()`** [handler] : `Me.Close()`.

## État global utilisé

- `Utils.db` (SQL, `Login`), `Utils.Base2`, `Utils.rs2` (Result global partagé), `Utils.Bip`.
- `User.Name`, `Application.Id`, commandes `cat`, `hostname`, `hostid`, `ps`.
- Auto-instance de la classe (forme `DocActif.Méthode`) : état d'identité partagé par tous les
  appelants.

## Propositions d'amélioration

### Réécriture / refactorisation

- Typer `bok` en `Boolean` dans `Get_Lock` et `Free_Lock` (résultat identique pour `Get_Lock`,
  à vérifier par test ; pour `Free_Lock`, renvoyer la valeur change le comportement : anomalie A01).
- Garantir `UNLOCK TABLES` sur tous les chemins (`Finally` ou sortie unique).
- `listdoc_Data` : tableau constant des colonnes en membre privé.
- `_new` : `File.Load("/etc/machine-id")` à la place de `Shell "cat"` (même contenu, sans
  processus) ; `hostname`/`hostid` conservés (`System.Host` n'est pas garanti identique).

### Commonalisation avec d'autres fichiers

- Le schéma « Get_Lock → écran modal → Free_Lock » est recopié dans `Parametre`, `Facture`,
  `commande1`, `Tresor`, `EcrAuto`, `ObjFacB` (boucle active `Repeat … Until get_lock`),
  `Facturergbl`, `Caisse`. Une méthode `AvecVerrou(type, num)` n'est pas exprimable simplement en
  Gambas ; en revanche une fonction `Proprietaire(type, num) As String` (texte des messages)
  éviterait la répétition des quatre messages longs.
- Voir [Parametre](../Parametre.class/architecture.md) (résultat de `Get_Lock` ignoré).

### Réduction de portée

`Deb1` : aucun appelant externe (grep `DocActif.Deb1`). `Is_Lock`, `Get_Lock`, `Free_Lock`
restent `Public`.

### Séparation traitement / GUI

Dans le même fichier : `LireVerrou(type, num) As Result`, `PoserVerrou`, `ReprendreVerrou`,
`SupprimerVerrou` (SQL seul), et une fonction pure `Statut(rVerrou) As Integer` (libre, pris par ce
processus, par un autre processus vivant du même poste, par un processus mort du même poste, par
un autre poste) ; les messages restent dans `Get_Lock`/
`Free_Lock`. Le déplacement du service vers un module distinct de la fenêtre (recommandé : un
service sans état GUI ne devrait pas vivre dans l'auto-instance d'une `Form`) est hors périmètre
de ce plan.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Ajouter une colonne d'horodatage (`date_lock`) pour détecter et purger les verrous orphelins
  (processus disparu sur une autre machine, non vérifiable par `ps`).
- Remplacer `LOCK TABLES` par un `INSERT` atomique s'appuyant sur la clé primaire
  (`INSERT … ON DUPLICATE KEY` ou détection de l'erreur de doublon), portable sous SQLite.
