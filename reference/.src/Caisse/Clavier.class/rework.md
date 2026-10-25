# Clavier — Rework

> Source : `.src/Caisse/Clavier.class` · Message de commit (phase 4) : `reference/.src/Caisse/Clavier.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 59 |
| Lignes de commentaire | 5 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 8 (`Alpha`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 59 | 16 | 8 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CLAVIER-001 — [documentation] En-tête : rôle (clavier virtuel de connexion), convention
  « nom du bouton = touche », groupe `Clav`, liens avec `Ouverture` · appelants : aucun · tests :
  aucun · sources : [Clavier.class:_new](../../../../.src/Caisse/Clavier.class#L5-L11), [Clavier.class:Alpha](../../../../.src/Caisse/Clavier.class#L36-L66)
- [ ] CLAVIER-002 — [code mort] Supprimer `Numerique` (jamais appelée), le `Me.Center` annulé par
  `Me.Move` et le code commenté de `Fermer_Click` · appelants : aucun · tests : T01-T03 · sources : [Clavier.class:Numerique](../../../../.src/Caisse/Clavier.class#L20-L34), [Clavier.class:7](../../../../.src/Caisse/Clavier.class#L7), [Clavier.class:Fermer_Click](../../../../.src/Caisse/Clavier.class#L68-L77)
- [ ] CLAVIER-003 — [complexité] `Alpha` : `Select Case Last.Name` au lieu des 7 `If` imbriqués,
  branches inatteignables conservées à l'identique (CC 8 inchangée, profondeur 7 → 1) · appelants :
  aucun · tests : T01, T02 · sources : [Clavier.class:Alpha](../../../../.src/Caisse/Clavier.class#L36-L66)
- [ ] CLAVIER-004 — [réduction de portée] `Alpha` → `Private` (appelée seulement par
  `Clav_click`, couverte par les replays T01/T02) · appelants : aucun · tests : T01, T02 · sources : [Clavier.class:Alpha](../../../../.src/Caisse/Clavier.class#L36-L66)
- [ ] CLAVIER-005 — [séparation traitement/GUI] Fonction pure `ToucheVirtuelle(sSaisie, sTouche,
  bEntree) As String` ; `Clav_click` ne garde que l'affectation de `Ouverture.Mdp.Text` · appelants :
  aucun · tests : T01, T02, T04 · sources : [Clavier.class:Clav_click](../../../../.src/Caisse/Clavier.class#L13-L18), [Clavier.class:Alpha](../../../../.src/Caisse/Clavier.class#L36-L66)
- [ ] CLAVIER-006 — [commonalisation] Utiliser `ToucheVirtuelle` pour `Caisse.Alpha` et
  `Caisse.Numerique` (paramètre `bEntree = (zone = "Nmc4")`, comportement identique) ; la fonction
  rejoint `Utils` · appelants : `Caisse` · tests : T04 et tests de saisie tactile de `Caisse` · sources : [Clavier.class:Alpha](../../../../.src/Caisse/Clavier.class#L36-L66), [Caisse.class:Alpha](../../../../.src/Caisse/Caisse.class#L8264-L8294), [Caisse.class:Numerique](../../../../.src/Caisse/Caisse.class#L8248-L8262)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CLAVIER-A01 — [anomalie] Touches inactives : `Etoile` hors du groupe `Clav` et sans
  handler (branche `"Etoile"` d'`Alpha` inatteignable) ; `Virgule` et `Poinvirgule` ignorées par
  `Alpha` ; lettres toujours en majuscules · tests : T02 · sources : [Clavier.class:47](../../../../.src/Caisse/Clavier.class#L47), [Clavier.class:Alpha](../../../../.src/Caisse/Clavier.class#L36-L66)
- [ ] CLAVIER-A02 — [anomalie] « Fermer » lance la connexion (`Ouverture.Button1_Click`) comme
  « Entrée » ; en mode tactile, un mot de passe vide rouvre aussitôt un nouveau clavier · tests :
  T03 · sources : [Clavier.class:Fermer_Click](../../../../.src/Caisse/Clavier.class#L68-L77), [Ouverture.class:Button1_Click](../../../../.src/Caisse/Ouverture.class#L155-L227)
- [ ] CLAVIER-A03 — [anomalie] `Clav_click` remplace `Ouverture.Mdp.Text` par la seule saisie
  virtuelle : un début de mot de passe tapé au clavier physique est perdu · tests : T01 · sources : [Clavier.class:16](../../../../.src/Caisse/Clavier.class#L16)
