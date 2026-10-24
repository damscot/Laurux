# Fblocsoc — Rework

> Source : `.src/Communs/Fblocsoc.class` · Message de commit (phase 4) : `reference/.src/Communs/Fblocsoc.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 4 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 18 | 10 | 4 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FBLOCSOC-001 — [documentation] En-tête : rôle, clés `Blocsoc`/`BlocsocMdp`, effets dans `Fmenu`
  et `LauruxConf` · appelants : aucun · tests : aucun · sources : [Fblocsoc.class:Form_Close](../../../../.src/Communs/Fblocsoc.class#L19-L28)
- [ ] FBLOCSOC-002 — [commonalisation] Fonction privée `MdpManquant() As Boolean` et message unique
  pour `Button1_Click` et `Form_Close` ; `Enregistre(bBloque, sMdp)` privé pour l'écriture des
  réglages · appelants : aucun · tests : T01-T03 · sources : [Fblocsoc.class:Button1_Click](../../../../.src/Communs/Fblocsoc.class#L9-L17), [Fblocsoc.class:Form_Close](../../../../.src/Communs/Fblocsoc.class#L19-L28)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FBLOCSOC-A01 — [anomalie, sécurité] `BlocsocMdp` est écrit mais jamais vérifié : le blocage
  masque seulement le menu « Sociétés » et désactive des champs de `LauruxConf`, sans protection par
  mot de passe ; à implémenter (lecture dans `Fmenu`/`LauruxConf`) ou à retirer · tests : T04 ·
  sources : [Fblocsoc.class:25](../../../../.src/Communs/Fblocsoc.class#L25), [Fmenu.class:99](../../../../.src/Communs/Fmenu.class#L99)
- [ ] FBLOCSOC-A02 — [anomalie] `Form_Open` ne recharge pas le mot de passe : rouvrir puis fermer
  l'écran remplace le mot de passe enregistré par une chaîne vide · tests : T03 · sources : [Fblocsoc.class:Form_Open](../../../../.src/Communs/Fblocsoc.class#L3-L7), [Fblocsoc.class:25](../../../../.src/Communs/Fblocsoc.class#L25)
- [ ] FBLOCSOC-A03 — [anomalie] `Form_Close` avertit d'un mot de passe manquant mais enregistre
  quand même le blocage · tests : T02 · sources : [Fblocsoc.class:Form_Close](../../../../.src/Communs/Fblocsoc.class#L19-L28)
