# Ouverture — Architecture

> Source : `.src/Caisse/Ouverture.class`

## Vue d'ensemble

`Ouverture` est l'écran « Identification caisse » : il **connecte une caisse** du poste à un
vendeur (caissière) après contrôle de son mot de passe. Il est ouvert en modal par
`Cmenu.Button1_Click` sur son **auto-instance** (`Ouverture.ShowModal()`), que le clavier
virtuel [`Clavier`](../Clavier.class/architecture.md) pilote aussi (`Ouverture.Mdp.Text`,
`Ouverture.Button1_Click()`).

La connexion réussie :
1. crée le fichier verrou `~/Caisse<n>.lock` (contenu : libellé du vendeur suivi de `O`) ;
2. écrit `/Soc<XX>/caisse/Ncai = "<caisse>;<code vendeur sur 2 car.>"` et sauvegarde ;
3. fixe `Start.$tcai` (caisse ou `0` selon `/caisse/choixtouches`) ;
4. `UPdate Fiches_Caisses SET dteov, connecte = 1, vdr_code` ;
5. affiche un message de bienvenue et ferme l'écran.

C'est la moitié « ouverture » du cycle de caisse (la fermeture est dans
[`Cmenu.form_close`](../Cmenu.class/architecture.md), le ticket Z dans
[`Moulinage`](../Moulinage.class/architecture.md)) : **module complexe** au sens de PLAN.md §0.

La classe expose aussi `Rvdr(caisse)` (nom du vendeur connecté), appelée par `Fondcaisse` sur
l'auto-instance, et deux fonctions mortes (`Rcai`, `Org`).

Nature globale : **GUI**, avec SQL, fichier verrou et paramètres dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$mdp` | var | Private |  | String | 3 |
| `b` | var | Private |  | Integer | 4 |
| `sNcai` | var | Private |  | String | 5 |
| `sNcaisse` | var | Private |  | String | 6 |
| `hfile` | var | Private |  | File | 7 |
| `sFiletxt` | var | Private |  | String | 8 |
| `$clav` | var | Public |  | String | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 11-42 | Public | 13 | 29 | 0 | méthode spéciale |
| `SetObservers` | 44-56 | Public | 4 | 10 | 0 | portée réductible ? |
| `Obs_Enter` | 58-64 | Public | 1 | 4 | 0 | handler GUI |
| `Obs_Leave` | 66-72 | Public | 1 | 4 | 0 | handler GUI |
| `Mdp_KeyPress` | 74-85 | Public | 7 | 10 | 0 | handler GUI |
| `Mdp_Vendeurs` | 87-102 | Public | 3 | 13 | 0 | portée réductible ? |
| `Combobox1_Click` | 104-123 | Public | 6 | 17 | 0 | handler GUI |
| `Caissiere_Click` | 125-147 | Public | 6 | 19 | 0 | handler GUI |
| `Button2_Click` | 149-153 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 155-227 | Public | 19 | 71 | 1 | handler GUI |
| `Rcai` | 229-234 | Public | 1 | 4 | 0 | portée réductible ? |
| `Rvdr` | 236-248 | Public | 2 | 9 | 1 |  |
| `Org` | 250-255 | Public | 1 | 4 | 0 | portée réductible ? |
| `button1_KeyPress` | 257-261 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 263-270 | Public | 1 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et listes

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] (CC 13) :
  `Utils.Observers(Me)`, `Music.Load(Start.Musique)`, `SetObservers`. Remplit `Caissiere` par
  `SELECT * FROM <TabVendeurs>` (entrée vide `""` en tête, puis « code nom ») et `Combobox1` par
  `SELECT * FROM <TabCaisses> WHERE poste = &1` (`System.Host`, entrée `"  "` — deux espaces — en
  tête, puis « code intitulé »). Idiome `Do … Loop Until MoveNext()` (équivalent à `Repeat`).
  `Catch` : son + `Message.Error(Error.Text & Error.Where)`.
- **`SetObservers` / `Obs_Enter` / `Obs_Leave`** [portée : réductible / nécessaire (handlers
  d'`Observer`)] [nature : GUI] : survol des boutons, copie identique de
  [`Cmenu`](../Cmenu.class/architecture.md).

### Sélections

- **`Combobox1_Click()`** [handler] [nature : mixte] :
  `SELECT * FROM <TabCaisses> WHERE code = &1` avec **`Left$(Combobox1.Text, 1)`** ; affiche le
  fond de caisse (`fndc`, `"0,00"` si nul) et la date de dernière fermeture
  (`LDate(dtefm).LT`). Pas de test `Available` : la ligne vide `"  "` (non nulle pour `IsNull`,
  vérifié avec `gbs3`) cherche le code `" "` et le `Catch` affiche une erreur technique
  (OUVERTURE-A03).
- **`Caissiere_Click()`** [handler] [nature : mixte] :
  `SELECT * FROM <TabVendeurs> WHERE code = &1` avec **`Left$(Caissiere.Text, 2)`**, déchiffre le
  mot de passe dans `$mdp` (`hexdblKey.crypt("de", …)`), puis
  `TestCaisses.TestCai(Left$(Combobox1.Text, 1), Left$(Caissiere.Text, 1))` : le vendeur est-il
  déjà connecté sur une autre caisse (fichiers `~/Caisse1..10.lock`) ? Focus selon le résultat.
  Pas de test `Available`. Pour un code vendeur d'un caractère, `Left$(…, 2)` donne `"1 "`
  (espace final) : trouvé sous MySQL (comparaison `PAD SPACE`), probablement pas sous SQLite
  (à confirmer, OUVERTURE-A02).

### Mot de passe

- **`Mdp_KeyPress()`** [handler] [nature : GUI] : `Entrée`/`Retour`/`Tab` → `Mdp_Vendeurs()` ;
  si correct, focus sur `Button1`.
- **`Mdp_Vendeurs()`** [portée : réductible] [nature : mixte] : compare `Mdp.Text` au mot de passe
  déchiffré `$mdp` ; erreur → son, message, focus, `b = 1` ; sinon `b = 0`. Le résultat passe par
  le membre `b` (drapeau partagé avec `Caissiere_Click` et `Button1_Click`). Copie quasi identique
  de [`ConVendeurs.Mdp_Vendeurs`](../../Gestion/Facturation/ConVendeurs.class/architecture.md).

### Connexion

- **`Button1_Click()`** (« Connecter ») [handler, appelé aussi par `Clavier.Fermer_Click`]
  [nature : mixte] (CC 19, max du fichier).
  - `Try Clavier.Close()` sur l'**auto-instance** de `Clavier` (lignes 157 et 198) : le clavier
    affiché par `Button3_Click` est une instance `New Clavier` distincte ; il reste ouvert et
    l'appel crée une instance cachée (OUVERTURE-A07).
  - `sNcai = Left$(Combobox1.Text, 1)` : **code caisse sur un caractère** alors que
    `Fiches_Caisses.code` est `char(2)` (OUVERTURE-A01).
  - Contrôles successifs : caisse vide (`"  "`), vendeur vide (test `= "  "` alors que l'entrée
    vide de `Caissiere` vaut `""` : jamais vrai, OUVERTURE-A05), mot de passe vide, mot de passe
    erroné (`Mdp_Vendeurs`) — en mode `/caisse/tactile`, le clavier virtuel est rouvert.
  - Verrou `~/Caisse<n>.lock` existant → message « déjà connectée », `Start.$tcai` mis à jour,
    l'écran reste ouvert.
  - `TestCaisses.TestCai(sNcai, Left$(Caissiere.Text, 1))` : vendeur déjà utilisé ailleurs →
    focus sur le vendeur.
  - Sinon : écriture du verrou (`Print #hFile, caissiere.Text & "O"`), `Ncai = sNcai & ";" &
    Left$(Caissiere.Text, 2)`, `Start.LocalSettings.Save`, `Start.$tcai`,
    `UPdate <TabCaisses> SET dteov = &1, connecte = &2, vdr_code = &3 WHERE code = &4`
    (`LDate(Now).DT`, `1`, `Left$(…, 2)`, `sNcai`), message
    « Bonjour <Mid$(Caissiere.Text, 2)> » (le nom commence par l'espace ou le second caractère du
    code), `Me.Close`.
  - Le contrôle de connexion repose uniquement sur le fichier verrou du **compte utilisateur**
    (`User.Home`) ; la colonne `Fiches_Caisses.connecte` n'est pas consultée (OUVERTURE-A06, à
    confirmer).
- **`button1_KeyPress()`** [handler] [nature : GUI] : **toute touche** sur le bouton
  « Connecter » (Tab, Échap, flèches…) lance `Button1_Click` (OUVERTURE-A04).
- **`Button2_Click()`** (« Annuler ») [handler] : `Me.Close`.
- **`Button3_Click()`** (« Clavier ») [handler] [nature : GUI] : `New Clavier` puis `Show`.

### Fonctions utilitaires

- **`Rvdr(Caisse) As String`** [portée : nécessaire (appelée par `Fondcaisse`)] [nature : calcul] :
  `SELECT * FROM <TabCaisses> AS c LEFT JOIN <TabVendeurs> AS v ON c.vdr_code = v.code WHERE
  c.code = &1` ; renvoie `v.nom` ou `""`. Aucun accès aux contrôles : appelée sur l'auto-instance
  par [`Fondcaisse._new`](../Fondcaisse.class/architecture.md), elle **construit une instance
  cachée d'`Ouverture`** (exécution de `_new` : deux `SELECT`, `Music.Load`, `Utils.Observers`).
  Déclarée `Sub … As String` (équivalent à `Function`).
- **`Rcai(sCai) As String`** [portée : réductible] — **code mort** (aucun appel) : renvoie
  `Combobox1.Text` en écrasant son paramètre.
- **`Org(sorg) As String`** [portée : réductible] — **code mort** : renvoie `"O"`.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/caisse/{Ncai,choixtouches,tactile}"]`, `Start.LocalSettings.Save`,
  `Start.Societe`, `Start.son`, `Start.Musique`, `Start.$tcai` (écrit).
- `Utils.db`, `Utils.Observers`, `hexdblKey.crypt`, `TestCaisses.TestCai`.
- Fichiers `~/Caisse<n>.lock` (créés ici, lus par `TestCaisses`/`Dcaisses`, supprimés par `Cmenu`).
- Tables : `Fiches_Caisses` (`TabCaisses`, lecture et mise à jour), `Fiches_Vendeurs`
  (`TabVendeurs`).
- Membres : `$mdp`, `b` (drapeau), `sNcai`, `sNcaisse`, `hfile`, `sFiletxt` (ces trois derniers
  pourraient être locaux à `Button1_Click`), `$clav` (`Public`, jamais utilisé).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button1_Click` : sorties anticipées (`Return`) au lieu de six niveaux de `If` imbriqués ;
  mêmes messages, même ordre (CC 19 → ≤ 8 visé).
- `Mdp_Vendeurs` renvoie un `Boolean` au lieu du drapeau membre `b` (même proposition que
  CONVENDEURS-003).
- `hfile`, `sFiletxt`, `sNcaisse` en variables locales.

### Commonalisation avec d'autres fichiers

- **Sélection et authentification du vendeur** : `_new` (liste), `Caissiere_Click` (recherche +
  déchiffrement), `Mdp_KeyPress`/`Mdp_Vendeurs` sont dupliqués dans
  [`ConVendeurs`](../../Gestion/Facturation/ConVendeurs.class/architecture.md) et en partie dans
  [`Svendeur`](../Svendeur.class/architecture.md) et [`Cmenu.Mdp_KeyPress`](../Cmenu.class/architecture.md).
  Helper `LVendeur` (CONVENDEURS-005) : `Liste()`, `MotDePasse(code)`,
  `CodeDepuisLibelle(texte, longueur)` — la longueur de code reste propre à chaque appelant
  (2 ici pour la requête, 1 pour `TestCai`, 1 dans `ConVendeurs`/`Svendeur`) tant que
  OUVERTURE-A02 et CONVENDEURS-A02 ne sont pas tranchées.
- **État de connexion de caisse** : `Rvdr`, l'écriture du verrou, de `Ncai` et l'`UPDATE` de
  `Button1_Click` forment, avec la déconnexion de [`Cmenu.form_close`](../Cmenu.class/architecture.md)
  et [`TestCaisses.TestCai`](../TestCaisses.module/architecture.md) /
  [`Dcaisses.TestCai`](../Dcaisses.module/architecture.md), un module `CaisseEtat`
  (partie fichiers verrou = module `VerrouCaisse` proposé par
  [`TestCaisses`](../TestCaisses.module/architecture.md) : `Chemin`, `Lit`, `Ecrit`, `Supprime`,
  `CaisseDuVendeur`)
  (`Connecte`, `Deconnecte`, `VendeurConnecte`, `VendeurDejaUtilise`).
- **Survol des boutons** : `SurvolBoutons` (voir CMENU-008).

### Réduction de portée

`SetObservers`, `Mdp_Vendeurs` → `Private` ; `$clav` supprimé ; `Rcai`, `Org` supprimés (code
mort). `Rvdr` reste `Public` tant qu'elle n'est pas déplacée (appelant : `Fondcaisse`). `Mdp`
et `Button1_Click` doivent rester publics (utilisés par `Clavier`).

### Séparation traitement / GUI

- `ConnecteCaisse(sCaisse, sVendeurLibelle)` : verrou, `Ncai`, `Start.$tcai`, `UPDATE` ; sans
  contrôle.
- `InfosCaisse(sCode)` (fond, date de fermeture) pour `Combobox1_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les codes caisse et vendeur sont `char(2)` mais le code les tronque à un caractère à plusieurs
  endroits ; un identifiant numérique (`int`) pour les caisses et une clé unique sur
  `Fiches_Vendeurs.code` lèveraient l'ambiguïté.
- La connexion (verrou fichier par compte Unix + `connecte`) gagnerait à être portée par une table
  de sessions de caisse (caisse, vendeur, poste, ouverture, fermeture).
