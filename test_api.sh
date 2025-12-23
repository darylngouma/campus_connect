#!/bin/bash

echo "=== TEST DES ENDPOINTS API ==="
echo ""

# Récupérer un token valide (vous devez être connecté)
echo "1. Test de connexion pour obtenir un token..."
echo "   (Vous devez d'abord vous connecter dans l'app Flutter)"
echo ""

# Test de création de module sans token (doit échouer)
echo "2. Test de création de module sans authentification:"
curl -X POST http://127.0.0.1:8000/api/modules/ \
  -H "Content-Type: application/json" \
  -d '{"code":"TEST001","name":"Test Module","credits":3}' \
  2>&1 | python3 -m json.tool 2>/dev/null || echo "Erreur de parsing JSON"
echo ""
echo ""

# Instructions
echo "=== INSTRUCTIONS ==="
echo "Pour voir les erreurs en temps réel:"
echo ""
echo "1. Ouvrez un nouveau terminal"
echo "2. Exécutez: cd /Users/7maksacodpc/campusconnect/campusconnect_backend"
echo "3. Exécutez: source ../venv/bin/activate"
echo "4. Exécutez: python manage.py runserver"
echo ""
echo "Les erreurs apparaîtront directement dans ce terminal."
echo ""
echo "Ou bien:"
echo "- Ouvrez la console du navigateur (F12 > Console)"
echo "- Essayez de créer un module/note/annonce"
echo "- Les erreurs détaillées s'afficheront dans la console"

