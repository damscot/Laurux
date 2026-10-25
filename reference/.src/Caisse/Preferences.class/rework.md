# Preferences — Rework

> Source : `.src/Caisse/Preferences.class` · Message de commit (phase 4) : `reference/.src/Caisse/Preferences.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 183 |
| Lignes de commentaire | 3 |
| Fonctions | 15 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 65 |
| Complexité max (fonction) | 41 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 183 | 65 | 41 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PREFERENCES-001 — [documentation] En-tête en français : tableau des clés
  `/Soc<XX>/caisse/…`, de leurs contrôles et de leurs lecteurs ; enregistrement systématique à la
  fermeture · appelants : aucun · tests : T01-T03 · sources : [Preferences.class:_new](../../../../.src/Caisse/Preferences.class#L11-L74), [Preferences.class:Form_Close](../../../../.src/Caisse/Preferences.class#L164-L201)
- [ ] PREFERENCES-002 — [code mort] Supprimer les membres `Fontes` (jamais affecté, branche morte
  de `_new`), `chkNbase`, `Lig`, `cs`, `cv`, la première lecture de `TypeB` (ligne 38, écrasée
  ligne 41) et le paramètre inutilisé de `FileFilter` · appelants : aucun · tests : T01, T02 ·
  sources : [Preferences.class:3](../../../../.src/Caisse/Preferences.class#L3), [Preferences.class:38](../../../../.src/Caisse/Preferences.class#L38), [Preferences.class:55](../../../../.src/Caisse/Preferences.class#L55), [Preferences.class:FileFilter](../../../../.src/Caisse/Preferences.class#L135-L145)
- [ ] PREFERENCES-003 — [complexité] Table des préférences (clé, contrôle, propriété) parcourue
  par `_new` et `Form_Close`, ordre d'écriture conservé (CC 41 → ≤ 5 visé) · appelants : aucun ·
  tests : T01-T03, T06 · sources : [Preferences.class:_new](../../../../.src/Caisse/Preferences.class#L11-L74), [Preferences.class:Form_Close](../../../../.src/Caisse/Preferences.class#L164-L201)
- [ ] PREFERENCES-004 — [séparation traitement/GUI] `ChargePreferences() As Collection`,
  `EnregistrePreferences(cPrefs)` et `ListeImprimantes() As String[]` sans accès aux contrôles ·
  appelants : aucun · tests : T01, T06 · sources : [Preferences.class:_new](../../../../.src/Caisse/Preferences.class#L11-L74), [Preferences.class:Form_Close](../../../../.src/Caisse/Preferences.class#L164-L201)
- [ ] PREFERENCES-005 — [commonalisation] Liste des imprimantes `lpc status` partagée avec
  `Facturergbl` (helper `Impression.ListeImprimantes()`) ; `FileFilter` → helper commun avec les 8
  autres copies · appelants : aucun · tests : T03, tests de FACTURERGBL · sources : [Preferences.class:64](../../../../.src/Caisse/Preferences.class#L64), [Facturergbl.class:112](../../../../.src/Gestion/Facturation/Facturergbl.class#L112), [Preferences.class:FileFilter](../../../../.src/Caisse/Preferences.class#L135-L145)
- [ ] PREFERENCES-006 — [commonalisation] Survol des boutons via `SurvolBoutons` (CMENU-008) ·
  appelants : aucun · tests : T01 · sources : [Preferences.class:SetObservers](../../../../.src/Caisse/Preferences.class#L76-L88), [Preferences.class:Obs_Enter](../../../../.src/Caisse/Preferences.class#L90-L96), [Preferences.class:Obs_Leave](../../../../.src/Caisse/Preferences.class#L98-L104)
- [ ] PREFERENCES-007 — [réduction de portée] `SetObservers`, `aff_logo` → `Private` (aucun
  appelant externe, vérifié par `grep`) · appelants : aucun · tests : T01 · sources : [Preferences.class:SetObservers](../../../../.src/Caisse/Preferences.class#L76-L88), [Preferences.class:aff_logo](../../../../.src/Caisse/Preferences.class#L147-L156)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PREFERENCES-A01 — [anomalie] (IMPRESSION-A01/A02) `FACpdf`, `CmdImp`, `Cimp`, `choiximp2`
  sont enregistrées sous `/Soc<XX>/caisse/` alors qu'`Impression.Facture` lit `/FACpdf`,
  `/CmdImp`, `/Cimp`, `/choiximp2` globales (jamais écrites) : les préférences d'impression des
  factures saisies en caisse sont ignorées et `caisse/FACpdf` n'a aucun lecteur. Correction dans le
  même commit qu'IMPRESSION-A01 · appelants : `Impression`, `Caisse` · tests : T05 · sources : [Preferences.class:194](../../../../.src/Caisse/Preferences.class#L194), [Preferences.class:195](../../../../.src/Caisse/Preferences.class#L195), [Preferences.class:198](../../../../.src/Caisse/Preferences.class#L198), [Impression.module:33](../../../../.src/Utils/Impression.module#L33)
- [ ] PREFERENCES-A02 — [anomalie] Clés écrites sans effet : `caisse/son` (le son est lu dans
  `/son` par `Start`), `caisse/tircarte` (aucun lecteur) ; `caisse/intitule` réécrite sans
  contrôle de saisie : à supprimer de l'écran ou à brancher · tests : T03 · sources : [Preferences.class:178](../../../../.src/Caisse/Preferences.class#L178), [Preferences.class:189](../../../../.src/Caisse/Preferences.class#L189), [Preferences.class:177](../../../../.src/Caisse/Preferences.class#L177)
- [ ] PREFERENCES-A03 — [anomalie] `BchmZ_Click` : l'annulation du dialogue remplace le
  répertoire des tickets Z par `User.Home` au lieu de conserver la valeur · tests : T04 · sources : [Preferences.class:BchmZ_Click](../../../../.src/Caisse/Preferences.class#L209-L219)
