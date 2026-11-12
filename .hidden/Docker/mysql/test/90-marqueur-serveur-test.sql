-- Marqueur du serveur de test (tests de non-régression, phase 2) : compte verrouillé, aucune connexion possible,
-- invisible pour Laurux. Seul un serveur marqué voit ses bases autres que Laurux01 supprimées avant chaque test
-- (TestKit.NettoieBases, runner.py nettoie_bases). Monté uniquement par docker-compose.test.yml, exécuté à chaque
-- initialisation du conteneur de test (données en tmpfs : y compris quand compose recrée le conteneur) ; jamais
-- dans l'image applicative.
CREATE USER IF NOT EXISTS 'laurux_serveur_test'@'localhost' ACCOUNT LOCK;
