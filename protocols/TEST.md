# Advanced Testing & QA Protocol

Standard de qualité pour la validation des flux distribués.

## 1. Couverture Technique
Tests attendus pour chaque nouvelle feature :
- **Unit** : Logique métier pure (ex: calcul du jitter).
- **Integration** : Communications Redis Streams et API NestJS.
- **E2E** : Flux d'onboarding et Handshake Magique sur le Dashboard.

## 2. Simulation "Shadow"
- Tester les retries Redis et les acquittements (ACK).
- Simuler des échecs de Shadow Workers pour vérifier la résilience du Cerveau.

## 3. Protocole de Rapport
L'IA doit fournir un statut de test :
- "Tests passés : [X/Y]"
- "Couverture critique : [OUI/NON]"
- "Tests de régression effectués : [OUI/NON]"
