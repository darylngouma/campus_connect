#!/bin/bash
# Script pour afficher les logs Django en temps réel

echo "=== LOGS DU SERVEUR DJANGO ==="
echo "Appuyez sur Ctrl+C pour arrêter"
echo ""

# Chercher le processus Django
DJANGO_PID=$(ps aux | grep "python.*manage.py runserver" | grep -v grep | awk '{print $2}' | head -1)

if [ -z "$DJANGO_PID" ]; then
    echo "Aucun serveur Django trouvé en cours d'exécution"
    exit 1
fi

echo "Serveur Django trouvé (PID: $DJANGO_PID)"
echo ""
echo "Les logs du serveur Django devraient apparaître ci-dessous..."
echo "Pour voir les erreurs, essayez de créer un module/note/annonce dans l'application Flutter"
echo ""
echo "---"

# Pour voir les logs, on ne peut pas vraiment intercepter stdout/stderr d'un processus existant
# Mais on peut vérifier les dernières requêtes en regardant ce qui a été envoyé
echo "Pour voir les erreurs en temps réel, vous pouvez :"
echo "1. Aller dans le terminal où Django tourne"
echo "2. Ou vérifier les erreurs dans la console du navigateur (F12)"
echo ""
echo "Testons une requête simple pour voir les logs..."

