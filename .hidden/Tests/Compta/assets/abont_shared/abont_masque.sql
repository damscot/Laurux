-- Abont (ABONT-T03 à T06) : un masque d'achat (numéro 1) et ses 3 lignes.
INSERT INTO Fiches_Numabon (numero, intitule, type, typem, compteur) VALUES (1, 'Masque test', 'A', '1', 0);
INSERT INTO Fiches_Ligabon (numero, compte, intitule, debit, credit, lig, lind, libelle, numDoc, numLot) VALUES
 ('1', '607000', 'Achats marchandises', '$montant', '0,00', 1, 1, 'Achat', '', ''),
 ('1', '445660', 'Tva sur achat 2.10', '($montant * 0.2)', '0,00', 2, 2, 'Achat', '', ''),
 ('1', '401001', 'Fournisseur', '0,00', '($montant * 1.2)', 3, 3, 'Achat', '', '');
