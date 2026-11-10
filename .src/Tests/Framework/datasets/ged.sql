-- Jeu de données LGED-T02 à T09 : documents GED et tags (tables vides dans Laurux01.sql).
-- 4 documents (1 Clients, 2 Fournisseurs, 3 Comptabilité, 4 Autres sans tag pour EpurationDocs),
-- 5 tags (« urgent » partagé par les documents 1 et 2, « orphelin » sans document) et une ligne
-- Docs_Tag pendante (document 99 inexistant, tag « compta ») pour l'anomalie LGED-A03.
INSERT INTO Docs_Ged (lind, type, code, compte, origin, url, filename, mime, date, ttc, ht) VALUES
  (1, 0, 'FA000001', '411001', 'Facture', 'file:///ged/clients/FA000001.pdf', 'FA000001.pdf', 'application/pdf', '2020-03-12 10:00:00', 120.00, 100.00),
  (2, 1, 'BR000002', '401001', 'BR', '/ged/fournisseurs/BR000002.pdf', 'BR000002.pdf', 'application/pdf', '2020-04-01 09:30:00', 60.00, 50.00),
  (3, 2, '125', '607000', 'Facture', 'http://exemple.invalid/doc3.pdf', 'doc3.pdf', 'application/pdf', '2020-05-20 14:15:00', 36.00, 30.00),
  (4, 3, 'NOTE', '', 'Docs', '/ged/autres/note.txt', 'note.txt', 'text/plain', '2020-06-30 18:00:00', 0.00, 0.00);
INSERT INTO Fiches_Tag (lind, tag) VALUES (1, 'urgent'), (2, 'client'), (3, 'fournisseur'), (4, 'compta'), (5, 'orphelin');
INSERT INTO Docs_Tag (doc_lind, tag_lind) VALUES (1, 1), (1, 2), (2, 1), (2, 3), (3, 4), (99, 4);
