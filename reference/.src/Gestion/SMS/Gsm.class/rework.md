# Gsm — Rework

> Source : `.src/Gestion/SMS/Gsm.class` · Message de commit (phase 4) : `reference/.src/Gestion/SMS/Gsm.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 198 |
| Lignes de commentaire | 18 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 52 |
| Complexité max (fonction) | 14 (`TextLabel1_GotFocus`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 198 | 52 | 14 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GSM-001 — [documentation] En-tête : trois supports d'envoi (gammu, Spot-Hit, Hosteur), clés
  de configuration, dépendances externes, fichier `~/tmp/sms.txt` ; avertissement de sécurité ·
  appelants : aucun · tests : aucun · sources : [Gsm.class:_New](../../../../../.src/Gestion/SMS/Gsm.class#L12-L31), [Gsm.class:Button2_Click](../../../../../.src/Gestion/SMS/Gsm.class#L176-L243)
- [ ] GSM-002 — [code mort] Supprimer le membre `$contrat` (écrit, jamais relu), les membres
  privés `Support`, `Api`, `Expediteur`, `$Txt` masqués par les locales de `Button2_Click` (en
  gardant les locales), le `If Not Error` redondant de `ToggleButton4_Click` · appelants : aucun ·
  tests : T01-T08 · sources : [Gsm.class:5](../../../../../.src/Gestion/SMS/Gsm.class#L5), [Gsm.class:ToggleButton4_Click](../../../../../.src/Gestion/SMS/Gsm.class#L80-L132), [Gsm.class:Button2_Click](../../../../../.src/Gestion/SMS/Gsm.class#L176-L243)
- [ ] GSM-003 — [complexité] `Button2_Click` (CC 14) : un `Select Case Left$(Support, 1)` et une
  fonction privée de lecture du résultat ; commandes et messages identiques · appelants : aucun ·
  tests : T03-T07 · sources : [Gsm.class:Button2_Click](../../../../../.src/Gestion/SMS/Gsm.class#L176-L243)
- [ ] GSM-004 — [séparation traitement/GUI] Fonction pure `CommandeSms(support, tel, texte,
  paramètres) As String` produisant exactement la ligne actuelle, et `LitCredits(reponse)` extrait
  de `TextLabel1_GotFocus` ; testables en gb.test · appelants : aucun · tests : T03-T06 ·
  sources : [Gsm.class:Button2_Click](../../../../../.src/Gestion/SMS/Gsm.class#L176-L243), [Gsm.class:TextLabel1_GotFocus](../../../../../.src/Gestion/SMS/Gsm.class#L39-L75)
- [ ] GSM-005 — [commonalisation] Module SMS commun (`Credits`, `CommandeSms`, `Envoyer`) partagé
  avec `Emailing` (`Label7_GotFocus`, `EnvoiSms`), `Psms` et `Prefs` (contrôle de clé) ; commandes
  identiques · appelants : `Emailing`, `Prefs` · tests : T01, T03-T05, EMAILING-T09 ·
  sources : [Gsm.class:TextLabel1_GotFocus](../../../../../.src/Gestion/SMS/Gsm.class#L39-L75), [Gsm.class:Button2_Click](../../../../../.src/Gestion/SMS/Gsm.class#L176-L243), [Emailing.class:Label7_GotFocus](../../../../../.src/Gestion/Mails/Emailing.class#L121-L157), [Emailing.class:EnvoiSms](../../../../../.src/Gestion/Mails/Emailing.class#L902-L939), [Prefs.class:1328](../../../../../.src/Communs/Prefs.class#L1328)
- [ ] GSM-006 — [commonalisation] Lecture des textes `Fiches_Sms` (liste + texte complet) via le
  helper partagé avec `Sms` (SMS-004) · appelants : aucun · tests : T02, T08 ·
  sources : [Gsm.class:ToggleButton4_Click](../../../../../.src/Gestion/SMS/Gsm.class#L80-L132), [Gsm.class:Colcol_Click](../../../../../.src/Gestion/SMS/Gsm.class#L137-L148)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] GSM-A01 — [anomalie] [sécurité] Injection de commande : texte (via `Quote`, dont le `"`
  ferme la chaîne du `Shell`) et numéro insérés sans échappement dans des commandes `Shell` ;
  `$(…)` ou `` ` `` dans un texte prédéfini ou saisi est exécuté. Correction : `Exec` avec
  tableau d'arguments et encodage d'URL (`curl --data-urlencode`) · tests : T06 ·
  sources : [Gsm.class:203](../../../../../.src/Gestion/SMS/Gsm.class#L203), [Gsm.class:215](../../../../../.src/Gestion/SMS/Gsm.class#L215), [Gsm.class:228](../../../../../.src/Gestion/SMS/Gsm.class#L228)
- [ ] GSM-A02 — [anomalie] [sécurité] Identifiants en clair : clé Spot-Hit et identifiant/mot de
  passe Hosteur en HTTP non chiffré, sur la ligne de commande (`ps`), stockés non chiffrés
  (`/Hmdp`) et imprimés par `Print` (commande Hosteur complète, texte du SMS). Correction : HTTPS,
  suppression des `Print`, chiffrement par `hexdblKey` · tests : T05 ·
  sources : [Gsm.class:199](../../../../../.src/Gestion/SMS/Gsm.class#L199), [Gsm.class:227](../../../../../.src/Gestion/SMS/Gsm.class#L227), [Gsm.class:51](../../../../../.src/Gestion/SMS/Gsm.class#L51)
- [ ] GSM-A03 — [anomalie] Support 3 (Hosteur) : `"encodage = 0"` collé à `origine` sans `&` et
  avec des espaces, résultat non contrôlé (aucun message), support non proposé par `Prefs` :
  à corriger ou à retirer · tests : T05 · sources : [Gsm.class:228](../../../../../.src/Gestion/SMS/Gsm.class#L228), [Gsm.class:230-237](../../../../../.src/Gestion/SMS/Gsm.class#L230-L237)
- [ ] GSM-A04 — [anomalie] Aucun encodage d'URL (support 2 : seuls les espaces deviennent `+`) :
  `&`, `#`, `?`, `%` et les accents tronquent ou altèrent le message ; `\n` littéral remplacé
  mais pas les vrais sauts de ligne de `Quote` (à confirmer) · tests : T04, T06 ·
  sources : [Gsm.class:192-195](../../../../../.src/Gestion/SMS/Gsm.class#L192-L195)
- [ ] GSM-A05 — [anomalie] `TextLabel1_GotFocus` : déclenché par le focus d'un `TextLabel` (probablement
  jamais) ; exige la configuration **mail** pour envoyer un SMS ; contrôle de crédit fait
  uniquement pour Spot-Hit · tests : T01 · sources : [Gsm.class:Form_Show](../../../../../.src/Gestion/SMS/Gsm.class#L33-L37), [Gsm.class:42](../../../../../.src/Gestion/SMS/Gsm.class#L42)
- [ ] GSM-A06 — [anomalie] Condition d'envoi sur `TextLabel1.Text` (libellé statique, toujours
  rempli) au lieu du texte : SMS vide envoyé ; `Colcol_Click` sans test `Available` ; saisie
  d'un code dans `Comcode` sans effet (groupe `Com` sans handler) · tests : T02, T07 ·
  sources : [Gsm.class:200](../../../../../.src/Gestion/SMS/Gsm.class#L200), [Gsm.class:Colcol_Click](../../../../../.src/Gestion/SMS/Gsm.class#L137-L148)
