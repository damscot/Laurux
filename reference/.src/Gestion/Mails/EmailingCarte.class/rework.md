# EmailingCarte — Rework

> Source : `.src/Gestion/Mails/EmailingCarte.class` · Message de commit (phase 4) : `reference/.src/Gestion/Mails/EmailingCarte.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 474 |
| Lignes de commentaire | 52 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 136 |
| Complexité max (fonction) | 25 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 474 | 136 | 25 | 0 | 31 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EMAILINGCARTE-001 — [documentation] En-tête : sélection par plage de codes ou de codes
  postaux, mode liste (`Cli_Mailing` partagée avec Emailing), contrat de pièce jointe, statut de
  `bstatut_Click` (inactif, auto-instance `Statut`) · appelants : aucun · tests : aucun ·
  sources : [EmailingCarte.class:_New](../../../../../.src/Gestion/Mails/EmailingCarte.class#L42-L69), [EmailingCarte.class:bstatut_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L647-L655)
- [ ] EMAILINGCARTE-002 — [code mort] Supprimer `CoulZnaf`, les blocs `With Utils` inutiles, les
  branches `Case 4`, `Case 8` et `Case 7/8` (`ChkInput`) d'`Etiq_KeyPress` (aucun contrôle de
  tag 4, 7 ou 8) · appelants : aucun · tests : T01-T05 · sources : [EmailingCarte.class:34](../../../../../.src/Gestion/Mails/EmailingCarte.class#L34), [EmailingCarte.class:Etiq_KeyPress](../../../../../.src/Gestion/Mails/EmailingCarte.class#L435-L505)
- [ ] EMAILINGCARTE-003 — [complexité] `Button2_Click` (CC 25) : sélection par critères (SQL
  identique) et boucle d'envoi commune aux modes plage/CP/liste ; fusion `Tris`/`Tris2` et
  `AffClients`/`AffClients2` (comportement de `colinit` conservé) · appelants : aucun ·
  tests : T01-T05 · sources : [EmailingCarte.class:Button2_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L507-L585), [EmailingCarte.class:Tris2](../../../../../.src/Gestion/Mails/EmailingCarte.class#L109-L119), [EmailingCarte.class:AffClients2](../../../../../.src/Gestion/Mails/EmailingCarte.class#L202-L209)
- [ ] EMAILINGCARTE-004 — [commonalisation] Sélection de destinataires partagée avec `Emailing`
  et `Eticli` (voir EMAILING-006), `SetObservers`/`OBS_*` vers le helper commun · appelants :
  aucun · tests : T01-T05, EMAILING-T01-T07 · sources : [EmailingCarte.class:Cli_Man](../../../../../.src/Gestion/Mails/EmailingCarte.class#L252-L279), [EmailingCarte.class:liste_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L390-L423), [EmailingCarte.class:SetObservers](../../../../../.src/Gestion/Mails/EmailingCarte.class#L627-L639), [Emailing.class:Cli_Man](../../../../../.src/Gestion/Mails/Emailing.class#L349-L377)
- [ ] EMAILINGCARTE-005 — [séparation traitement/GUI] `SelectionCartes(critères) As Result`,
  `AjouteListe(code)`, `CreeListe()`/`SupprimeListe()` sans contrôles · appelants : aucun ·
  tests : T01-T03 · sources : [EmailingCarte.class:Button2_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L507-L585), [EmailingCarte.class:Cli_Man](../../../../../.src/Gestion/Mails/EmailingCarte.class#L252-L279), [EmailingCarte.class:liste_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L390-L423)
- [ ] EMAILINGCARTE-006 — [réduction de portée] `Tris`, `Tris2`, `colinit`, `AffClients`,
  `AffClients2`, `Cli_Man`, `ChkInput`, `Button2_Click`, `SetObservers` → `Private` ; handlers
  (dont `ColCli_Click`/`ColCli2_Click`, rejeu) inchangés · appelants : aucun · tests : T01-T07 ·
  sources : [EmailingCarte.class:Tris](../../../../../.src/Gestion/Mails/EmailingCarte.class#L97-L107), [EmailingCarte.class:Tris2](../../../../../.src/Gestion/Mails/EmailingCarte.class#L109-L119), [EmailingCarte.class:colinit](../../../../../.src/Gestion/Mails/EmailingCarte.class#L167-L185), [EmailingCarte.class:AffClients](../../../../../.src/Gestion/Mails/EmailingCarte.class#L190-L197), [EmailingCarte.class:AffClients2](../../../../../.src/Gestion/Mails/EmailingCarte.class#L202-L209), [EmailingCarte.class:Cli_Man](../../../../../.src/Gestion/Mails/EmailingCarte.class#L252-L279), [EmailingCarte.class:ChkInput](../../../../../.src/Gestion/Mails/EmailingCarte.class#L425-L433), [EmailingCarte.class:Button2_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L507-L585), [EmailingCarte.class:SetObservers](../../../../../.src/Gestion/Mails/EmailingCarte.class#L627-L639)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EMAILINGCARTE-A01 — [anomalie] Mode liste : `rcli2` lu sans test `Available` (liste vide →
  erreur), fiche relue par `Try` puis lue sans test ; `Panel4` laissé visible à la fin ·
  tests : T03 · sources : [EmailingCarte.class:522-537](../../../../../.src/Gestion/Mails/EmailingCarte.class#L522-L537)
- [ ] EMAILINGCARTE-A02 — [anomalie] Pièce jointe : chemin complet passé comme répertoire à
  `EnvMail.Envoi` (`chemin & FileN` introuvable), envoi interrompu au premier porteur ; `piece`
  jamais remis à `False` · tests : T04 · sources : [EmailingCarte.class:534](../../../../../.src/Gestion/Mails/EmailingCarte.class#L534), [EmailingCarte.class:546](../../../../../.src/Gestion/Mails/EmailingCarte.class#L546), [EmailingCarte.class:btnopen_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L587-L603), [EnvMail.module:30](../../../../../.src/Gestion/Mails/EnvMail.module#L30)
- [ ] EMAILINGCARTE-A03 — [anomalie] `Btn_KeyPress` : toute touche sur le bouton Envoyer lance
  l'envoi, Espace probablement deux fois (à confirmer) · tests : T07 · sources : [EmailingCarte.class:Btn_KeyPress](../../../../../.src/Gestion/Mails/EmailingCarte.class#L381-L388)
- [ ] EMAILINGCARTE-A04 — [anomalie] Table de travail `Cli_Mailing` hors `Cbase`, partagée avec
  `Emailing` et entre postes ; laissée en base si l'écran est fermé en mode liste (voir
  EMAILING-A08) · tests : T03 · sources : [EmailingCarte.class:liste_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L390-L423)
- [ ] EMAILINGCARTE-A05 — [anomalie] Tri de `Colcli2` : `colinit` appelle `AffClients`
  (reconfigure `colcli`, focus sur la grille masquée) · tests : T05 · sources : [EmailingCarte.class:colinit](../../../../../.src/Gestion/Mails/EmailingCarte.class#L167-L185)
- [ ] EMAILINGCARTE-A06 — [anomalie] `bstatut_Click` n'est rattaché à aucun contrôle (pas de
  `bstatut` dans le `.form`) et bascule l'auto-instance du formulaire `Statut` : vestige à
  supprimer, ou bouton à ajouter si l'ouverture de la table des statuts depuis l'emailing est
  voulue (décision utilisateur ; impacte STATUT-T04) · tests : STATUT-T04 · sources : [EmailingCarte.class:649-652](../../../../../.src/Gestion/Mails/EmailingCarte.class#L649-L652), [Statut.class:20](../../../../../.src/Gestion/Tables/Statut.class#L20)
