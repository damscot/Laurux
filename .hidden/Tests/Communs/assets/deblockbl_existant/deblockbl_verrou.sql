-- Deblockbl (DEBLOCKBL-T02) : un BL existant et son verrou dans Fiches_Docactif (identité « autre » fixe).
INSERT INTO Fiches_Bl (numbl, type, datebl) VALUES ('000123', 'B', '2026-01-10 10:00:00');
INSERT INTO Fiches_Docactif (doc_type, doc_num, user_name, process_id, machine_id, host_id, userdb_name)
  VALUES ('Bl', '000123', 'autre', 4242, 'machine-autre', 'hote-autre', 'laurux');
