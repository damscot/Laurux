# Famille — Tests

> Source : `.src/Gestion/Tables/Famille.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de table : tests `replay` (menu Gestion › Tables › Familles) avec diff de `Fiches_Fam` et
`Fiches_FamDep`. Valeurs attendues produites dans le clone **Laurux non modifié** (anomalies
figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FAMILLE-T01 | replay | Création complète | code `TST`, libellé avec apostrophe, coef `1,5`, remise, TVA `1`, comptes 7xx, 709xxx, éco-taxe ; 3 tranches de remise par quantité ; Enregistrer | ligne `Fiches_Fam` (31 colonnes) ; `Fiches_FamDep` avec `depot = ''` (FAMILLE-A04 figée) | `tests/creation/` | à faire |
| FAMILLE-T02 | replay | Modification et TVA | sélection d'une famille utilisée par des articles ; changement du code TVA, puis du coefficient | message « modification du code Tva n'est pas permise », ancien code rétabli ; coefficient enregistré | `tests/modification_tva/` | à faire |
| FAMILLE-T03 | replay | Contrôles de saisie | compte inexistant, compte de remise non 709, coefficient invalide, champ obligatoire vide | messages, focus, aucune écriture | `tests/controles/` | à faire |
| FAMILLE-T04 | replay | Listes F2 | F2 sur TVA, sur compte de vente, sur `Codecompt2` ; choix par Entrée et par clic | zones remplies (F2 sur `Codecompt2` remplit le compte de remise, FAMILLE-A01 figée) | `tests/listes/` | à faire |
| FAMILLE-T05 | replay | Suppression | famille utilisée (refus), puis famille libre sélectionnée | message de refus et pointeur d'attente (A02) ; ligne supprimée, `Fiches_FamDep` conservé (A03) | `tests/suppression/` | à faire |
| FAMILLE-T06 | replay | Remises par quantité | navigation clavier dans `Tbrem` (flèches, Tab, Entrée), valeurs > 9 999 999,99 | contenu de la grille et colonnes `qte*`/`rem*` enregistrées | `tests/remises_quantite/` | à faire |
| FAMILLE-T07 | replay | Option dépôts | `/Soc01/Depots` actif, 2 dépôts ; compte spécifique au dépôt 02 | `Fiches_FamDep` (fam, compte, depot `02`) ; relecture par `Dep_Click` | `tests/depots/` | à faire |
| FAMILLE-T08 | replay | Onglets et rejeu | trois clics sur l'onglet Statistiques puis retour ; une saisie | journal de rejeu (nombre d'événements enregistrés par action, FAMILLE-A05 figée) | `tests/onglets_rejeu/` | à faire |
| FAMILLE-T09 | replay | Synchronisation serveur | `/Soc01/Sprix`, `Sexport`, `SMajArt` actifs ; création puis modification | fichiers d'échange `Serveur.Pass` (`Fam`, `C` puis `M`) | `tests/serveur/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (familles, TVA, comptes) + jeu dérivé : un article dans une
  famille, une main d'œuvre dans une autre, deux dépôts (`Fiches_Depots`) pour T07.
- **Comparaison** : dump normalisé de `Fiches_Fam` et `Fiches_FamDep` ; contenu des grilles
  relevé par le replay pour T04 et T06 ; T08 compare le nombre de lignes du journal de rejeu.
- **Statistiques** (`gridvi`) : couvertes par les tests de `gridvi`, pas ici.
- **Non testables** : couleurs de fond (thème), son, documentation `Doc.Open`.
