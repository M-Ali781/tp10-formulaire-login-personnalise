# TP 10 : Formulaire de connexion personnalisé - Spring Security

Ce projet implémente le **TP 10** du module *Développement JakartaEE : Spring* portant sur la configuration d'un formulaire de connexion personnalisé avec **Spring Security 6** et **Spring Boot 3**, la redirection automatique après connexion (`defaultSuccessUrl("/home", true)`), le traitement de l'authentification sur l'URL dédiée `/authenticate`, la gestion des erreurs et des déconnexions avec affichage conditionnel Thymeleaf, ainsi que le contrôle d'accès basé sur les rôles (`ROLE_USER`, `ROLE_ADMIN`).

---

## 1. Compilation Maven du projet Spring Boot

![1. Compilation Maven du projet Spring Boot (mvn clean compile)](screenshots/01_maven_clean_compile.png)

---

## 2. Exécution de la suite de tests automatisés MockMvc

![2. Exécution de la suite de tests automatisés MockMvc (mvn test)](screenshots/02_maven_test_suite.png)

---

## 3. Démarrage de l'application Spring Boot sur le port 8080

![3. Démarrage de l'application Spring Boot sur le port 8080](screenshots/03_application_startup.png)

---

## 4. Tentative d'accès non authentifié vers /home (Redirection 302 vers /login)

![4. Tentative d'accès non authentifié vers /home (Redirection 302 vers /login)](screenshots/04_unauth_access_redirect_login.png)

---

## 5. Affichage du formulaire de connexion personnalisé (GET /login)

![5. Affichage du formulaire de connexion personnalisé (GET /login)](screenshots/05_custom_login_form_view.png)

---

## 6. Échec d'authentification avec mauvais mot de passe (POST /authenticate)

![6. Échec d'authentification avec mauvais mot de passe (POST /authenticate)](screenshots/06_login_failure_bad_credentials.png)

---

## 7. Affichage du message d'erreur sur la page de connexion (GET /login?error=true)

![7. Affichage du message d'erreur sur la page de connexion (GET /login?error=true)](screenshots/07_login_error_display.png)

---

## 8. Authentification réussie pour l'utilisateur 'user' (user / 1111)

![8. Authentification réussie pour l'utilisateur 'user' (user / 1111)](screenshots/08_login_success_user.png)

---

## 9. Accès à la page d'accueil après connexion (GET /home)

![9. Accès à la page d'accueil après connexion (GET /home)](screenshots/09_home_page_authenticated.png)

---

## 10. Accès autorisé à l'Espace Utilisateur (/user/dashboard) pour ROLE_USER

![10. Accès autorisé à l'Espace Utilisateur (/user/dashboard) pour ROLE_USER](screenshots/10_user_dashboard_authorized.png)

---

## 11. Refus d'accès à l'Espace Administrateur (/admin/dashboard) pour 'user' (HTTP 403)

![11. Refus d'accès à l'Espace Administrateur (/admin/dashboard) pour 'user' (HTTP 403)](screenshots/11_user_admin_dashboard_forbidden.png)

---

## 12. Authentification réussie pour l'administrateur 'admin' (admin / 1234)

![12. Authentification réussie pour l'administrateur 'admin' (admin / 1234)](screenshots/12_login_success_admin.png)

---

## 13. Accès autorisé à l'Espace Administrateur (/admin/dashboard) pour ROLE_ADMIN

![13. Accès autorisé à l'Espace Administrateur (/admin/dashboard) pour ROLE_ADMIN](screenshots/13_admin_dashboard_authorized.png)

---

## 14. Accès autorisé à l'Espace Utilisateur pour 'admin' (règle hasAnyRole)

![14. Accès autorisé à l'Espace Utilisateur pour 'admin' (règle hasAnyRole)](screenshots/14_admin_user_dashboard_authorized.png)

---

## 15. Déconnexion et redirection vers /login?logout=true (POST /logout)

![15. Déconnexion et redirection vers /login?logout=true (POST /logout)](screenshots/15_logout_redirection.png)

---

## 16. Affichage du message de confirmation de déconnexion sur la page de login

![16. Affichage du message de confirmation de déconnexion sur la page de login](screenshots/16_logout_success_display.png)
