-- Jeu TRESOR-T10 (agent 5, vague 7) : masque d'abonnement de trésorerie (type T, saisie au montant) numéro 2,
-- trois lignes dont les montants sont des expressions LVar de $montant.
INSERT INTO Fiches_Numabon (numero, intitule, type, typem, compteur) VALUES (2, 'Prelevement mensuel', 'T', '1', 4);
INSERT INTO Fiches_Ligabon (numero, compte, intitule, debit, credit, lig, lind, libelle, numDoc, numLot) VALUES
 ('2', '512000', 'Banque', '0,00', '$montant', 1, 11, 'Prelevement', NULL, NULL),
 ('2', '606100', 'Achats', '($montant / 1.2)', '0,00', 2, 12, 'Prelevement', NULL, NULL),
 ('2', '445660', 'Tva sur achat 2.10', '($montant - $montant / 1.2)', '0,00', 3, 13, 'Prelevement', NULL, NULL);
