# Articles — Rework

> Source : `.src/Gestion/Tables/Articles.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Articles.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 3775 |
| Lignes de commentaire | 334 |
| Fonctions | 145 |
| Fonctions Public | 144 |
| Complexité cyclomatique totale | 1128 |
| Complexité max (fonction) | 96 (`Maj_Zones`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 3775 | 1127 | 96 | 0 | 143 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Fichier legacy (4757 lignes, CC 1127) : reworks **minimaux et ciblés**. Aucun changement de nom de
handler ou de pseudo-handler, aucun changement de l'ordre des requêtes d'enregistrement, aucun
changement de `Tag` (le `.form` est intouchable).

- [ ] ARTICLES-001 — [documentation] En-tête de classe en français : rôle, utilisateurs (auto-instance
  depuis `Fmenu`, F3/F4 d'`Achat`, `Facture`, `TarTypeCli`, `Prodcomposes`, instance de `GesTar`,
  bibliothèque pour `SupprArt`), table des tags du groupe `Cmpt`/`Stock`/`Btn`/`Ard`, signification
  des drapeaux `b`, `Chkfocus`, `Chkf`, `Reaf`, `nouveau`, `ibarre`, `sbarre`, `Fml`, `Fcfour`, `Txc`,
  `Tvavente` ; commentaires `'''` sur `art_Suppr` et `EnrgArt` · appelants : aucun · tests : T01 ·
  sources : [Articles.class:_New](../../../../../.src/Gestion/Tables/Articles.class#L101-L225), [Articles.class:Cmpt_KeyPress](../../../../../.src/Gestion/Tables/Articles.class#L868-L1307), [Articles.class:art_Suppr](../../../../../.src/Gestion/Tables/Articles.class#L4060-L4155)
- [ ] ARTICLES-002 — [code mort] Supprimer les fonctions jamais appelées : `ToggleButton66_Click`
  (aucun contrôle `ToggleButton66` dans le `.form`), `Dsg1_GotFocus` (handler inactif : `Dsg1` est
  dans le groupe `Dsg`, signalé par `deps.py` et confirmé par grep), `Ec0LF`, `TvaMan`, `Tnom_Photo`,
  `Codart` (grep : aucun appel ; les homonymes de `Movr`, `FTvac`, `Fcaras` sont des copies
  locales). `Stocke_MouseUp2`, elle aussi jamais appelée, est traitée par ARTICLES-A15 ·
  appelants : aucun · tests : T01-T04, T14 · sources : [Articles.class:ToggleButton66_Click](../../../../../.src/Gestion/Tables/Articles.class#L786-L808), [Articles.class:Dsg1_GotFocus](../../../../../.src/Gestion/Tables/Articles.class#L1804-L1837), [Articles.class:Ec0LF](../../../../../.src/Gestion/Tables/Articles.class#L2504-L2525), [Articles.class:TvaMan](../../../../../.src/Gestion/Tables/Articles.class#L2985-L3000), [Articles.class:Tnom_Photo](../../../../../.src/Gestion/Tables/Articles.class#L4352-L4364), [Articles.class:Codart](../../../../../.src/Gestion/Tables/Articles.class#L4415-L4420)
- [ ] ARTICLES-003 — [code mort] Variables d'instance inutilisées ou écrites sans être lues :
  `Arttable`, `Spd`, `Dbl`, `CoulB`, `CoulF`, `Fnt`, `NbEnreg`, `hColArts`, `Tableau`, `lg`, `sel`,
  `Stk`, `Stk2`, `CoulZns`, `CoulFc`, `sKey`, `B2` (après ARTICLES-002) ; `ComResult` devient une
  locale de `ToggleButton5_Click` ; locales sans effet `chkf`/`Fml` d'`AfficheArt` ; boucle `Tbrem2`
  qui répète six fois la même affectation ; `If Error` redondant ligne 437 ; `Bsel`/`Bval` **conservés**
  (écrits par `TriGen` via `Object.SetProperty`) · appelants : aucun · tests : T01, T14 · sources : [Articles.class:26-98](../../../../../.src/Gestion/Tables/Articles.class#L26-L98), [Articles.class:AfficheArt](../../../../../.src/Gestion/Tables/Articles.class#L690-L734), [Articles.class:158-166](../../../../../.src/Gestion/Tables/Articles.class#L158-L166), [Articles.class:437](../../../../../.src/Gestion/Tables/Articles.class#L437)
- [ ] ARTICLES-004 — [code mort] Supprimer la requête de comptage de `_New`
  (`SELECT art_code FROM TabArt`, résultat `NbEnregTot` jamais lu ; **SQL modifié, dump identique**),
  la branche `mo_code` et le `Default` d'`Update_Req` (`Tri` vaut toujours `"art_code"`), et dans
  `Maj_Zones` la branche inatteignable d'avertissement de famille (278-285 : `Fam` vient d'être vidé
  par `CleanChamps`) ainsi que les tests `Reaf <> 1` / `reaf <> "1"` toujours vrais à l'intérieur du
  bloc gardé · appelants : aucun · tests : T01, T02, T12, T14 · sources : [Articles.class:180](../../../../../.src/Gestion/Tables/Articles.class#L180), [Articles.class:Update_Req](../../../../../.src/Gestion/Tables/Articles.class#L4689-L4757), [Articles.class:278](../../../../../.src/Gestion/Tables/Articles.class#L278), [Articles.class:327](../../../../../.src/Gestion/Tables/Articles.class#L327), [Articles.class:481](../../../../../.src/Gestion/Tables/Articles.class#L481)
- [ ] ARTICLES-005 — [commonalisation] Noms de tables par `Cbase.Table` : `Fiches_Parametres` →
  `TabParam` (`CleanChamps`, `EnrgArt`), `Fiches_Mvtexpdc` → `TabMvtexpdc` (`Composants_Click`),
  `Fiches_Comptes` → `TabComptes` (`FamMan`), `Fiches_Four` → `TabFour` (`ToggleButton5_Click`),
  `Fiches_TarTypcli`/`Fiches_Typec`/`Fiches_Art` → `TabTcli`/`TabTypec`/`TabArt` (`Maj_ColType`),
  `Fiches_Marques` → `Cbase.Table("TabMarq")` (`_New`, `marque.champs`) ; `Del_CodeBarre` traité
  avec ARTICLES-A01 ; SQL émis identique · appelants : aucun · tests : T01, T02, T05, T14 · sources : [Articles.class:567](../../../../../.src/Gestion/Tables/Articles.class#L567), [Articles.class:3905](../../../../../.src/Gestion/Tables/Articles.class#L3905), [Articles.class:545](../../../../../.src/Gestion/Tables/Articles.class#L545), [Articles.class:3012](../../../../../.src/Gestion/Tables/Articles.class#L3012), [Articles.class:4212](../../../../../.src/Gestion/Tables/Articles.class#L4212), [Articles.class:4598](../../../../../.src/Gestion/Tables/Articles.class#L4598), [Articles.class:4602](../../../../../.src/Gestion/Tables/Articles.class#L4602), [Articles.class:111](../../../../../.src/Gestion/Tables/Articles.class#L111)
- [ ] ARTICLES-006 — [commonalisation] Garde d'export `Variables.Sprix And Variables.Sexport And
  Variables.SMajArt` (10 occurrences) remplacée par `Serveur.Actif("Art")` (SERVEUR-008, à faire
  avant) · appelants : aucun · tests : T01, T08, T10 (avec et sans export configuré) · sources : [Articles.class:3908](../../../../../.src/Gestion/Tables/Articles.class#L3908), [Articles.class:3924](../../../../../.src/Gestion/Tables/Articles.class#L3924), [Articles.class:Maj_CodeBarre](../../../../../.src/Gestion/Tables/Articles.class#L3980-L3988), [Articles.class:Del_CodeBarre](../../../../../.src/Gestion/Tables/Articles.class#L3990-L3997), [Articles.class:Maj_Rpl1](../../../../../.src/Gestion/Tables/Articles.class#L3999-L4009), [Articles.class:Del_Rpl1](../../../../../.src/Gestion/Tables/Articles.class#L4011-L4020), [Articles.class:Maj_Rpl2](../../../../../.src/Gestion/Tables/Articles.class#L4022-L4032), [Articles.class:Del_Rpl2](../../../../../.src/Gestion/Tables/Articles.class#L4034-L4043), [Articles.class:Del_Codequ](../../../../../.src/Gestion/Tables/Articles.class#L4045-L4054), [Articles.class:4118](../../../../../.src/Gestion/Tables/Articles.class#L4118)
- [ ] ARTICLES-007 — [complexité] Helpers privés pour les idiomes répétés, à comportement
  identique : `ErreurSon()` (27 blocs `Catch` son + `Message.Error(Error.Text & " " & Error.where)`),
  `SaisieInvalide()` (21 avertissements « Veuillez verifier votre saisie SVP ! » précédés du son et
  suivis de `b = 1`), `FocusSel(hCtrl)` (couples `SetFocus`/`Select`) · appelants : aucun ·
  tests : T01-T04, T10, T11 · sources : [Articles.class:pbhtLF](../../../../../.src/Gestion/Tables/Articles.class#L1934-L1963), [Articles.class:PaUALF](../../../../../.src/Gestion/Tables/Articles.class#L2073-L2130), [Articles.class:Cmpt_KeyPress](../../../../../.src/Gestion/Tables/Articles.class#L868-L1307), [Articles.class:Cmpt_lostFocus](../../../../../.src/Gestion/Tables/Articles.class#L1554-L1802)
- [ ] ARTICLES-008 — [complexité] `Maj_Zones` (CC 96) : extraire `ChargeListe(hCombo, sTable,
  sColonne, sCode)` pour les quatre boucles `TabCdBarre`/`TabRpl1`/`TabRpl2`/`TabCequ` (le filtre
  `codequ <> code` de `Cequ` en paramètre) et `AfficheRemisesQte(r As Result)` pour les 18 `Try`
  de la grille `Tbrem`, partagée avec `Button10_click` ; SQL émis identique (CC visée ≤ 40) ·
  appelants : aucun · tests : T02, T03, T10, T12 · sources : [Articles.class:Maj_Zones](../../../../../.src/Gestion/Tables/Articles.class#L260-L510), [Articles.class:Button10_click](../../../../../.src/Gestion/Tables/Articles.class#L3672-L3699)
- [ ] ARTICLES-009 — [complexité] `EnrgArt` (CC 68) : extraire `InsereArticle()`, `MajArticle()` et
  `MajSatellites()` (bloc codes-barres / remplacements / équivalence dupliqué entre création et
  modification), sans changer l'ordre des requêtes ni la portée de la variable locale `b` (voir A03)
  · appelants : aucun · tests : T01, T02, T10, T11 · sources : [Articles.class:EnrgArt](../../../../../.src/Gestion/Tables/Articles.class#L3829-L3978)
- [ ] ARTICLES-010 — [complexité] Validations `*LF` à schéma identique (`PvconsLF`, `Pds_LF`,
  `Bonus_LF`, `PVHT2LF`, `EcoLF`, `Eco2LF`, `CoppLF`, `Stockmini_LF`, `Stockmaxi_LF`, `Mincom_LF`) :
  helper privé `ChampNumerique(hTxt, sFormat, bSiNonNul, sDefaut)` reproduisant exactement chaque
  variante (format, valeur par défaut, `Catch` présent ou non, couleur de `Copp`) · appelants :
  aucun · tests : T02, T04 · sources : [Articles.class:PvconsLF](../../../../../.src/Gestion/Tables/Articles.class#L2355-L2383), [Articles.class:Pds_LF](../../../../../.src/Gestion/Tables/Articles.class#L2388-L2412), [Articles.class:CoppLF](../../../../../.src/Gestion/Tables/Articles.class#L2582-L2603), [Articles.class:Mincom_LF](../../../../../.src/Gestion/Tables/Articles.class#L3617-L3634)
- [ ] ARTICLES-011 — [séparation traitement/GUI] Fonctions pures sur des valeurs, appelées par les
  fonctions actuelles qui gardent la lecture/écriture des contrôles : `PrixAchatNet(pbht, tr, rem1,
  rem2, rem3)` (`TrC`, `Rem_KeyPress`), `PrixTTC(pvht, txtva)` (`Tva_Calcul`),
  `ArrondiPvTTC(sPvttc, sArr, sFormat) As String` (`arrondi`, algorithme de chaîne conservé),
  `TauxMarque`, `CoefDepuisTaux`, `CoefTTC`, `Marges` (`Calc_*`) · appelants : aucun · tests : T03,
  T16 · sources : [Articles.class:TrC](../../../../../.src/Gestion/Tables/Articles.class#L1968-L2001), [Articles.class:Rem_KeyPress](../../../../../.src/Gestion/Tables/Articles.class#L2022-L2062), [Articles.class:Tva_Calcul](../../../../../.src/Gestion/Tables/Articles.class#L2608-L2620), [Articles.class:arrondi](../../../../../.src/Gestion/Tables/Articles.class#L2625-L2662), [Articles.class:Calc_Marge](../../../../../.src/Gestion/Tables/Articles.class#L2696-L2712), [Articles.class:Calc_Percent](../../../../../.src/Gestion/Tables/Articles.class#L2717-L2724), [Articles.class:Calc_coeff](../../../../../.src/Gestion/Tables/Articles.class#L2729-L2734), [Articles.class:Calc_coeff2](../../../../../.src/Gestion/Tables/Articles.class#L2739-L2743)
- [ ] ARTICLES-012 — [commonalisation] Arrondi du PV TTC « au 0,05 » par chaîne :
  `ArrondiPvTTC` (ARTICLES-011) devient la fonction commune utilisée par `Movr.arrondi`,
  `Materiel.arrondi` et `FTvav.arrondi` **après comparaison ligne à ligne** des variantes (une
  variante divergente garde son code) ; rapprochement avec `LPrix.Arrondi_Calc` et `Utils.arrondi`
  documenté seulement · appelants : `Movr`, `Materiel`, `FTvav` (via leurs propres cases) · tests :
  T03, T16 · sources : [Articles.class:arrondi](../../../../../.src/Gestion/Tables/Articles.class#L2625-L2662), [Movr.class:arrondi](../../../../../.src/Gestion/Tables/Movr.class#L1599-L1635), [Materiel.class:arrondi](../../../../../.src/Gestion/Tables/Materiel.class#L1281-L1318), [FTvav.class:arrondi](../../../../../.src/Compta/Tables/FTvav.class#L509-L547), [LPrix.class:Arrondi_Calc](../../../../../.src/Utils/LPrix.class#L164-L198)
- [ ] ARTICLES-013 — [commonalisation] Édition de la grille de remises quantitatives (`tbrem_Click`,
  `tbxrem_KeyPress`, `MoveToCol`, `ShowTextBox`, `HideTextBox`) : classe utilitaire commune
  `GrilleRemises` (TableView + TextBox passées en paramètres, couleur `CoulZnaf`) partagée avec
  `Famille` ; handlers conservés, ils délèguent · appelants : `Famille` (via sa case) · tests : T02 ·
  sources : [Articles.class:tbrem_Click](../../../../../.src/Gestion/Tables/Articles.class#L3702-L3713), [Articles.class:tbxrem_KeyPress](../../../../../.src/Gestion/Tables/Articles.class#L3716-L3748), [Articles.class:ShowTextBox](../../../../../.src/Gestion/Tables/Articles.class#L3767-L3790), [Articles.class:HideTextBox](../../../../../.src/Gestion/Tables/Articles.class#L3793-L3824), [Famille.class:ShowTextBox](../../../../../.src/Gestion/Tables/Famille.class#L278-L301)
- [ ] ARTICLES-014 — [commonalisation] Promotion du jour (`Form_Open`) par `ArtPromo.PromoDuJour()`
  (ARTPROMO-004), même requête et même règle « première ligne » · appelants : aucun · tests : T06 ·
  sources : [Articles.class:Form_Open](../../../../../.src/Gestion/Tables/Articles.class#L227-L252), [ArtPromo.module:art_Promo](../../../../../.src/Gestion/Tables/ArtPromo.module#L5-L14)
- [ ] ARTICLES-015 — [commonalisation] `LGed.Supprime(True)` appelé sur l'auto-instance (seule
  l'épuration des tags s'exécute, `$index = 0`) remplacé par l'appel explicite `LGed.EpurationTags()`
  (même effet, SQL émis identique) ; à faire valider avec la requalification de LGED-A07 ·
  appelants : aucun · tests : T08 · sources : [Articles.class:4126](../../../../../.src/Gestion/Tables/Articles.class#L4126), [LGed.class:Supprime](../../../../../.src/Utils/LGed.class#L124-L134)
- [ ] ARTICLES-016 — [complexité] `Maj_ColType` : filtrer `cart = &1` dans la requête et joindre
  `TabArt` au lieu de relire l'article pour chaque ligne (**SQL modifié, dump identique**, affichage
  identique) ; `ToggleButton5_Click` : jointure unique `TabLigcom` × `TabEntcom` × `TabFour` au lieu
  des requêtes N+1 (même ordre d'affichage à vérifier) · appelants : aucun · tests : T05, T14 ·
  sources : [Articles.class:Maj_ColType](../../../../../.src/Gestion/Tables/Articles.class#L4580-L4613), [Articles.class:ToggleButton5_Click](../../../../../.src/Gestion/Tables/Articles.class#L4186-L4239)
- [ ] ARTICLES-017 — [séparation traitement/GUI] `art_Suppr` : extraire
  `MotifRefusSuppression(sCode) As String` (les six contrôles SQL) et `SupprimeArticle(sCode)` (les
  écritures), la confirmation et `Utils.Bip` restant dans `art_Suppr` ; signature publique inchangée
  · appelants : `SupprArt` (inchangé) · tests : T08, T09 · sources : [Articles.class:art_Suppr](../../../../../.src/Gestion/Tables/Articles.class#L4060-L4155), [SupprArt.class:button8_Click](../../../../../.src/Gestion/SupprArt.class#L347-L405), [SupprArt.class:Suppression](../../../../../.src/Gestion/SupprArt.class#L410-L440)
- [ ] ARTICLES-018 — [réduction de portée] `Public` → `Private` pour les membres sans appelant
  externe (liste « portée réductible » de `deps.py`, vérifiée par grep), **sauf** `art_Suppr`
  (`SupprArt`), `Refresh` (surcharge de la méthode héritée du formulaire, à confirmer), `Bsel`/`Bval`
  (`TriGen`), tous les handlers et les `<Grille>_Click` appelés par le rejeu (`Composants_Click`,
  `fourList_Click`, `FamList_Click`, `ColMarque_Click`) ; `Button1_Click` (pseudo-handler du groupe
  `Btn`) passe `Private` en gardant son nom · appelants : aucun · tests : T01-T14 (replays) ·
  sources : [Articles.class:Maj_Zones](../../../../../.src/Gestion/Tables/Articles.class#L260-L510), [Articles.class:EnrgArt](../../../../../.src/Gestion/Tables/Articles.class#L3829-L3978), [Articles.class:Update_Req](../../../../../.src/Gestion/Tables/Articles.class#L4689-L4757), [Articles.class:Button1_Click](../../../../../.src/Gestion/Tables/Articles.class#L4160-L4181)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel (sur base jetable : A01 et A02 détruisent des données).

- [ ] ARTICLES-A01 — [anomalie] **Grave** : Suppr dans le champ `Cbarre` (y compris pour effacer un
  caractère) appelle `Del_CodeBarre`, qui exécute `DELETE FROM Fiches_Art WHERE art_code = &1 and
  art_cbarre = &2` : la **fiche article entière** est supprimée quand le code-barre est le code-barre
  principal, sans confirmation ni contrôle de stock ou de documents (intention probable : vider
  `art_cbarre`) · tests : T10 · sources : [Articles.class:1245](../../../../../.src/Gestion/Tables/Articles.class#L1245), [Articles.class:3993](../../../../../.src/Gestion/Tables/Articles.class#L3993)
- [ ] ARTICLES-A02 — [anomalie] Suppr dans `Cequ` appelle toujours `Del_Codequ` (test
  `IsNull(Cequ)` sur l'objet), sans confirmation ; `DELETE … WHERE codequ = &2 or codep = &2` supprime
  toutes les équivalences de l'article équivalent (le code courant `&1` est ignoré) ; export
  `Serveur.Pass("Rpl1", "S", code, Rpl1.Text)` au lieu d'une notification d'équivalence · tests : T10
  · sources : [Articles.class:1248](../../../../../.src/Gestion/Tables/Articles.class#L1248), [Articles.class:4050](../../../../../.src/Gestion/Tables/Articles.class#L4050), [Articles.class:4051](../../../../../.src/Gestion/Tables/Articles.class#L4051)
- [ ] ARTICLES-A03 — [anomalie] `EnrgArt` déclare une locale `b` qui masque le membre : les doublons
  détectés par `CtrlCfour`, `CtrlCbarre`, `CtrlCfourbl`, `CtrlRefCentrale` et la revérification du
  code-barre ne bloquent pas l'enregistrement ; le refus de changement de famille d'un article présent
  dans des BL affiche « Vous ne pouvez pas changer le code famille… » puis **enregistre** la nouvelle
  famille · tests : T10, T11, T13 · sources : [Articles.class:3835](../../../../../.src/Gestion/Tables/Articles.class#L3835), [Articles.class:3851](../../../../../.src/Gestion/Tables/Articles.class#L3851), [Articles.class:3857](../../../../../.src/Gestion/Tables/Articles.class#L3857), [Articles.class:3876](../../../../../.src/Gestion/Tables/Articles.class#L3876)
- [ ] ARTICLES-A04 — [anomalie] `art_Suppr` teste le stock sur les contrôles du formulaire
  (`stocke.value`, `qte.Text`) et non sur l'article passé : depuis `SupprArt` (auto-instance non
  affichée), des articles **en stock** sont supprimés malgré l'avertissement de `SupprArt` ; si
  l'écran Articles est ouvert, c'est le stock de l'article affiché qui est testé · tests : T09 ·
  sources : [Articles.class:4082](../../../../../.src/Gestion/Tables/Articles.class#L4082), [SupprArt.class:377](../../../../../.src/Gestion/SupprArt.class#L377), [SupprArt.class:423](../../../../../.src/Gestion/SupprArt.class#L423)
- [ ] ARTICLES-A05 — [anomalie] `art_Suppr` laisse des lignes orphelines par rapport à la liste de
  `Changefam.Modifart` : `Fiches_PrdComp` (`codep`, `codec`), `Fiches_ArtPromo`, `Fiches_CdFour`,
  `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_Mvtexpdc`, `Fiches_Tarcli`, `Fiches_TarTypcli`,
  `Fiches_StkDepots`, liens inverses `Fiches_Rpl1.coderpl1` et `Fiches_Rpl2.coderpl2` (créés par
  `Maj_Rpl1`/`Maj_Rpl2`) · tests : T08 · sources : [Articles.class:4128-4142](../../../../../.src/Gestion/Tables/Articles.class#L4128-L4142), [Changefam.class:Modifart](../../../../../.src/Utils/Changefam.class#L500-L555)
- [ ] ARTICLES-A06 — [anomalie] `art_Suppr` sous SQLite : `SHOW TABLES LIKE` et `DELETE IGNORE`
  ne sont pas traduits par `DB_Connection` (erreurs SQL, nettoyage partiel après suppression de la
  fiche) ; le `Catch` renvoie `False`, converti en chaîne vide : `Btn_click` et `SupprArt` concluent à
  un succès (à confirmer par T15) · tests : T15 · sources : [Articles.class:4129](../../../../../.src/Gestion/Tables/Articles.class#L4129), [Articles.class:4130](../../../../../.src/Gestion/Tables/Articles.class#L4130), [Articles.class:4153](../../../../../.src/Gestion/Tables/Articles.class#L4153)
- [ ] ARTICLES-A07 — [anomalie] Requalification de **LGED-A07** (`Articles.class:4126`,
  `LGed.Supprime(True)` sur l'auto-instance) : les enregistrements GED de l'article **sont**
  supprimés par la boucle `Lg.Supprime(False)` ; l'appel statique n'exécute que l'épuration des tags,
  conformément au commentaire. Seul défaut résiduel : le fichier du document reste sur le disque
  (comportement général de `LGed.Supprime`). Décision utilisateur : clore LGED-A07 et appliquer
  ARTICLES-015, ou supprimer aussi les fichiers · tests : T08 · sources : [Articles.class:4119-4127](../../../../../.src/Gestion/Tables/Articles.class#L4119-L4127), [LGed.class:Supprime](../../../../../.src/Utils/LGed.class#L124-L134)
- [ ] ARTICLES-A08 — [anomalie] `FamLF` : littéraux adjacents `"…sauvegarder." "Oui"` (virgule
  manquante) → une seule réponse possible (« Non » = 1) ; les paramètres de la nouvelle famille sont
  appliqués (`FamMan(True)`) puis l'**ancien code** famille est remis (`fam.text = Fml`) ; correction :
  reproduire la logique de `FamList_Click` · tests : T11 · sources : [Articles.class:1899](../../../../../.src/Gestion/Tables/Articles.class#L1899), [Articles.class:1908](../../../../../.src/Gestion/Tables/Articles.class#L1908), [Articles.class:FamList_Click](../../../../../.src/Gestion/Tables/Articles.class#L3140-L3156)
- [ ] ARTICLES-A09 — [anomalie] Changement du nombre de décimales des prix (`Nbd`) : `Reaff` appelle
  `Maj_Zones(code, 1)` qui, tout le remplissage étant gardé par `Reaf <> 1`, ne fait que vider
  `Cbarre` et `Cequ` ; un enregistrement ultérieur écrirait `art_cbarre`/`art_cequ` vides (à
  confirmer : effet de `ComboBox.Clear` sur le texte d'une ComboBox éditable) ; les prix ne sont pas
  reformatés hormis `pbht` · tests : T12 · sources : [Articles.class:Reaff](../../../../../.src/Gestion/Tables/Articles.class#L2683-L2691), [Articles.class:267-272](../../../../../.src/Gestion/Tables/Articles.class#L267-L272)
- [ ] ARTICLES-A10 — [anomalie] `Button8_Click` (GED) : `WHERE art_code = " & Code.Text` sans
  quotes ni paramètre : erreur SQL pour un code alphanumérique (document créé sans tags famille /
  fournisseur ni montants) ; correction par `&1` · tests : T07 · sources : [Articles.class:4485](../../../../../.src/Gestion/Tables/Articles.class#L4485)
- [ ] ARTICLES-A11 — [anomalie] Listes fournisseurs/familles filtrées par
  `left(code,'<n>') = '<texte>'` concaténé (apostrophe → erreur SQL) ; `Dne`, positionné par F2,
  n'est jamais remis à vide (le bouton filtre ensuite toujours sur le texte courant) · tests : T14 ·
  sources : [Articles.class:2934](../../../../../.src/Gestion/Tables/Articles.class#L2934), [Articles.class:3117](../../../../../.src/Gestion/Tables/Articles.class#L3117), [Articles.class:1271](../../../../../.src/Gestion/Tables/Articles.class#L1271)
- [ ] ARTICLES-A12 — [anomalie] `Composants_Click` affiche la date de dernière entrée en stock de
  l'article affiché, quel que soit le composant cliqué, et seulement si `Qte > 0` (intention à
  confirmer) · tests : T14 · sources : [Articles.class:Composants_Click](../../../../../.src/Gestion/Tables/Articles.class#L540-L553)
- [ ] ARTICLES-A13 — [anomalie] `aff_Photo` : `hImage.Stretch` sans effet (résultat ignoré) ;
  après un échec de chargement, l'image précédente est conservée ; réponse « Non » à l'avertissement
  de taille : `Photos` masqué puis dessiné quand même · tests : T18 · sources : [Articles.class:4320](../../../../../.src/Gestion/Tables/Articles.class#L4320), [Articles.class:4327](../../../../../.src/Gestion/Tables/Articles.class#L4327)
- [ ] ARTICLES-A14 — [anomalie] Tags en double dans le `.form` : `Artlie` (24, comme `Bonus`) valide
  `Bonus` et saute à `Eco` ; `Prvt` (27, comme `Eco2`) : une modification de `Eco2` recopie `Prvt`
  dans `$opt.prixrev` ; correction sans toucher au `.form` : tester `Last.Name` dans les cas concernés ·
  tests : T02, T17 · sources : [Articles.class:1199](../../../../../.src/Gestion/Tables/Articles.class#L1199), [Articles.class:1549](../../../../../.src/Gestion/Tables/Articles.class#L1549)
- [ ] ARTICLES-A15 — [anomalie] `Stocke_MouseUp2` n'est jamais levée (événement inexistant) : le
  contrôle « modification impossible, le produit est présent dans les BL ou l'inventaire » n'est pas
  appliqué et `Stocke_Click` remet stock, mini et maxi à 0 sans vérification. Décision : brancher le
  contrôle sur `Stocke_Click` ou supprimer la fonction (code mort) · tests : T02 · sources : [Articles.class:Stocke_MouseUp2](../../../../../.src/Gestion/Tables/Articles.class#L2780-L2820), [Articles.class:Stocke_Click](../../../../../.src/Gestion/Tables/Articles.class#L2770-L2778)
- [ ] ARTICLES-A16 — [anomalie] `Button9_Click` positionne `Variables.OrgCoefTypeCli = "Art"` sans
  jamais le remettre à vide : `CoefTypeC` ouvert ensuite depuis `Fmenu` s'affiche en mode article
  avec l'article précédent ; `Variables.ArtHt` reçoit le prix de revient (`Prvt`) affiché « PA HT »
  (à confirmer) · tests : T05 · sources : [Articles.class:Button9_Click](../../../../../.src/Gestion/Tables/Articles.class#L4552-L4563), [CoefTypeC.class:67](../../../../../.src/Gestion/Tables/CoefTypeC.class#L67)
- [ ] ARTICLES-A17 — [anomalie] `_New` : paramétrage des familles (`/Soc<XX>/ipr`) absent →
  `Message.Error` puis `Me.Close` dans le constructeur, l'initialisation continue (`CB1`,
  `Update_Req`) ; effet réel à confirmer (fenêtre fermée avant affichage, appelants `ShowModal`) ·
  tests : T14 · sources : [Articles.class:193-198](../../../../../.src/Gestion/Tables/Articles.class#L193-L198)
- [ ] ARTICLES-A18 — [anomalie] Création d'article : `art_refcentrale` forcé à `""` (la référence
  centrale saisie est perdue), `art_pbfbt`, `art_datefbt` et `art_crpl1` non enregistrés avant la
  première modification ; test `If nouveau = 0` (3896) jamais vrai · tests : T01 · sources : [Articles.class:3904](../../../../../.src/Gestion/Tables/Articles.class#L3904), [Articles.class:3896](../../../../../.src/Gestion/Tables/Articles.class#L3896)
