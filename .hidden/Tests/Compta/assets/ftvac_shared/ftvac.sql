-- FTvac (FTVAC-T02, T03) : le compte 604000 utilise aussi le code TVA achats 2 (code_tachat) ; code 4
-- ajouté, utilisé par aucun compte (les codes 1 à 3 de Laurux01 sont tous utilisés).
UPDATE Fiches_Comptes SET code_tachat = '2', taux_tachat = '5.50', gen_ta = 1 WHERE compte_cc = 604000;
INSERT INTO Fiches_Tvaac (code_tva, taux_tva, cc_tva) VALUES ('4', '10.00', '445660');
