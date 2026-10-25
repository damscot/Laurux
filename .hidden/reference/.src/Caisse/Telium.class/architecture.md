# Telium — Architecture

> Source : `.src/Caisse/Telium.class`

## Vue d'ensemble

`Telium` est une **ébauche de pilote de TPE** (terminal de paiement Ingenico Telium) par liaison
série, importée avec Laurux-Pos (commit `f442d721`, 2018) et jamais terminée. Elle vise le
« protocole caisse » des TPE (connu sous le nom Concert, à confirmer) : trame ASCII encadrée par
`STX`/`ETX`, clôturée par un LRC, et dialogue par octets de contrôle `ENQ`/`ACK`/`EOT`.

**Classe jamais référencée** (signal `jamais_reference` de `deps.py`, confirmé) : aucun
`New Telium`, nom absent des chaînes, des `.form` et de `.project`. Pas de `.form` : sa
suppression est un rework [code mort] (TELIUM-001). Si l'intégration d'un TPE est un projet
actif, la décision de la garder revient à l'utilisateur ; les défauts ci-dessous devront alors
être corrigés (anomalies A01-A04).

Dépendance externe : composant **`gb.net`** (classe `SerialPort`), déjà déclaré dans `.project`.
Port par défaut `/dev/ttyACM0` (TPE USB en mode CDC-ACM), 9600 bauds, 8N1, sans contrôle de flux.

### Protocole tel que le code l'applique

| Étape | Code | Octets émis / attendus |
|---|---|---|
| Ouverture | `_new` | ouverture du port ; échec → `Raise Error(…)` |
| Initialisation | `demanderInitialisation` | émet `ACK` (06) **+ LF** ; attend `ACK` ; sinon réémet `ACK` + LF et échoue |
| Demande | `demanderPaiement` | émet `STX` + message + LRC (+ LF) ; **pas d'`ETX`** |
| Accusé / fin | `demanderReponse` | attend `ACK`, émet `EOT`, attend `ENQ`, émet `ACK` |
| Réponse du TPE | — | **jamais lue** (`TAILLE_REPONSE_COMPLET` 83 / `REDUIT` 28 inutilisés) |

Message construit (ligne 124) : `identifiantCaisse` (jamais affecté : `""`) & `Str$(montant)`
(ex. `"12.5"`, ni centimes ni longueur fixe) & `"1"` (réponse demandée) & `"1"` (carte,
`Chr$(49)`) & `"0"` (débit) & `"978"` (EUR) & 10 espaces & `A010`/`A011` (mode de réponse) &
`B010`/`B011` (autorisation forcée).

Observé en scratchpad (copie de la classe, `gbx3`, pty `socat`, sans modifier le dépôt) :
- port absent → erreur `'Telium.:Error' is not static` au lieu du message prévu (A01) ;
- avec un faux TPE sur pty : octets reçus `06 0a 06 0a`, `Read` renvoie aussitôt « End of file »
  (lecture non bloquante), `demanderPaiement` renvoie `False` sans jamais émettre la trame (A02).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `identifiantCaisse` | var | Private |  | String | 3 |
| `modeReponse` | var | Private |  | String | 4 |
| `modeAutorisation` | var | Private |  | String | 5 |
| `delaiTimeout` | var | Private |  | Integer | 6 |
| `serialTPE` | var | Private |  | SerialPort | 8 |
| `BYTE_ACK` | const | Private |  |  | 10 |
| `BYTE_EOT` | const | Private |  |  | 11 |
| `BYTE_ENQ` | const | Private |  |  | 12 |
| `BYTE_STX` | const | Private |  |  | 13 |
| `BYTE_ETX` | const | Private |  |  | 14 |
| `PAIEMENT_CARTE` | const | Private |  |  | 16 |
| `PAIEMENT_CHEQUE` | const | Private |  |  | 17 |
| `TAILLE_REPONSE_COMPLET` | const | Private |  |  | 19 |
| `TAILLE_REPONSE_REDUIT` | const | Private |  |  | 20 |
| `ACTIVER_REPONSE` | const | Private |  |  | 22 |
| `TYPE_TRANSACTION` | const | Private |  |  | 23 |
| `MONNAIE_EUR` | const | Private |  |  | 25 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 27-55 | Public | 5 | 23 | 0 | méthode spéciale |
| `envoyerSignal` | 57-67 | Private | 3 | 7 | 0 |  |
| `attendreSignal` | 69-80 | Private | 4 | 9 | 0 |  |
| `calculerLRC` | 82-93 | Private | 2 | 8 | 0 |  |
| `demanderInitialisation` | 95-106 | Private | 3 | 10 | 0 |  |
| `demanderReponse` | 108-120 | Private | 4 | 10 | 0 |  |
| `demanderPaiement` | 122-142 | Public | 5 | 13 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(unNumeroCaisse, unModeReponse = True, forcerAutorisation = False, unCheminAppareil =
  "/dev/ttyACM0", unBaud = 9600, unDelaiAttenteMaximale = 120)`** [portée : nécessaire
  (spéciale)] [nature : calcul/E-S]. Crée `serialTPE` (`New SerialPort As "serialTPE"`, aucun
  gestionnaire d'événement), fixe vitesse/parité/bits, ouvre le port, choisit `modeReponse` et
  `modeAutorisation`. ⚠️ `unNumeroCaisse` et `unDelaiAttenteMaximale` sont **ignorés**
  (`identifiantCaisse` et `delaiTimeout` jamais affectés). ⚠️ `Raise Error(…)` lève l'événement
  inexistant `Error` : erreur « not static » à l'exécution (vérifié). Le port n'est jamais fermé
  (pas de `_free`).
- **`envoyerSignal(unSignal)`** [privé] : `Print #serialTPE, Chr$(unSignal)` — `Print` ajoute un
  saut de ligne (octet `0A` émis en plus, vérifié). Renvoie `False` en cas d'erreur.
- **`attendreSignal(unSignal)`** [privé] : lit un octet (`Read #serialTPE, out, 1`) et renvoie
  `True` s'il est égal ; sinon la fonction se termine sans `Return` (donc `False`). La lecture
  n'attend pas l'arrivée de la donnée (« End of file » immédiat sur pty) ; aucun délai d'attente.
- **`calculerLRC(unMessage As Byte[])`** [privé] : ⚠️ calcule `sumXOR += (Element Xor sumXOR)`
  au lieu d'un OU exclusif cumulé, et reçoit une `String` (`bufDemande`) au lieu d'un `Byte[]`
  (conversion probablement refusée : « Type mismatch », non atteint lors de l'essai).
- **`demanderInitialisation()`** [privé] : voir tableau. Émet `ACK` là où le protocole caisse
  attend en principe `ENQ` (à confirmer avec la documentation Ingenico).
- **`demanderReponse()`** [privé] : séquence `ACK` ← / `EOT` → / `ENQ` ← / `ACK` →.
- **`demanderPaiement(unMontant As Float) As Boolean`** [portée : réductible → code mort]
  [nature : calcul/E-S] : construit la trame, l'émet, enchaîne `demanderReponse` puis **ne fait
  rien** du résultat (bloc `If` vide) : la fonction renvoie toujours `False`.
- `PAIEMENT_CHEQUE`, `BYTE_ETX`, `TAILLE_REPONSE_*`, `delaiTimeout` : déclarés, jamais utilisés.

Signaux `deps.py` : `unused` = `demanderPaiement` ; `unused_transitive` = `calculerLRC`,
`demanderInitialisation`, `demanderReponse`, `envoyerSignal`, `attendreSignal` (appelées
seulement depuis `demanderPaiement`) : confirmés.

## État global utilisé

Aucun (ni `Start`, ni `Utils`, ni base). Ressource système : le périphérique série.

## Propositions d'amélioration

### Réécriture / refactorisation

- Option par défaut : supprimer la classe (TELIUM-001).
- Si elle est conservée : réécriture complète hors rework autonome (anomalies A01-A04), avec un
  état de connexion explicite, une lecture avec délai (`unDelaiAttenteMaximale`), une trame à
  champs de longueur fixe, l'`ETX`, un LRC correct et la lecture de la réponse (83 ou 28 octets).

### Commonalisation avec d'autres fichiers

- Aucune autre classe ne pilote de port série dans le projet.

### Réduction de portée

- Sans objet (suppression ; `demanderPaiement` est la seule API publique).

### Séparation traitement / GUI

- Pas de GUI. En cas de reprise, séparer la construction de trame et le LRC (fonctions pures,
  testables en gb.test) des entrées/sorties série.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base. Une intégration réelle demanderait de stocker le résultat de la
  transaction TPE (numéro d'autorisation) avec le règlement du ticket.
