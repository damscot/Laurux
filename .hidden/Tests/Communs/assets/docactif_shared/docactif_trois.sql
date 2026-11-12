-- DocActif (DOCACTIF-T10) : trois verrous de documents d'autres postes pour la fenêtre d'administration
INSERT INTO Fiches_Docactif (doc_type, doc_num, user_name, process_id, machine_id, host_id, userdb_name) VALUES
 ('Facturation', '1001', 'alice', 1111, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'poste-a(0a0a0a0a)', 'login_a'),
 ('Parametres', '0', 'bruno', 2222, 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 'poste-b(0b0b0b0b)', 'login_b'),
 ('Reglement', '57', 'carla', 3333, 'cccccccccccccccccccccccccccccccc', 'poste-c(0c0c0c0c)', 'login_c');
