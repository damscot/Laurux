# TriCpt — Dépendances

> Source : `.src/Affichages/TriCpt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriCpt.class` — classe, formulaire associé `TriCpt.form`
- Handlers GUI détectés : 14
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [112](../../../../.src/Affichages/TriCpt.class#L112), [113](../../../../.src/Affichages/TriCpt.class#L113)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `<type>`, `Client`, `Sans_Solde` |
| `.src/Compta/Extrait.class` | `<type>`, `Avec_Solde` |
| `.src/Compta/Impressions/Balance.class` | `<type>`, `Avec_Solde`, `General` |
| `.src/Compta/Impressions/EdImpayes.class` | `<type>`, `Avec_Solde` |
| `.src/Compta/Impressions/EdNjustifiees.class` | `<type>`, `Avec_Solde` |
| `.src/Compta/Impressions/EdNlettrees.class` | `<type>`, `Avec_Solde` |
| `.src/Compta/Impressions/Editcompte.class` | `<type>`, `Sans_Solde` |
| `.src/Compta/Impressions/EditcompteA.class` | `<type>`, `Sans_Solde` |
| `.src/Compta/Impressions/Plancomptable.class` | `<type>`, `Sans_Solde` |
| `.src/Compta/Lettrages/Lettrage.class` | `<type>`, `Avec_Solde` |
| `.src/Compta/Pointage.class` | `<type>`, `Avec_Solde`, `Tresorerie` |
| `.src/Compta/Saisecrit.class` | `<type>`, `Avec_Solde` |
| `.src/Compta/Tables/Abont.class` | `<type>`, `Sans_Solde` |
| `.src/Compta/Tables/FComptes.class` | `<type>`, `General`, `Sans_Solde` |
| `.src/Compta/Tresor.class` | `<type>`, `Avec_Solde` |
| `.src/Gestion/Entrées/GesTar.class` | `<type>`, `Client`, `Sans_Solde` |
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `Avec_Solde`, `Client`, `Fournisseur`, `Sans_Solde` |
| `.src/Gestion/Facturation/Facturefm.class` | `<type>`, `Avec_Solde`, `Client` |
| `.src/Gestion/Facturation/FacturefmA.class` | `<type>`, `Avec_Solde`, `Client` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>`, `Avec_Solde`, `Client_Fournisseur` |
| `.src/Gestion/Impressions/EdMat.class` | `<type>`, `Client`, `Sans_Solde` |
| `.src/Gestion/Impressions/EdRup.class` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `.src/Gestion/Impressions/Edart4.class` | `<type>`, `Client`, `Fournisseur`, `Sans_Solde` |
| `.src/Gestion/Lcr/Attribution.class` | `<type>`, `Avec_Solde`, `Client` |
| `.src/Gestion/Lcr/Lcr.class` | `<type>`, `Avec_Solde`, `Client` |
| `.src/Gestion/Lcr/Preparation.class` | `<type>`, `Avec_Solde`, `Client` |
| `.src/Gestion/Reglements/TresorFac.class` | `<type>`, `Avec_Solde`, `Client` |
| `.src/Gestion/Stock/ValidBR.class` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `.src/Gestion/Stockmvt.class` | `<type>`, `Client`, `Fournisseur`, `Sans_Solde` |
| `.src/Gestion/SupprArt.class` | `<type>`, `Sans_Solde` |
| `.src/Gestion/Tables/FClient.class` | `<type>`, `Sans_Solde` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>`, `Sans_Solde` |
| `.src/Gestion/Tables/Materiel.class` | `<type>`, `Client`, `Sans_Solde` |
| `.src/Gestion/Tables/Mreglement.class` | `<type>`, `Bilan`, `Sans_Solde` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<type>`, `Client`, `Sans_Solde` |
| `.src/Gestion/option/Saisiedecons.class` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `.src/Gestion/option/Tregie.class` | `<type>`, `Bilan`, `Sans_Solde` |
| `.src/Statistiques/Histocliart.class` | `<type>`, `Client`, `Fournisseur`, `Sans_Solde` |
| `.src/Utils/Changefour.class` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `.src/Utils/LGed.class` | `<type>`, `Avec_Solde`, `Client`, `Fournisseur`, `Tous` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `ObjProp` | `<type>`, `AddChamp`, `tri` |
| `TriGen` | `<type>`, `ExtraSel`, `Show` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_AdrlivC`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_ContactC`, `Fiches_ContactF`, `Fiches_Four`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants (`New TriCpt(…)`, 62 appels dans 41 fichiers)** : `Abont:572`, `Attribution:603`,
  `Balance:574, 576, 591, 593`, `Caisse:2617, 4467, 7152`, `Changefour:172, 189, 207`,
  `commande1:1019`, `EdImpayes:260, 276`, `EdMat:71`, `EdNjustifiees:207, 223`,
  `EdNlettrees:319, 335`, `EdRup:83, 100`, `Edart4:67, 79, 91`, `Editcompte:630, 646`,
  `EditcompteA:538, 554`, `Extrait:302`, `FClient:1791`, `FComptes:854`, `FFournisseur:1649`,
  `Facture:6400, 10945`, `Facturefm:665`, `FacturefmA:524`, `GesTar:239`, `Histocliart:159, 174,
  215`, `LGed:658`, `Lcr:478`, `Lettrage:197`, `Materiel:2528`, `Mreglement:296`,
  `Plancomptable:49, 62`, `Pointage:495`, `Preparation:725`, `SaiReg:777`, `Saisecrit:295`,
  `Saisiedecons:170`, `Stockmvt:900, 912`, `SupprArt:162, 178`, `TarTypeCli:69`, `Tregie:416`,
  `Tresor:386`, `TresorFac:191`, `ValidBR:543`. Tous passent `Me`.
- **`Bsel`/`Bval` des appelants** : écrits par `Object.SetProperty` (l. 112-113), non vus par
  `deps.py` ; présents et `Public` dans 40 fichiers. **Exception** : `TresorFac` n'a ni `Bsel` ni
  `Bval` et lit `Comptabilite.Bsel`/`sCmpt` (TRESORFAC-A02 : erreur à la sélection).
- **Remise à zéro absente** : comme `TriCpt` ne remet pas `Bsel` à `False`, les appelants qui ne
  le font pas eux-mêmes réappliquent une ancienne sélection après annulation : `Materiel`
  (MATERIEL-A09), `FFournisseur` (FFOURNISSEUR-A07) et, par le même motif, la plupart des 41
  appelants (à vérifier un par un en phase 3 ; `Facture:4414` remet `Variables.Bsel`, sans effet
  sur `Facture.Bsel`).
- **Dépendance au nom de l'appelant** : `tricond` teste `$obj.Name = "Lettrage"` (filtre
  `lettrable`) : renommer `Lettrage` change le comportement.
- **Entrants dynamiques** : `TriGen` écrit `TriCpt.Bsel`/`Bval` et lève `ColTri_MajSel`/
  `ColTri_ReDim` (handlers reliés par `As "ColTri"`) : à garder `Public`.
- **Tables en dur** (pas de `Cbase.Table`) : `Fiches_Comptes`, `Fiches_Cli`, `Fiches_Four`,
  `Fiches_AdrlivC`, `Fiches_ContactC`, `Fiches_ContactF`.
- **Signaux `deps.py`** : aucun `unused`, `unused_transitive`, `arity_errors`, `replay_dynamic`,
  `replay_missing`, `scope_reducible`. Le contrôle `treso` (jamais visible) rend `treso_Click`
  inatteignable, ce que l'outil ne détecte pas (limite connue : contrôle invisible).
- **Ordre de rework** : après `TriGen` ; TRICPT-A01 (remise à zéro) est à traiter avec
  MATERIEL-A09 et FFOURNISSEUR-A07.
