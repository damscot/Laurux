# ConsultArt — Rework

> Source : `.src/Gestion/Tables/ConsultArt.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/ConsultArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 771 |
| Lignes de commentaire | 42 |
| Fonctions | 49 |
| Fonctions Public | 49 |
| Complexité cyclomatique totale | 200 |
| Complexité max (fonction) | 37 (`Colarts_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 771 | 200 | 37 | 0 | 49 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CONSULTART-001 — [documentation] En-tête en français (le fichier se présente encore comme
  `Articles.class`) : rôle de consultation en lecture seule, colonnes masquées de `Colarts`, rôle des
  en-têtes de recherche, signification de `Tri`, `sel`, `Dbl`, `ComboTest`, `Chkfocus` · appelants :
  aucun · tests : T01 · sources : [ConsultArt.class:_New](../../../../../.src/Gestion/Tables/ConsultArt.class#L50-L93), [ConsultArt.class:Colarts_Data](../../../../../.src/Gestion/Tables/ConsultArt.class#L114-L202)
- [ ] CONSULTART-002 — [code mort] Supprimer `Ref`, `art_man`, `Decimal` (`unused` confirmé par grep)
  et `FamMan` (appelée seulement par `art_man`) ; variables écrites jamais lues `n`, `B`, `Tvavente`,
  `Ecotaxe`, `CoulFc`, `CoulZnaf` ; `Tab2` devient une locale ; double affectation de `Arr` dans
  `CleanChamps` · appelants : aucun · tests : T01-T04 · sources : [ConsultArt.class:Ref](../../../../../.src/Gestion/Tables/ConsultArt.class#L907-L915), [ConsultArt.class:art_man](../../../../../.src/Gestion/Tables/ConsultArt.class#L920-L960), [ConsultArt.class:Decimal](../../../../../.src/Gestion/Tables/ConsultArt.class#L965-L983), [ConsultArt.class:FamMan](../../../../../.src/Gestion/Tables/ConsultArt.class#L342-L375), [ConsultArt.class:27-48](../../../../../.src/Gestion/Tables/ConsultArt.class#L27-L48), [ConsultArt.class:549-550](../../../../../.src/Gestion/Tables/ConsultArt.class#L549-L550)
- [ ] CONSULTART-003 — [commonalisation] Noms de tables par `Cbase.Table` : `Fiches_Art` (`TabArt`),
  `Fiches_Ligcom` (`TabLigcom`), `Fiches_Fam` (`TabFam`), `Fiches_Tvaav` (`TabTvav`), `Fiches_Comptes`
  (`TabComptes`), `Fiches_Four` (`TabFour`) dans `Maj_Zones`, `Fam2`, `fourMan` ; SQL émis identique ·
  appelants : aucun · tests : T03 · sources : [ConsultArt.class:Maj_Zones](../../../../../.src/Gestion/Tables/ConsultArt.class#L397-L480), [ConsultArt.class:Fam2](../../../../../.src/Gestion/Tables/ConsultArt.class#L485-L518), [ConsultArt.class:fourMan](../../../../../.src/Gestion/Tables/ConsultArt.class#L380-L395)
- [ ] CONSULTART-004 — [complexité] Fusionner `Deb2`/`Deb3`/`Deb4` en
  `ChargeListe(bDesc, bContient)` appuyée sur une fonction pure
  `RequeteListe(sTri, sSel, iFiltre, bDesc, bContient) As String` qui produit **le même texte SQL à
  l'octet près** pour chaque combinaison (y compris la colonne `art_pvttc` de la variante
  « suspendus » descendante, tant que CONSULTART-A03 n'est pas validée) · appelants : aucun ·
  tests : T02, T05 · sources : [ConsultArt.class:Deb2](../../../../../.src/Gestion/Tables/ConsultArt.class#L220-L259), [ConsultArt.class:Deb3](../../../../../.src/Gestion/Tables/ConsultArt.class#L261-L300), [ConsultArt.class:Deb4](../../../../../.src/Gestion/Tables/ConsultArt.class#L302-L337)
- [ ] CONSULTART-005 — [complexité] `Colarts_Data` (CC 37) : couleurs `/Coul/*` lues une fois à
  l'ouverture et tableau `Arttable` initialisé une fois (aujourd'hui recalculés à chaque cellule) ;
  rendu identique · appelants : aucun · tests : T02, T06 · sources : [ConsultArt.class:Colarts_Data](../../../../../.src/Gestion/Tables/ConsultArt.class#L114-L202)
- [ ] CONSULTART-006 — [complexité] `Rb_Click` : supprimer le second `CleanChamps` + `Deb2` exécuté
  après `Refresh()` (**SQL modifié** : une requête de liste au lieu de deux, dump identique, écran en
  lecture seule) ; le retour du tri sur le code, effet actuel de `Refresh`, est conservé · appelants :
  aucun · tests : T02 · sources : [ConsultArt.class:Rb_Click](../../../../../.src/Gestion/Tables/ConsultArt.class#L608-L645)
- [ ] CONSULTART-007 — [commonalisation] Handlers d'en-tête (`Co_*`, `Inte_*`, `fo_*`, `Fa_*`,
  `Cb1_*`) : helpers privés `ChoixTri(sChamp, hEntete)` et `Frappe(bContient)` appelés par les
  handlers (noms et portée inchangés) · appelants : aucun · tests : T02, T05 · sources : [ConsultArt.class:Co_Click](../../../../../.src/Gestion/Tables/ConsultArt.class#L746-L755), [ConsultArt.class:Co_KeyPress](../../../../../.src/Gestion/Tables/ConsultArt.class#L763-L773), [ConsultArt.class:Inte_KeyPress](../../../../../.src/Gestion/Tables/ConsultArt.class#L792-L802), [ConsultArt.class:Cb1_Click](../../../../../.src/Gestion/Tables/ConsultArt.class#L862-L881)
- [ ] CONSULTART-008 — [commonalisation] Remplissage de la grille `Tbrem` par le helper
  `AfficheRemisesQte` partagé avec `Articles` (ARTICLES-008) · appelants : aucun · tests : T03 ·
  sources : [ConsultArt.class:Maj_Zones](../../../../../.src/Gestion/Tables/ConsultArt.class#L397-L480), [Articles.class:Button10_click](../../../../../.src/Gestion/Tables/Articles.class#L3672-L3699)
- [ ] CONSULTART-009 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `Deb4`, `Fam2`, `fourMan`,
  `Maj_Zones`, `CleanChamps`, `Dbclk`, `entete` → `Private` ; `Refresh` conservé (surcharge de la
  méthode héritée, à confirmer) ; `Colarts_Click` reste `Public` (rejeu dynamique) · appelants :
  aucun · tests : T01-T05 · sources : [ConsultArt.class:Tris](../../../../../.src/Gestion/Tables/ConsultArt.class#L204-L218), [ConsultArt.class:Dbclk](../../../../../.src/Gestion/Tables/ConsultArt.class#L724-L734), [ConsultArt.class:entete](../../../../../.src/Gestion/Tables/ConsultArt.class#L736-L744)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] CONSULTART-A01 — [anomalie] Recherche incrémentale par concaténation de `sel` entre
  guillemets doubles : un `"` saisi provoque une erreur SQL, `%` et `_` agissent comme jokers ;
  correction par paramètre `&1` (et échappement des jokers) · tests : T05 · sources : [ConsultArt.class:243](../../../../../.src/Gestion/Tables/ConsultArt.class#L243), [ConsultArt.class:284](../../../../../.src/Gestion/Tables/ConsultArt.class#L284), [ConsultArt.class:321](../../../../../.src/Gestion/Tables/ConsultArt.class#L321)
- [ ] CONSULTART-A02 — [anomalie] Recherche par code-barre (`Code_KeyPress`) sans `CleanChamps` :
  la quantité en commande fournisseur s'ajoute à celle de l'article précédent, et la quantité en
  stock affiche 0 si l'article précédent n'était pas stocké · tests : T04 · sources : [ConsultArt.class:Code_KeyPress](../../../../../.src/Gestion/Tables/ConsultArt.class#L594-L606), [ConsultArt.class:429-443](../../../../../.src/Gestion/Tables/ConsultArt.class#L429-L443)
- [ ] CONSULTART-A03 — [anomalie] Tri descendant des articles suspendus : `Deb3` sélectionne
  `art_pvttc` au lieu de `art_fam` ; la colonne « Famille » reste vide · tests : T02 · sources : [ConsultArt.class:291](../../../../../.src/Gestion/Tables/ConsultArt.class#L291)
- [ ] CONSULTART-A04 — [anomalie] `Fam2` lit famille et TVA sans test `Available` : un code TVA
  absent affiche « Cette famille n'existe pas ! » (message trompeur) · tests : T03 · sources : [ConsultArt.class:Fam2](../../../../../.src/Gestion/Tables/ConsultArt.class#L485-L518)
- [ ] CONSULTART-A05 — [anomalie] La grille lit `Utils.rs1`, résultat global partagé avec tous les
  écrans qui appellent `Utils.Base` : l'écran étant non modal, ouvrir un autre écran utilisant
  `Utils.Base` remplace les données affichées (lignes d'une autre requête ou erreurs ; à confirmer
  par T06) · tests : T06 · sources : [ConsultArt.class:155-156](../../../../../.src/Gestion/Tables/ConsultArt.class#L155-L156), [Utils.module:Base](../../../../../.src/Utils/Utils.module#L39-L49)
