# Zebra — Rework

> Source : `.src/Gestion/Etiquettes/Zebra.module` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Zebra.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 19 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 1 |
| Complexité max (fonction) | 1 (`Gondole1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 19 | 1 | 1 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ZEBRA-001 — [documentation] En-tête en français : protocole (ZPL brut sur TCP 9100),
  dimensions (203 dpi, 384 × 256 points), tableau commande → champ, rappel que l'appel est
  aujourd'hui inatteignable (ZEBRA-A01) · appelants : aucun · tests : ZEBRA-T01 · sources : [Zebra.module:Gondole1](../../../../../.src/Gestion/Etiquettes/Zebra.module#L4-L24)
- [ ] ZEBRA-002 — [séparation traitement/GUI] Extraire la construction du flux dans une fonction
  pure `Gondole1Zpl(…) As String` ; `Gondole1` écrit la chaîne en une fois (flux identique octet
  par octet) · appelants : aucun (signature de `Gondole1` inchangée) · tests : ZEBRA-T01, T02, T03 · sources : [Zebra.module:Gondole1](../../../../../.src/Gestion/Etiquettes/Zebra.module#L4-L24)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ZEBRA-A01 — [anomalie] Sortie Zebra inatteignable : `Connect` n'est appelée dans aucun des
  quatre écrans, `IpZebra` n'y est jamais renseigné (`/Soc<XX>/IpZebra` de `Prefs` jamais lu), donc
  `ConnZbr` reste faux ; choisir « Imprimante Zebra » produit en outre une erreur `Null object`
  (voir les anomalies des écrans). Décision utilisateur : brancher la connexion (lecture de
  `IpZebra`, `Connect` au clic Imprimer) **ou** supprimer `Zebra.module`, les quatre `Connect` et
  les branches `ConnZbr` · tests : ZEBRA-T01, replays « Zebra » des écrans · sources : [Zebra.module:Gondole1](../../../../../.src/Gestion/Etiquettes/Zebra.module#L4-L24), [Etiqart.class:Connect](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L992-L1011), [Etigond.class:Connect](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1031-L1050), [Etiqcasier.class:Connect](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L969-L988), [EtiqPromo.class:Connect](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L328-L347)
- [ ] ZEBRA-A02 — [anomalie] Données non échappées sous `^FH` (`_`, `^`, `~`) et jeu de caractères
  `^CI0` avec des intitulés UTF-8 (accents) ; `>63` après le code-barres (caractère `3`
  vraisemblablement imprimé) ; `^JUS` sauvegarde la configuration à chaque étiquette. À confirmer
  sur matériel · tests : ZEBRA-T02 · sources : [Zebra.module:10](../../../../../.src/Gestion/Etiquettes/Zebra.module#L10), [Zebra.module:6](../../../../../.src/Gestion/Etiquettes/Zebra.module#L6), [Zebra.module:19](../../../../../.src/Gestion/Etiquettes/Zebra.module#L19)
