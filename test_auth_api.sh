#!/bin/bash

echo "=== TEST DE CRÉATION AVEC TOKEN ==="
echo ""

# Essayer de récupérer un token (connexion)
echo "1. Test de connexion..."
LOGIN_RESPONSE=$(curl -s -X POST http://127.0.0.1:8000/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}' 2>&1)

if echo "$LOGIN_RESPONSE" | grep -q "access"; then
    echo "✅ Connexion réussie"
    ACCESS_TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"access":"[^"]*' | cut -d'"' -f4)
    echo "   Token obtenu: ${ACCESS_TOKEN:0:20}..."
else
    echo "❌ Échec de connexion (utilisez un compte existant)"
    echo "   Réponse: $LOGIN_RESPONSE"
    echo ""
    echo "2. Test de création de module (sans token pour voir l'erreur)..."
    curl -s -X POST http://127.0.0.1:8000/api/modules/ \
      -H "Content-Type: application/json" \
      -d '{"code":"TEST001","name":"Test Module","credits":3}' | python3 -m json.tool 2>/dev/null || echo "Erreur"
    exit 0
fi

echo ""
echo "2. Test de création de module avec token..."
MODULE_RESPONSE=$(curl -s -X POST http://127.0.0.1:8000/api/modules/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -d '{"code":"TEST001","name":"Test Module","credits":3,"is_active":true}' 2>&1)

if echo "$MODULE_RESPONSE" | grep -q "id\|code\|name"; then
    echo "✅ Module créé avec succès"
    echo "$MODULE_RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$MODULE_RESPONSE"
else
    echo "❌ Erreur lors de la création"
    echo "$MODULE_RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$MODULE_RESPONSE"
fi
