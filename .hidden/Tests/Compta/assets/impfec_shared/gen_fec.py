#!/usr/bin/env python3
"""Fichiers FEC (18 colonnes, 1re ligne d'en-tête ignorée) pour les scénarios IMPFEC-Tnn.
Usage, depuis ce répertoire : python3 gen_fec.py (écrit <jeu>.txt pour chaque jeu ci-dessous)."""
ENTETE = ["JournalCode", "JournalLib", "EcritureNum", "EcritureDate", "CompteNum", "CompteLib", "CompAuxNum",
          "CompAuxLib", "PieceRef", "PieceDate", "EcritureLib", "Debit", "Credit", "EcritureLet", "DateLet",
          "ValidDate", "Montantdevise", "Idevise"]

def l(jo, num, dte, cpt, lib, aux, piece, libe, d, c, let=""):
    return [jo, "Journal " + jo, num, dte, cpt, lib, aux, "", piece, dte, libe, d, c, let, "", dte, "", ""]

NOMINAL = [
    l("70", "101", "20180310", "707000", "Ventes", "", "F101", "Facture F101", "0", "100"),
    l("70", "101", "20180310", "445710", "TVA", "", "F101", "Facture F101", "0", "20"),
    l("70", "101", "20180310", "411001", "A Divers", "", "F101", "Facture F101", "120", "0", "AA"),
    l("60", "102", "20180312", "606100", "Fournitures", "", "A102", "Achat A102", "50", "0"),
    l("60", "102", "20180312", "401001", "A Divers", "", "A102", "Achat A102", "0", "50"),
    l("50", "103", "20180315", "512000", "Banque", "", "R103", "Reglement F101", "120", "0"),
    l("50", "103", "20180315", "411001", "A Divers", "", "R103", "Reglement F101", "0", "120", "AA"),
]
# Contrôle bloquant : journal inconnu, compte inconnu, numéro non numérique (avec Renuméroter décoché)
BLOQUANT = [
    l("ZZ", "201", "20180310", "707000", "Ventes", "", "F201", "Journal inconnu", "0", "10"),
    l("70", "202", "20180310", "999999", "Inconnu", "", "F202", "Compte inconnu", "10", "0"),
    l("70", "X03", "20180310", "707000", "Ventes", "", "F203", "Numero non numerique", "0", "5"),
]
# Comptes auxiliaires : court (complété à Textcrt), trop long, non numérique
AUX = [
    l("70", "301", "20180310", "411000", "Clients", "1", "F301", "Aux court", "10", "0"),
    l("70", "301", "20180310", "707000", "Ventes", "", "F301", "Aux court", "0", "10"),
    l("70", "302", "20180311", "411000", "Clients", "123456", "F302", "Aux trop long", "20", "0"),
    l("70", "302", "20180311", "707000", "Ventes", "", "F302", "Aux trop long", "0", "20"),
    l("VT", "303", "20180312", "411000", "Clients", "AB1", "F303", "Aux non numerique", "30", "0"),
    l("VT", "303", "20180312", "707000", "Ventes", "", "F303", "Aux non numerique", "0", "30"),
]
# Erreur en cours d'import : date invalide après des lignes valides
ERREUR = NOMINAL[:3] + [l("60", "104", "20231399", "606100", "Fournitures", "", "A104", "Date invalide", "5", "0"),
                        l("60", "104", "20231399", "401001", "A Divers", "", "A104", "Date invalide", "0", "5")]

def ecrit(nom, lignes, sep="\t", eol="\r\n"):
    with open(nom, "w", newline="") as f:
        f.write(eol.join(sep.join(x) for x in [ENTETE] + lignes) + eol)

ecrit("fec_nominal_tab.txt", NOMINAL)
ecrit("fec_nominal_pipe.txt", NOMINAL, "|")
ecrit("fec_nominal_pv.txt", NOMINAL, ";")
ecrit("fec_nominal_virg.txt", NOMINAL, ",")
ecrit("fec_nominal_lf.txt", NOMINAL, "\t", "\n")
ecrit("fec_bloquant.txt", BLOQUANT)
ecrit("fec_aux.txt", AUX)
ecrit("fec_erreur.txt", ERREUR)
