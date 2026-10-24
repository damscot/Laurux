# OptFac — Tests

> Source : `.src/Gestion/Facturation/OptFac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay`. Jeu de données : `facturation_base` décrit dans
[`ObjFac.class/test.md`](../ObjFac.class/test.md). Comparaisons : dump normalisé de la base,
`Laurux.conf` du test (clés `/Soc01/…` persistées), texte des PDF produits dans `~/tmp`
(`pdftotext`), journal de rejeu.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| OPTFAC-T01 | replay | Édition d'un BL | Facture › BL existant › Éditer › options par défaut › `edite` | PDF BL ; dump inchangé hors effets d'`ObjFacB.editebl` | `tests/edition_bl/` | à faire |
| OPTFAC-T02 | replay | Édition d'une facture | Facture › facture › `edite` | PDF facture, écritures comptables (`Fiches_Mvt`), `Fiches_Bl.numfac/imp` | `tests/edition_facture/` | à faire |
| OPTFAC-T03 | replay | Persistance des options | basculer Entête, Réserves, Pied, Récap, 2ᵉ ligne, Col., Stock, Cond., Tot. BL puis Fermer | `Laurux.conf` : 10 clés `/Soc01/…` écrites | `tests/persistance_options/` | à faire |
| OPTFAC-T04 | replay | Adresse de livraison | `AffBledit2`, choix dans `Colal`, Fermer ; puis réouverture et effacement du nom | `Fiches_AdrlivBL` créée puis supprimée | `tests/adresse_livraison/` | à faire |
| OPTFAC-T05 | replay | Changement d'échéance | saisir une autre date dans `Dtech` | `Fiches_Bl.ech` mis à jour | `tests/echeance/` | à faire |
| OPTFAC-T06 | replay | Fin de mois triée | Facturefm › Imprimer › tri Nom + CP › `edite` | ordre des factures (texte PDF), dump après `editefm` | `tests/fin_de_mois_tri/` | à faire |
| OPTFAC-T07 | replay | Fin de mois fermée sans édition | Facturefm › Imprimer › Fermer | figer l'erreur éventuelle « Null object » (A03) | `tests/fin_de_mois_fermer/` | à faire |
| OPTFAC-T08 | replay | Case « Copie fichier PDF » | facture, cocher `ImpPDF` puis `edite` | figer le comportement (A02 : fichier `T` envoyé à l'impression) | `tests/copie_pdf/` | à faire |
| OPTFAC-T09 | replay | F2 dans la liste d'adresses | `Colal` visible, F2 | figer l'erreur « Unknown symbol numcl » (A01) | `tests/adresses_f2/` | à faire |
| OPTFAC-T10 | replay | Facture archivée et règlement | Archives › facture › Éditer ; `Rgmt` coché/décoché, texte sur 2 lignes | `tsaisreg` imprimé (texte PDF) | `tests/archive_reglement/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB Docker), date
  système figée (`faketime`) car `LDate(Now)` sert de date par défaut.
- **Impression** : imprimante virtuelle (CUPS-PDF ou `OutputFile`) ; seuls les PDF écrits dans
  `~/tmp` sont comparés en texte.
- **SMS et courriel** (`sms_Click`, `mail_Click`) : non testables sans service externe ; `Gsm` et
  `EnvMail` sont remplacés par des doublures en phase 2, ou exclus (à décider). A04 (numéro SMS)
  est testable en isolant l'expression dans un `gbtest` après séparation.
- Les tests de fin de mois dépendent de la table de travail `Facturefm` (voir `Facturefm`) :
  l'exclure du dump normalisé.
