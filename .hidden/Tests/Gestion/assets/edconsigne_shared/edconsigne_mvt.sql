-- Jeu Edconsigne : tables de l'option boisson (structure de consigne_shared/consigne_base) et mouvements de consigne
-- sur une réception de 2 lignes (R1, fournisseur 401001), une réception d'un fournisseur inconnu (R2, 401999),
-- un BL de 2 lignes (BL0001, client 411001), une facture historisée F00001 (client 411999 inconnu) reprise par le
-- BL BL0002 (numfac). Les codes de consigne 1 à 4 coïncident avec les identifiants Fiches_ligcons.code (A01) ;
-- les documents de plusieurs lignes figent la multiplication des mouvements (A02).
CREATE TABLE Fiches_consigne (code char(2), libelle varchar(30), prix decimal(6,2), type char(1), PRIMARY KEY (code));
CREATE TABLE Fiches_ligcons (num char(15), numlig char(12), type char(1), codecons char(2), nb int, montant decimal(8,2), envaleur boolean, bloc varchar(33), code integer NOT NULL AUTO_INCREMENT, PRIMARY KEY (code));
INSERT INTO Fiches_consigne (code, libelle, prix, type) VALUES ('1', 'Palette', 10.00, 'P'), ('2', 'Casier', 1.50, 'C'), ('3', 'Bouteille', 0.20, 'B'), ('4', 'Fut', 10.00, 'F'), ('P1', 'Palette ancienne', 10.00, 'P');
INSERT INTO Fiches_ligcons (code, num, numlig, type, codecons, nb, montant, envaleur, bloc) VALUES
(1, 'R1', '001', 'E', '1', 2, 20.00, 1, ''),
(2, 'BL0001', '001', 'L', '2', -3, -4.50, 1, ''),
(3, 'F00001', '001', 'F', '3', 5, 1.00, 1, ''),
(4, 'R2', '001', 'E', '4', 1, 10.00, 1, '');
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate) VALUES ('401001', 'R1', '2018-03-10 00:00:00'), ('401999', 'R2', '2018-02-01 00:00:00');
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, nligne) VALUES ('ART1', 'R1', '401001', '2018-03-10 00:00:00', '1'), ('ART2', 'R1', '401001', '2018-03-10 00:00:00', '2'), ('ART1', 'R2', '401999', '2018-02-01 00:00:00', '1');
INSERT INTO Fiches_Bl (numbl, cdclibl, numfac) VALUES ('BL0001', '411001', NULL), ('BL0002', '411999', 'F00001');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, dte_ligbl) VALUES ('BL0001', '1', '2018-04-05 00:00:00'), ('BL0001', '2', '2018-04-05 00:00:00'), ('BL0002', '1', '2018-05-02 00:00:00');
INSERT INTO Fiches_HistoFac (numfac, cdclifac) VALUES ('F00001', '411999');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, dtligbl_ligfac) VALUES ('F00001', '1', '2018-05-02 00:00:00');
