-- Jeu Banque : deux banques complètes (table Fiches_Banques vide dans Laurux01.sql).
INSERT INTO Fiches_Banques (banques_code, banques_nom, banques_dmln, banques_nume, banques_codeb, banques_codeg, banques_numcpt, banques_numsiren, banques_adr, banques_txt, banques_fenrg, banques_mail, banques_ref, banques_entete, banques_corps, banques_reftireur) VALUES
(1, 'BANQUE ALPHA', 'AGENCE CENTRE', '123456', '10001', '00011', '12345678901', '123456789', '1', 'Entete alpha', '', 'alpha@banque.test', 'REMALPHA', 'Objet alpha', 'Corps alpha', 'TIRALPHA'),
(2, 'CREDIT BETA', 'AGENCE NORD', '654321', '20002', '00022', '10987654321', '987654321', '2', 'Entete beta', '', 'beta@banque.test', 'REMBETA', 'Objet beta', 'Corps beta', 'TIRBETA');
