# Telium — Rework

> Source : `.src/Caisse/Telium.class` · Message de commit (phase 4) : `reference/.src/Caisse/Telium.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 5 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 97 | 26 | 5 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TELIUM-001 — [code mort] Supprimer `Telium.class` (classe jamais référencée, sans
  `.form` ; `demanderPaiement` et ses 5 fonctions privées jamais appelées) et
  `reference/.src/Caisse/Telium.class/`. À confirmer avec l'utilisateur si un pilote de TPE est
  prévu (sinon les anomalies A01-A04 deviennent sans objet) · appelants : aucun · tests :
  `gbc3 -agt`, `./Laurux -T all` · sources : [Telium.class:_new](../../../../.src/Caisse/Telium.class#L27-L55), [Telium.class:demanderPaiement](../../../../.src/Caisse/Telium.class#L122-L142)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Elles ne
concernent que le cas où la classe est conservée.

- [ ] TELIUM-A01 — [anomalie] `Raise Error(…)` lève un événement inexistant : l'échec d'ouverture
  du port produit `'Telium.:Error' is not static` (vérifié) au lieu du message prévu ; port jamais
  fermé · tests : T01 · sources : [Telium.class:40](../../../../.src/Caisse/Telium.class#L40)
- [ ] TELIUM-A02 — [anomalie] Lecture série non bloquante et sans délai : `attendreSignal` reçoit
  « End of file » immédiatement, l'initialisation échoue toujours (vérifié sur pty) ;
  `unDelaiAttenteMaximale` ignoré · tests : T02 · sources : [Telium.class:attendreSignal](../../../../.src/Caisse/Telium.class#L69-L80), [Telium.class:27](../../../../.src/Caisse/Telium.class#L27)
- [ ] TELIUM-A03 — [anomalie] `Print #` ajoute un saut de ligne après chaque octet de contrôle et
  après la trame (`06 0a` observé) · tests : T02 · sources : [Telium.class:59](../../../../.src/Caisse/Telium.class#L59), [Telium.class:130](../../../../.src/Caisse/Telium.class#L130)
- [ ] TELIUM-A04 — [anomalie] Trame et dialogue non conformes : numéro de caisse jamais affecté,
  montant `Str$` sans format fixe en centimes, `ETX` absent, LRC faux (`+=` au lieu de `Xor`,
  `String` passée pour `Byte[]`), `ACK` émis au lieu d'`ENQ` (à confirmer), réponse du TPE jamais
  lue, `demanderPaiement` renvoie toujours `False` · tests : T02, T03 · sources : [Telium.class:124](../../../../.src/Caisse/Telium.class#L124), [Telium.class:calculerLRC](../../../../.src/Caisse/Telium.class#L82-L93), [Telium.class:demanderInitialisation](../../../../.src/Caisse/Telium.class#L95-L106), [Telium.class:demanderPaiement](../../../../.src/Caisse/Telium.class#L122-L142)
