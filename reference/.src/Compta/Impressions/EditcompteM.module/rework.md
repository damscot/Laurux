# EditcompteM — Rework

> Source : `.src/Compta/Impressions/EditcompteM.module` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/EditcompteM.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 316 |
| Lignes de commentaire | 15 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 42 |
| Complexité max (fonction) | 35 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 316 | 42 | 35 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITCOMPTEM-001 — [documentation] En-tête de module : rôle (PDF du grand livre), paramètres
  d'`Imprime`, niveaux `Ccompta` utilisés, logique des sous-comptes, des totaux de type et de la
  centralisation (`Ctrln`) · appelants : aucun · tests : aucun · sources : [EditcompteM.module:Imprime](../../../../../.src/Compta/Impressions/EditcompteM.module#L42-L276)
- [ ] EDITCOMPTEM-002 — [code mort] Supprimer le `Shell "cd ~"`, les variables sans lecture (`p`,
  `Nbpage`, `Lib`, `Libel`, `sldssc`, `DebHP`, `CredHP`, `TotSldHP`, `Tab3` remplacé par `Cbase`), les
  affectations `totdeb = totdeb`, `totcred = totcred`, `totsld + totsldhp` · appelants : aucun · tests :
  T01 à T09 · sources : [EditcompteM.module:68](../../../../../.src/Compta/Impressions/EditcompteM.module#L68), [EditcompteM.module:219](../../../../../.src/Compta/Impressions/EditcompteM.module#L219), [EditcompteM.module:Imprime](../../../../../.src/Compta/Impressions/EditcompteM.module#L42-L276)
- [ ] EDITCOMPTEM-003 — [complexité] Découper `Imprime` (CC 35) en fonctions privées (total de type,
  fermeture des sous-comptes, écritures, centralisation, total de compte) et
  `NouvellePage(premiere)` / `SoldeAffiche(x)` ; rendu identique · appelants : aucun · tests : T01 à
  T10, T12, T13 · sources : [EditcompteM.module:Imprime](../../../../../.src/Compta/Impressions/EditcompteM.module#L42-L276), [EditcompteM.module:bas_page](../../../../../.src/Compta/Impressions/EditcompteM.module#L278-L289)
- [ ] EDITCOMPTEM-004 — [commonalisation] `Cbase.Table("TabComptes")` et `Cbase.Table("TabSoc")` au lieu
  de `Fiches_Comptes`/`Fiches_Societes` en dur (SQL identique) · appelants : aucun · tests : T01 · sources : [EditcompteM.module:76](../../../../../.src/Compta/Impressions/EditcompteM.module#L76), [EditcompteM.module:77](../../../../../.src/Compta/Impressions/EditcompteM.module#L77)
- [ ] EDITCOMPTEM-005 — [commonalisation] `Centralisation`, `finmois`, `Raz`, DDL de `Ctrln` → helper
  commun « centralisation » (EDITCOMPTE-006) ; `finmois` délègue à `LDate.Fin_Mois` · appelants :
  aucun · tests : T06, T11 · sources : [EditcompteM.module:Centralisation](../../../../../.src/Compta/Impressions/EditcompteM.module#L294-L317), [EditcompteM.module:finmois](../../../../../.src/Compta/Impressions/EditcompteM.module#L322-L333), [EditcompteM.module:Raz](../../../../../.src/Compta/Impressions/EditcompteM.module#L338-L351)
- [ ] EDITCOMPTEM-006 — [séparation traitement/GUI] Curseur `Editcompte.Mouse` géré par
  `Editcompte.Button1_Click` ; `Imprime` renvoie `False` quand rien n'est imprimé et l'écran affiche le
  message (même texte) ; signature `Public` modifiée, appelant mis à jour dans le même commit ·
  appelants : `Editcompte.Button1_Click` · tests : T01, T09 · sources : [EditcompteM.module:100](../../../../../.src/Compta/Impressions/EditcompteM.module#L100), [EditcompteM.module:274](../../../../../.src/Compta/Impressions/EditcompteM.module#L274), [Editcompte.class:Button1_Click](../../../../../.src/Compta/Impressions/Editcompte.class#L676-L680)
- [ ] EDITCOMPTEM-007 — [réduction de portée] `bas_page`, `Centralisation`, `Raz` → `Private` ;
  `finmois` après EDITCOMPTEM-005 · appelants : aucun · tests : T01 à T13 · sources : [EditcompteM.module:bas_page](../../../../../.src/Compta/Impressions/EditcompteM.module#L278-L289), [EditcompteM.module:Centralisation](../../../../../.src/Compta/Impressions/EditcompteM.module#L294-L317), [EditcompteM.module:Raz](../../../../../.src/Compta/Impressions/EditcompteM.module#L338-L351)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITCOMPTEM-A01 — [anomalie] Un groupe de sous-comptes encore ouvert en fin de plage n'imprime
  jamais son « Total sous-comptes » (la fermeture n'a lieu qu'au compte suivant) · tests : T07 · sources : [EditcompteM.module:123](../../../../../.src/Compta/Impressions/EditcompteM.module#L123), [EditcompteM.module:241](../../../../../.src/Compta/Impressions/EditcompteM.module#L241)
- [ ] EDITCOMPTEM-A02 — [anomalie] Grand livre général : `typecompte` initialisé à `"B"` → total
  « Bilan » à zéro imprimé en tête si le premier compte est de gestion ; total « Gestion » imprimé en
  fin même sans compte de gestion · tests : T05 · sources : [EditcompteM.module:65](../../../../../.src/Compta/Impressions/EditcompteM.module#L65), [EditcompteM.module:112](../../../../../.src/Compta/Impressions/EditcompteM.module#L112), [EditcompteM.module:245](../../../../../.src/Compta/Impressions/EditcompteM.module#L245)
- [ ] EDITCOMPTEM-A03 — [anomalie] Lignes centralisées : colonne journal = `jour` de la dernière
  écriture lue, au lieu du journal enregistré dans `Ctrln` (l'export d'`Editcompte` utilise
  `cResult!jour`) · tests : T06 · sources : [EditcompteM.module:211](../../../../../.src/Compta/Impressions/EditcompteM.module#L211), [Editcompte.class:811](../../../../../.src/Compta/Impressions/Editcompte.class#L811)
- [ ] EDITCOMPTEM-A04 — [anomalie] Pas de `Catch` : une erreur SQL laisse le curseur en attente et le
  module dans un état partiel ; curseur final `Mouse.Pointing` au lieu de `Mouse.Default` ; titre des
  pages suivantes « Grand livre » sans la nature · tests : T08, T13 · sources : [EditcompteM.module:274](../../../../../.src/Compta/Impressions/EditcompteM.module#L274), [EditcompteM.module:282](../../../../../.src/Compta/Impressions/EditcompteM.module#L282)
- [ ] EDITCOMPTEM-A05 — [anomalie] `Ctrln` recréée à chaque compte mouvementé et laissée en base,
  nom partagé avec 5 autres éditions (collision multi-poste) ; voir EDITCOMPTE-A06 · tests : T06 · sources : [EditcompteM.module:150](../../../../../.src/Compta/Impressions/EditcompteM.module#L150)
