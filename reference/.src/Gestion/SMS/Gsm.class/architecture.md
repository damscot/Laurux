# Gsm — Architecture

> Source : `.src/Gestion/SMS/Gsm.class`

## Vue d'ensemble

`Gsm` est l'écran d'**envoi d'un SMS unitaire** à un numéro de portable, avec choix optionnel d'un
texte prédéfini de `Fiches_Sms` (gérés par [`Sms`](../Sms.class/architecture.md)). Ouvert par :
- `Fmenu.Menu319_Click` (« SMS › Envoi unique ») : `New Gsm("")` ;
- `FClient.Button19_Click` / `FFournisseur.Button19_Click` : `New Gsm(<portable>)` (points et
  espaces retirés) ;
- `OptFac.sms_Click` : `New Gsm(<tel du client du document>)`.

Le canal d'envoi dépend de `/Soc<XX>/Support` (préférences, `Prefs`) :

| Support | Mécanisme | Paramètres | Contrôle du résultat |
|---|---|---|---|
| `1-` Clé Huawei / Nokia | `gammu sendsms TEXT <tel> -text <msg>` (modem GSM USB/série configuré dans `~/.gammurc`) | aucun | `OK` dans la sortie |
| `2-` Contrat Spot-Hit | `curl "http://www.spot-hit.fr/api/envoyer/sms?key=…&type=…&destinataires=…&message=…&expediteur=…"` | `/Api`, `/Type`, `/Expediteur` | `{"resultat":1` dans la sortie |
| `3` Hosteur (non proposé par `Prefs`) | `curl "http://sms.hosteur.com/api.php?login=…&pass=…&msg=…&dest=33<tel>&origine=…"` | `/Hidentifiant`, `/Hmdp` (lignes commentées dans `Prefs`) | aucun |

La sortie de la commande est redirigée dans `~/tmp/sms.txt`, puis relue. Nature : **mixte**.

### Dépendances externes

| Dépendance | Usage | Remarque |
|---|---|---|
| `gammu` + modem GSM (port série / USB) | support 1 | non testable sans matériel |
| `curl` + API HTTP Spot-Hit | crédits (`TextLabel1_GotFocus`), envoi (support 2) | **HTTP** non chiffré, clé dans l'URL |
| `curl` + API HTTP Hosteur | envoi (support 3) | identifiant et **mot de passe en clair** dans l'URL, affichés par `Print` |
| `~/tmp/sms.txt` | toutes | fichier partagé avec `Emailing`, `Psms`, `Prefs` |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 3 |
| `Support` | var | Private |  | String | 4 |
| `$contrat` | var | Private |  | String | 5 |
| `Api` | var | Private |  | String | 6 |
| `Expediteur` | var | Private |  | String | 7 |
| `premium` | var | Private |  | String | 8 |
| `lowcost` | var | Private |  | String | 9 |
| `$Txt` | var | Private |  | String | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 12-31 | Public | 3 | 18 | 0 | méthode spéciale |
| `Form_Show` | 33-37 | Public | 1 | 3 | 0 | handler GUI |
| `TextLabel1_GotFocus` | 39-75 | Public | 14 | 35 | 0 | handler GUI |
| `ToggleButton4_Click` | 80-132 | Public | 12 | 46 | 0 | handler GUI |
| `Colcol_Click` | 137-148 | Public | 1 | 9 | 0 | handler GUI |
| `Colcol_KeyPress` | 153-168 | Public | 5 | 13 | 0 | handler GUI |
| `Button3_Click` | 170-174 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 176-243 | Public | 14 | 60 | 0 | handler GUI |
| `Button1_Click` | 248-252 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Tel)`** [portée : nécessaire] [GUI] : centre, `Utils.Observers(Me)`, colonnes de `Colcol`,
  focus sur `TextBox1` (pas de numéro) ou `Comcode`, `TextBox1 = Tel`, suppression de
  `~/tmp/sms.txt`. Signature utilisée par 4 appelants.
- **`Form_Show`** [GUI] : `TextLabel1.SetFocus`, pour déclencher `TextLabel1_GotFocus`.
- **`TextLabel1_GotFocus`** [GUI, mixte] (CC 14) : vérifie la configuration **mail** (`/Smtp`,
  `Port`, `/Adrmail`), sans rapport avec les SMS : si elle manque, message et fermeture. Lit
  `/Support` ; pour Spot-Hit (`2`), lit `/Api`, `/Type` (`$contrat`, jamais relu), `/Expediteur`,
  interroge les crédits par `curl`, découpe la réponse JSON à la main (`Mid$`/`InStr`) et affiche
  le solde premium/lowcost ou « clé API mauvaise » (fermeture). ⚠️ `TextLabel1` est un
  `TextLabel` (libellé « Numéro portable ») : il ne prend probablement pas le focus, le contrôle
  ne s'exécuterait jamais (à confirmer en replay, GSM-A05). Code identique dans
  `Emailing.Label7_GotFocus`.
- **`ToggleButton4_Click`** [GUI, mixte] (CC 12) : remplit `Colcol` avec `SELECT * FROM Fiches_Sms
  order by numcom` (code + première ligne du texte) ; table vide → avertissement ; `Catch` →
  « La table des textes SMS n'existe pas... ». Double `If Not Error` imbriqué redondant.
- **`Colcol_Click`** [GUI, rejeu dynamique] : relit le texte choisi (sans test `Available`),
  remplit `Comcode` et `Intitule`, masque la grille.
- **`Colcol_KeyPress`** [GUI] : Entrée = clic ; Échap/F2 ferme la grille.
- **`Button3_Click`** [GUI] : fermeture. **`Button1_Click`** [GUI] : aide `Doc.Open("Sms")`.
- **`Button2_Click`** [GUI, mixte] (CC 14) : envoi.
  1. `Tel` = `TextBox1` sans espaces (aucune autre validation) ; relit tous les paramètres dans
     des variables **locales** qui masquent les membres privés homonymes (`Support`, `Api`,
     `Expediteur`, `$Txt`).
  2. Texte : supports 1 et 2 → `Quote(Intitule.Text)` (texte entouré de `"` avec échappements
     Gambas), `\n` littéral remplacé par un espace ; support 1 ajoute `.` ; support 2 remplace
     les espaces par `+` (seul « encodage » d'URL) ; support 3 → texte brut.
  3. `Print mesg` : le contenu du SMS est écrit sur la sortie standard.
  4. Condition d'envoi : `TextBox1` non vide **et** `TextLabel1.Text` non vide, toujours vrai
     (libellé statique) : un SMS vide peut partir.
  5. `Shell … Wait` selon le support (voir tableau), puis lecture de `~/tmp/sms.txt` et message
     « envoyé » / « Problème ! ». Support 3 : la commande est d'abord affichée par `Print`
     (**identifiant et mot de passe inclus**), le paramètre `"encodage = 0"` est collé à
     `origine` sans `&` et avec des espaces, et le résultat n'est pas contrôlé (bloc commenté) :
     aucun retour à l'utilisateur.
  ⚠️ Le texte et le numéro sont insérés dans une ligne interprétée par `/bin/sh` : avec `Quote`,
  le `"` initial **ferme** la chaîne de la commande, si bien que `$(…)` ou `` ` `` du texte est
  exécuté (vérifié : `Quote` ne neutralise pas `$(id)`). Voir GSM-A01.

## État global utilisé

- `Start.LocalSettings` : `/Smtp`, `Port`, `/Adrmail`, `/Soc<XX>/Support`, `/Api`, `/Type`,
  `/Expediteur`, `/Hidentifiant`, `/Hmdp`.
- `Start.Son`, `Start.Societe`, `Utils.db`, `Utils.Observers`, `Cbase.Table("TabSms")`,
  `User.Home`.

## Sécurité (relevé)

- **Injection de commande** par le texte du SMS (saisi ou issu de `Fiches_Sms`) et par le numéro
  (saisi ou issu des fiches client/fournisseur) : GSM-A01.
- **Identifiants en clair** : clé Spot-Hit et identifiant/mot de passe Hosteur dans l'URL HTTP
  (non chiffrée), sur la ligne de commande (visible par `ps`), dans `Laurux.conf` sans
  chiffrement (`/Hmdp`, contrairement à `/MdpStmp`), et sur la sortie standard (`Print`) :
  GSM-A02.
- **Données personnelles** : numéro et contenu du SMS imprimés sur la sortie standard et laissés
  dans `~/tmp/sms.txt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` : `Select Case Left$(Support, 1)` unique au lieu de trois séries de `If` ;
  fonction privée de lecture du résultat (`~/tmp/sms.txt` + motif attendu).
- Supprimer les membres privés masqués par les locales et non relus (`$contrat`), le double
  `If Not Error`.

### Commonalisation avec d'autres fichiers

- **Module SMS commun** (nouveau module, par ex. `EnvSms`, sur le modèle d'[`EnvMail`](../../Mails/EnvMail.module/architecture.md)) :
  `Credits(api)` (aujourd'hui dans `Gsm.TextLabel1_GotFocus`,
  [`Emailing.Label7_GotFocus`](../../Mails/Emailing.class/architecture.md),
  [`Psms.api_LostFocus`](../Psms.class/architecture.md) et
  [`Prefs`](../../../Communs/Prefs.class/architecture.md) l. 1328), `CommandeSms(support, tel,
  texte)` et `Envoyer(…)` (aujourd'hui dans `Gsm.Button2_Click` et `Emailing.EnvoiSms`, mort).
- Lecture des textes `Fiches_Sms` : helper commun avec [`Sms`](../Sms.class/architecture.md)
  (SMS-004).

### Réduction de portée

- Sans objet : toutes les fonctions sont des handlers ou `_New` ; `Colcol_Click` doit rester
  `Public` (rejeu).

### Séparation traitement / GUI

- `CommandeSms(support, tel, texte, paramètres) As String` : fonction pure qui produit
  **exactement** la ligne de commande actuelle (testable en gb.test) ; `Button2_Click` garde
  lecture des contrôles, `Shell` et messages.
- `LitCredits(reponse) As String[]` : découpage de la réponse Spot-Hit.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Historiser les SMS envoyés (table de journal : date, destinataire, texte, résultat), absente
  aujourd'hui.
- Stocker les identifiants des fournisseurs SMS chiffrés (comme `/MdpStmp`) plutôt qu'en clair.
