# Générateur des jeux ecarts_shared/*.sql (inventaire de fin d'exercice) et ecartst_shared/*.sql (tournant), et des
# scénarios des éditions d'inventaire : ECARTS, EDNSAISIS, EDINV, RAZINV et leurs variantes tournantes (T).
# Usage : python3 gen_editions_inv.py (conserve la cadence des meta.json existants), puis runner retime <scénarios>,
# runner harness apply et replay --expected.
import json, os
A = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # .hidden/Tests/Gestion/assets

ARTS = """-- Articles 001 à 003 de Laurux01 : stockés, stocks connus.
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_stkdep = 10 WHERE art_code IN ('001', '002', '003');
"""
DECS = """-- Décimales : 001 art_dec 0 / art_nbd 0, 002 art_dec 2 / art_nbd 2, 003 art_dec 3 / art_nbd 3 ; PA à 3 décimales.
UPDATE Fiches_Art SET art_dec = '0', art_nbd = '0', art_paht = 1.235, art_pmp = 1.115 WHERE art_code = '001';
UPDATE Fiches_Art SET art_dec = '2', art_nbd = '2', art_paht = 2.505, art_pmp = 2.345 WHERE art_code = '002';
UPDATE Fiches_Art SET art_dec = '3', art_nbd = '3', art_paht = 0.333, art_pmp = 0.667 WHERE art_code = '003';
"""
CREATE_F = """-- Structure de Fiches_Inv : Geninv.class (CREATE TABLE, l. 94-104).
DROP TABLE IF EXISTS Fiches_Inv;
CREATE TABLE Fiches_Inv (inv_nlig char(9) NOT NULL, inv_code Char(15), inv_qtestock Decimal(12,2),
  inv_qtecomptee Decimal(12,2), inv_date date, inv_comptee TINYINT, inv_valid Integer,
  inv_design VARCHAR(50), inv_casier Char(8), PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
"""
CREATE_T = """-- Structure de Fiches_InvT : GeninvT.class.
DROP TABLE IF EXISTS Fiches_InvT;
CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
"""
DESIGN = {'001': 'Produit 2.10', '002': 'Produit 7.00', '003': 'produit 20.00', '999': 'Article supprime'}

def lignes(rows, table, dte):
    # rows : (code, qtestock, qtecomptee, comptee)
    v = ",\n".join("('%d', '%s', %s, %s, '%s', %d, '%s', '')" % (i + 1, c, s, q, dte, k, DESIGN[c])
                   for i, (c, s, q, k) in enumerate(rows))
    return ("INSERT INTO %s (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design,"
            " inv_casier) VALUES\n%s;\n" % (table, v))

PAG = []  # 60 lignes comptées (écarts variés) puis 60 non comptées
for i in range(60):
    c = ('001', '002', '003')[i % 3]
    PAG.append((c, 10, 10 + (i % 7) - 3, 1))
for i in range(60):
    c = ('001', '002', '003')[i % 3]
    PAG.append((c, 5 + i % 4, 0, 0))

JEUX = {
    'non_compte': ("Inventaire généré sans saisie : 3 lignes non comptées.", "",
                   [('001', 10, 0, 0), ('002', 10, 0, 0), ('003', 10, 0, 0)]),
    'pagination': ("120 lignes : 60 comptées (écarts -3 à +3) puis 60 non comptées (stocks 5 à 8) : deux pages par édition.",
                   "", PAG),
    'compte_supprime': ("Ligne 2 comptée portant l'article supprimé 999 (lignes 1 et 3 comptées).", "",
                        [('001', 10, 12, 1), ('999', 4, 6, 1), ('003', 10, 9, 1)]),
    'non_compte_supprime': ("Ligne 2 non comptée portant l'article supprimé 999 (lignes 1 et 3 non comptées).", "",
                            [('001', 10, 0, 0), ('999', 4, 0, 0), ('003', 10, 0, 0)]),
    'decimales': ("Quantités décimales, art_dec/art_nbd 0/2/3, PA et PMP à 3 décimales : lignes 1-3 comptées, 4-6 non comptées.",
                  DECS, [('001', 10, 12, 1), ('002', 7.25, 5.5, 1), ('003', 3.12, 4.57, 1),
                         ('001', 4, 0, 0), ('002', 2.75, 0, 0), ('003', 1.33, 0, 0)]),
    'hors_famille': ("Article 002 compté dont la famille 99 n'existe pas dans Fiches_Fam (001, 002, 003 comptés).",
                     "UPDATE Fiches_Art SET art_fam = '99' WHERE art_code = '002';\n",
                     [('001', 10, 12, 1), ('002', 10, 7, 1), ('003', 10, 10, 1)]),
}

def ecrit_jeux():
    for rep, pre, create, table, dte in (('ecarts_shared', 'inv', CREATE_F, 'Fiches_Inv', '2018-06-10'),
                                         ('ecartst_shared', 'invt', CREATE_T, 'Fiches_InvT', '2018-06-01')):
        os.makedirs(A + '/' + rep, exist_ok=True)
        for nom, (desc, extra, rows) in JEUX.items():
            with open('%s/%s/%s_%s.sql' % (A, rep, pre, nom), 'w') as f:
                f.write("-- Jeu %s : %s\n-- Généré par ecarts_shared/gen_editions_inv.py.\n" % (rep, desc))
                f.write(ARTS + extra + create + lignes(rows, table, dte))

M = 'Fmenu#Menu66#Menu77#'
MENUS = {'Ecarts': ('Menu80', 'Menu83'), 'Ednsaisis': ('Menu80', 'Menu93'), 'EdinvF': ('Menu80', 'Menu85'),
         'RazInv': ('Menu80', 'Menu232'), 'EcartsT': ('Menu94', 'Menu98'), 'EdnsaisisT': ('Menu94', 'Menu97'),
         'EdinvT': ('Menu94', 'Menu99'), 'RazInvT': ('Menu94', 'Menu233')}
ENTREE = 'FMessage.FMessage_KeyPress;Keypress=16777220@FMessage#FMessage#'
TAB = 'FMessage.FMessage_KeyPress;Keypress=16777217@FMessage#FMessage#'
ESPACE = 'FMessage.FMessage_KeyPress;Keypress= @FMessage#FMessage#'

def menu(cle):
    p, m = MENUS[cle]
    return 'Fmenu.%s_Click;Click=True@%s#%s%s#%s#' % (m, m, M, p, m)

def bouton(fen, b='Button1'):
    return '%s.%s_Click;Click=True@%s#%s#%s#' % (fen, b, b, fen, b)

PDF = {"/Soc01/caisse/CmdVis": "sh -c 'pdftotext -layout \"$0\" {home}/edition.txt'"}

def scen(nom, tid, classe, objet, desc, dataset, evts, pdf=True, code=0, lecture=True):
    d = A + '/' + nom
    os.makedirs(d, exist_ok=True)
    meta = {"id": tid, "classe": classe, "objet": objet, "description": desc, "dataset": dataset,
            "date": "2018-06-15 10:00:00", "args": [], "societe": "01", "timeout": 20}
    if pdf:
        meta["conf"] = PDF
        meta["fichiers"] = ["edition.txt"]
    if lecture and code == 0:
        meta["compare_sql_log"] = "ordered"
    if code:
        meta["code_sortie"] = code
    try:
        old = json.load(open(d + '/meta.json'))
        if 'cadence' in old:
            meta['cadence'] = old['cadence']
    except Exception:
        pass
    json.dump(meta, open(d + '/meta.json', 'w'), ensure_ascii=False, indent=1)
    with open(d + '/scenario.log', 'w') as f:
        for i, e in enumerate(evts):
            f.write('06/15/2018 10:00:%02d.000;Info;GUI;laurux;test;test;1;%s\n' % (4 + i, e))

def ecrit_scenarios():
    for T in ('', 'T'):
        E, N, R = 'Ecarts' + T, 'Ednsaisis' + T, 'RazInv' + T
        e, n, r = E.lower(), N.lower(), R.lower()
        sh = 'ecartst_shared/invt_' if T else 'ecarts_shared/inv_'
        vs = 'validinvt_shared/invt_' if T else 'validinv_shared/inv_fin_'
        part = vs + 'partiel'
        cpt = vs + 'compte'
        absent = 'validinvt_shared/invt_absent' if T else None
        ID = E.upper()
        nature = "tournant" if T else "de fin d'exercice"
        scen(e + '_edition', ID + '-T01', E, 'Édition nominale des écarts',
             "Jeu %s (lignes comptées +, 0, - et non comptées) ; Imprimer. Attendu : texte du PDF avec les seules lignes comptées, écarts, valeurs PA/PMP et totaux ; dump inchangé." % part,
             part, [menu(E), bouton(E)])
        scen(e + '_aucune_ligne', ID + '-T02', E, 'Aucune ligne comptée',
             "Jeu %snon_compte (inventaire généré sans saisie) ; Imprimer. Attendu : message « Aucun article pour cette demande » (Entrée) ; aucun PDF." % sh,
             sh + 'non_compte', [menu(E), bouton(E), ENTREE])
        scen(e + '_sans_inventaire', ID + '-T03', E, 'Sans inventaire',
             ("Base sans table Fiches_InvT ; ouverture par le menu. Attendu : erreur non gérée « Null object » à l'ouverture (EcartsT._New : rResult.Available évalué sur un Result nul, figé A01 ; code 125)." if T else "Base sans table Fiches_Inv ; ouverture par le menu. Attendu : Message.Warning « aucun inventaire » (Entrée) puis fermeture de l'écran."),
             absent, [menu(E)] if T else [menu(E), ENTREE], pdf=False, code=125 if T else 0)
        scen(e + '_pagination', ID + '-T04', E, 'Pagination',
             "Jeu %spagination (60 lignes comptées) ; Imprimer. Attendu : texte du PDF sur 2 pages, en-têtes répétés." % sh,
             sh + 'pagination', [menu(E), bouton(E)])
        scen(e + '_article_supprime', ID + '-T05', E, 'Article supprimé',
             "Jeu %scompte_supprime (ligne comptée portant l'article 999 absent de Fiches_Art) ; Imprimer. Attendu : erreur non gérée sur rarts!art_design (code 125, comportement actuel figé)." % sh,
             sh + 'compte_supprime', [menu(E), bouton(E)], code=125)
        scen(e + '_decimales', ID + '-T06', E, 'Quantités décimales',
             "Jeu %sdecimales (art_dec 0/2/3, PA et PMP à 3 décimales, quantités décimales) ; Imprimer. Attendu : valeurs PA/PMP arrondies à 2 décimales dans le texte du PDF." % sh,
             sh + 'decimales', [menu(E), bouton(E)])
        ID = N.upper()
        scen(n + '_edition', ID + '-T01', N, 'Édition nominale des non saisis',
             "Jeu %s (lignes comptées et non comptées) ; Imprimer. Attendu : texte du PDF avec les seules lignes non comptées, valeurs PA/PMP, totaux." % part,
             part, [menu(N), bouton(N)])
        scen(n + '_aucune_ligne', ID + '-T02', N, 'Tout compté',
             "Jeu %s (inventaire entièrement compté) ; Imprimer. Attendu : message « Aucun article pour cette demande » (Entrée)." % cpt,
             cpt, [menu(N), bouton(N), ENTREE])
        scen(n + '_sans_inventaire', ID + '-T03', N, 'Sans inventaire',
             ("Base sans table Fiches_InvT ; ouverture par le menu. Attendu : erreur non gérée « Null object » à l'ouverture (EdnsaisisT._New.46, figé A01 ; code 125)." if T else "Base sans table Fiches_Inv ; ouverture par le menu. Attendu : Message.Warning « aucun inventaire » (Entrée) puis fermeture."),
             absent, [menu(N)] if T else [menu(N), ENTREE], pdf=False, code=125 if T else 0)
        scen(n + '_pagination', ID + '-T04', N, 'Pagination',
             "Jeu %spagination (60 lignes non comptées) ; Imprimer. Attendu : texte du PDF sur 2 pages." % sh,
             sh + 'pagination', [menu(N), bouton(N)])
        scen(n + '_decimales', ID + '-T05', N, 'Décimales et alignement',
             "Jeu %sdecimales (art_dec 0/2/3, stocks décimaux) ; Imprimer. Attendu : valorisation des lignes non comptées (effet des espaces de remplissage figé)." % sh,
             sh + 'decimales', [menu(N), bouton(N)])
        scen(n + '_article_supprime', ID + '-T06', N, 'Article supprimé',
             "Jeu %snon_compte_supprime (ligne non comptée portant l'article 999 absent de Fiches_Art) ; Imprimer. Attendu : erreur non gérée (code 125, figé)." % sh,
             sh + 'non_compte_supprime', [menu(N), bouton(N)], code=125)
        ID = R.upper()
        histo = 'validinvt_shared/invt_histo' if T else part
        scen(r + '_raz_oui', ID + '-T01', R, 'Suppression confirmée',
             "Jeu %s ; Supprimer ; bouton 1 « Oui » de Message.Question (%s.class:18) ; Entrée sur « Inventaire effacé ! ». Attendu : %s absente du dump%s." % (histo, R, 'Fiches_InvT' if T else 'Fiches_Inv', ', Fiches_HisInvT inchangée' if T else ''),
             histo, [menu(R), bouton(R), ENTREE, ENTREE], pdf=False, lecture=False)
        scen(r + '_raz_non', ID + '-T02', R, 'Suppression refusée',
             "Jeu %s ; Supprimer ; bouton 2 « Non » de Message.Question (%s.class:18 : Tab puis Espace). Attendu : dump identique à l'entrée." % (histo, R),
             histo, [menu(R), bouton(R), TAB, ESPACE], pdf=False)
        scen(r + '_raz_absente', ID + '-T03', R, 'Table absente',
             "Base sans %s ; Supprimer ; « Oui » ; Entrée sur « Inventaire effacé ! ». Attendu : dump inchangé, message de succès (comportement actuel figé)." % ('Fiches_InvT' if T else 'Fiches_Inv'),
             absent, [menu(R), bouton(R), ENTREE, ENTREE], pdf=False, lecture=False)

def ecrit_edinv():
    F, T = menu('EdinvF'), menu('EdinvT')
    b = bouton('Edinv')
    def ed(nom, tid, objet, desc, dataset, evts, conf=None, pdf=True, code=0):
        scen('edinv_' + nom, tid, 'Edinv', objet, desc, dataset, evts, pdf=pdf, code=code)
        if conf:
            p = A + '/edinv_' + nom + '/meta.json'
            m = json.load(open(p))
            m.setdefault('conf', {}).update(conf)
            json.dump(m, open(p, 'w'), ensure_ascii=False, indent=1)
    ed('edition_fin', 'EDINV-T01', "Fin d'exercice, familles sur 2 niveaux",
       "Jeu validinv_shared/inv_fin_partiel ; /Soc01/ipr = [1,2] (familles 0 > 01, 02, 03) ; menu 85 ; Imprimer. Attendu : texte du PDF, lignes comptées par famille, sous-totaux remontés aux parents, total.",
       'validinv_shared/inv_fin_partiel', [F, b], conf={"/Soc01/ipr": [1, 2]})
    ed('edition_tournant', 'EDINV-T02', 'Inventaire tournant',
       "Jeu validinvt_shared/invt_partiel ; menu 99 ; Imprimer. Attendu : texte du PDF des lignes comptées de Fiches_InvT par famille, total.",
       'validinvt_shared/invt_partiel', [T, b])
    ed('sans_inventaire', 'EDINV-T03', 'Sans inventaire',
       "Jeu validinvt_shared/invt_absent (ni Fiches_Inv ni Fiches_InvT) ; menu 85 ; Entrée sur le Message.Warning « aucun inventaire ». Attendu : ed.Show après Me.Close dans _New lève « Invalid object » (Fmenu.Menu85_Click), comportement figé A02 (code 125) ; le chemin du menu 99 (Fmenu.Menu99_Click) est identique.",
       'validinvt_shared/invt_absent', [F, ENTREE], pdf=False, code=125)
    ed('hors_famille', 'EDINV-T04', 'Article hors arbre de familles',
       "Jeu ecarts_shared/inv_hors_famille (002 compté, famille 99 absente de Fiches_Fam) ; menu 85 ; Imprimer. Attendu : 002 absent de l'édition et du total (figé A01).",
       'ecarts_shared/inv_hors_famille', [F, b])
    ed('pagination', 'EDINV-T05', 'Pagination et en-têtes',
       "Jeu ecarts_shared/inv_pagination (60 lignes comptées) ; menu 85 ; Imprimer. Attendu : plusieurs pages, en-tête des pages suivantes Me.Text & date (figé A03).",
       'ecarts_shared/inv_pagination', [F, b])
    ed('decimales', 'EDINV-T06', 'Décimales',
       "Jeu ecarts_shared/inv_decimales (art_dec et art_nbd 0/2/3, PA à 3 décimales) ; menu 85 ; Imprimer. Attendu : formats et valeurs du texte du PDF.",
       'ecarts_shared/inv_decimales', [F, b])
    ed('vide', 'EDINV-T07', 'Aucune ligne comptée',
       "Jeu ecarts_shared/inv_non_compte (aucune ligne comptée) ; menu 85 ; Imprimer. Attendu : PDF avec totaux à zéro (cas « aucun article » commenté).",
       'ecarts_shared/inv_non_compte', [F, b])

if __name__ == '__main__':
    ecrit_jeux()
    ecrit_scenarios()
    ecrit_edinv()
