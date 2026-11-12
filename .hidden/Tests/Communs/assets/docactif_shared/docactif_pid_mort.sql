-- DocActif (DOCACTIF-T05) : déclencheur sur Fiches_Parametres (UPdate fait par Parametre.Button2_Click à la
-- fermeture, avant Free_Lock) qui, une seule fois par connexion (@docactif_fait), remplace le process_id du verrou Parametres/0 par 999999 (PID inexistant).
-- Simule ainsi, avec l'identité réelle du conteneur, un verrou du même poste pris par un autre process.
DELIMITER //
CREATE TRIGGER test_docactif_pid_mort AFTER UPDATE ON Fiches_Parametres FOR EACH ROW
BEGIN
  IF @docactif_fait IS NULL THEN
    SET @docactif_fait = 1;
    UPDATE Fiches_Docactif SET process_id = 999999 WHERE doc_type = 'Parametres' AND doc_num = '0';
  END IF;
END//
DELIMITER ;
