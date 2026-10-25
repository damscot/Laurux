# Bordereaux — Architecture

> Source : `.src/Caisse/Bordereaux.class`

## Vue d'ensemble

`Bordereaux` est l'écran **« Impression des bordereaux de remises »** de la caisse (menu Caisse >
Opérations de fin de journée, `Fmenu.Menu214_Click` → `Bordereaux.ShowModal`). Il imprime en PDF
(`Cbordereaux`, `~/Caisse/Bordereau_[Cheques_|Cartes_]<jj.mm.aaaa>.pdf`, ouvert par
`Visualiseur.Prog`) la liste des règlements par chèque (`type = "V"`) et/ou par carte (`"U"`)
présents dans `Fiches_LigTicketz`, c'est-à-dire tous les tickets **non encore moulinés** (le
moulinage les supprime), avec un total par type.

Le formulaire porte trois boutons radio (`Tous`, `Cheques`, `Cartes`), une case `Imptk`
(numéros de tickets) et trois boutons (Quitter, Imprimer, Aide). Lecture seule : aucune écriture en
base. Pas d'appel à `Utils.Observers(Me)` : écran non journalisé.

Ne pas confondre avec [`BordereauxC`](../../Compta/Impressions/BordereauxC.class/architecture.md)
(Comptabilité, remise de chèques et comptabilisation) : celui-ci référence par erreur
l'auto-instance de ce formulaire (`Bordereaux.Text`, BORDEREAUXC-A01), ce qui charge `Bordereaux`
en mémoire (exécution de `_new`, `Me.Center`) sans l'afficher.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `PosY` | var | Private |  | Integer | 3 |
| `pdf` | var | Private |  | Cbordereaux | 4 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 6-10 | Public | 1 | 3 | 0 | méthode spéciale |
| `Button1_Click` | 12-19 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 21-25 | Public | 1 | 3 | 0 | handler GUI |
| `Imp_Bordereaux` | 27-131 | Public | 14 | 100 | 0 | portée réductible ? |
| `Imp_Entete` | 133-167 | Public | 6 | 32 | 0 | portée réductible ? |
| `Button3_Click` | 172-176 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire] [nature : GUI]. `Me.Center`.
- **`Button1_Click()`** [handler] [GUI]. Ferme l'écran (les `Kill` des PDF sont commentés).
- **`Button2_Click()`** [handler] [GUI]. `Imp_Bordereaux()`.
- **`Button3_Click()`** [handler] [GUI]. `Doc.Open("Bordereaux")`.
- **`Imp_Bordereaux()`** [portée : réductible] [nature : mixte, CC 14].
  - `Shell "cd " & User.Home` : sans effet (sous-shell).
  - Requête sur `Fiches_LigTicketz` (nom en dur) selon le bouton radio : `type = "U" or "V"` triés
    par type puis `cast(numlig as unsigned)`, ou un seul type. **Aucun filtre** sur la caisse, la
    date, le statut ni la suppression du ticket : les règlements des tickets supprimés ou en erreur
    sont listés (BORDEREAUX-A01, à confirmer avec la règle métier). Le tri par numéro de ligne
    seul mélange les tickets.
  - PDF `Cbordereaux` (portrait A4) : en-tête société (`Imp_Entete`), une ligne par règlement
    (`Level5` : « Ticket N° … » + intitulé tronqué de son préfixe `Chèque `/`Carte ` via `Mid$`
    sur 8 ou 7 octets, montant), saut de page à `PosY >= 240` (nouvelle page par
    `Cbordereaux.Entete`), total par type au changement de type et en fin de liste.
  - Incohérences de mise en page : premier en-tête à `PosY = 0` puis 6 ensuite ; total
    intermédiaire aligné par `Space$(90)`, total final par `Space$(50)` (BORDEREAUX-A02).
  - Sans données : `Music.Play` et `Message.Info`.
  - Remises à zéro inutiles de `nbreg`/`Montant` après le total final.
- **`Imp_Entete(Txtb)`** [portée : réductible] [nature : mixte (SQL + PDF)]. Nouvelle page,
  société courante (`Cbase.Table("TabSoc")`, `cd_sc = Start.Societe`, lue **sans** test
  `Available`), SIRET de `Start.LocalSettings["/Soc<XX>/Siret"]` et de la base, logo optionnel
  (`/glogo`, `/Logo`), puis titre `TitreB` entre deux traits. Même en-tête société que 6 éditions
  (voir commonalisation).

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Cbase.Table("TabSoc")`, nom en dur `Fiches_LigTicketz`.
- `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Siret|glogo|Logo"]`.
- `User.Home` (`~/Caisse`), `Visualiseur.Prog`, `Music`, `Doc`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Le choix du titre et de la largeur de préfixe (`Txtb`, `lg`) et le bloc d'impression du total
  sont écrits deux fois : helpers privés `Titre_Type(type)` et `Imprime_Total(…, espaces)` (en
  gardant les deux largeurs 90/50 tant que A02 n'est pas validée).
- Supprimer le `Shell "cd …"`, les remises à zéro finales et les lignes `Kill` commentées.

### Commonalisation avec d'autres fichiers

- En-tête société des PDF (`Imp_Entete`) : helper commun `Creleve.EnteteSociete` proposé par
  [Ligcli](../../Compta/Relances/Ligcli.class/architecture.md) (LIGCLI-004), même idiome dans
  `Edcom`, `Edart4` et [BordereauxC](../../Compta/Impressions/BordereauxC.class/architecture.md)
  (`Imp_Bordereaux`, même classe `Cbordereaux`).
- Liste des règlements de caisse par type : mêmes données que `Livre_caisse` de
  [Moulinage](../Moulinage.class/architecture.md) (totaux par mode de règlement) et que
  `Maj_Tresorerie` ; une requête commune « règlements de caisse non moulinés » éviterait trois
  filtres divergents (A01).

### Réduction de portée

- `Imp_Bordereaux`, `Imp_Entete` → `Private` (`grep -rn "Bordereaux\." .src` : seul
  `Fmenu:1871` appelle `ShowModal` ; `BordereauxC:370` lit la propriété héritée `Text`).

### Séparation traitement / GUI

- `Imp_Bordereaux(sTypes, bNumeros)` : les boutons radio et la case `Imptk` sont lus par
  `Button2_Click`, qui passe les valeurs ; la requête est isolée dans
  `Lignes_Remise(types) As Result`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Montants `char(12)` et `numlig` `char(6)` de `Fiches_LigTicketz` : types numériques
  (suppression du `cast(numlig as unsigned)` propre à MySQL et des `Val(cpoint())`).
- Un indicateur « remis en banque » sur les lignes de règlement permettrait d'imprimer un
  bordereau sans attendre le moulinage et d'éviter les réimpressions.
