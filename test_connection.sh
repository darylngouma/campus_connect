#!/bin/bash

echo "=== TEST DE CONNEXION BACKEND-FRONTEND ==="
echo ""

echo "1. Test de connexion au serveur Django..."
if curl -s http://127.0.0.1:8000/api/ > /dev/null 2>&1; then
    echo "✅ Serveur Django accessible sur http://127.0.0.1:8000"
else
    echo "❌ Serveur Django NON accessible sur http://127.0.0.1:8000"
    echo "   Le serveur Django doit être démarré"
    exit 1
fi

echo ""
echo "2. Test de CORS..."
CORS_RESPONSE=$(curl -s -X OPTIONS http://127.0.0.1:8000/api/modules/ \
  -H "Origin: http://localhost:5000" \
  -H "Access-Control-Request-Method: POST" \
  -v 2>&1 | grep -i "access-control-allow-origin")

if [ -n "$CORS_RESPONSE" ]; then
    echo "✅ CORS configuré correctement"
    echo "   $CORS_RESPONSE"
else
    echo "❌ CORS peut ne pas être configuré correctement"
fi

echo ""
echo "3. Test de l'URL de base du frontend..."
echo "   Frontend utilise: http://localhost:8000/api/"
echo "   (Vérifier dans app_constants.dart)"

echo ""
echo "4. Test d'une requête simple..."
RESPONSE=$(curl -s -X GET http://127.0.0.1:8000/api/modules/ \
  -H "Content-Type: application/json" 2>&1)
STATUS_CODE=$(echo "$RESPONSE" | grep -oP 'HTTP/\d\.\d \K\d+' || echo "Erreur de connexion")

if [ "$STATUS_CODE" = "401" ]; then
    echo "✅ Serveur répond (401 = authentification requise, c'est normal)"
elif [ "$STATUS_CODE" = "200" ]; then
    echo "✅ Serveur répond (200 = OK)"
else
    echo "❌ Erreur: Code de statut $STATUS_CODE"
    echo "   Réponse: $RESPONSE"
fi

echo ""
echo "=== RÉSUMÉ ==="
echo "Pour que la communication fonctionne:"
echo "1. Le serveur Django doit être démarré: cd campusconnect_backend && source ../venv/bin/activate && python manage.py runserver"
echo "2. CORS doit être configuré dans settings.py (déjà fait)"
echo "3. L'URL dans app_constants.dart doit correspondre (http://localhost:8000/api/)"

