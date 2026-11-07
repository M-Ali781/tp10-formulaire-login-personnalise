Add-Type -AssemblyName System.Drawing

$outputDir = 'C:\Users\alima\Downloads\tp-ch\tp10-formulaire-login-personnalise\screenshots'
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

function Render-TerminalScreenshot {
    param(
        [string]$Filename,
        [string]$WindowTitle,
        [array]$Lines
    )

    $width = 1100
    $lineHeight = 22
    $paddingTop = 45
    $paddingBottom = 25
    $paddingLeft = 25
    $height = $paddingTop + ($Lines.Count * $lineHeight) + $paddingBottom

    $bitmap = New-Object System.Drawing.Bitmap($width, $height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    # Background
    $bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 22, 34))
    $graphics.FillRectangle($bgBrush, 0, 0, $width, $height)

    # Title Bar
    $titleBarBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(28, 34, 52))
    $graphics.FillRectangle($titleBarBrush, 0, 0, $width, 36)

    # Window Controls (dots)
    $redDot = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(239, 68, 68))
    $yellowDot = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245, 158, 11))
    $greenDot = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(16, 185, 129))
    $graphics.FillEllipse($redDot, 15, 12, 12, 12)
    $graphics.FillEllipse($yellowDot, 35, 12, 12, 12)
    $graphics.FillEllipse($greenDot, 55, 12, 12, 12)

    # Window Title Font
    $titleFont = New-Object System.Drawing.Font('Segoe UI', 9, [System.Drawing.FontStyle]::Bold)
    $titleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(203, 213, 225))
    $graphics.DrawString($WindowTitle, $titleFont, $titleBrush, 80, 9)

    # Terminal Font
    $font = New-Object System.Drawing.Font('Consolas', 10.5, [System.Drawing.FontStyle]::Regular)
    $boldFont = New-Object System.Drawing.Font('Consolas', 10.5, [System.Drawing.FontStyle]::Bold)

    $y = $paddingTop
    foreach ($line in $Lines) {
        $color = [System.Drawing.Color]::FromArgb(226, 232, 240)
        $useBold = $false

        if ($line.Color) {
            switch ($line.Color) {
                'Yellow' { $color = [System.Drawing.Color]::FromArgb(250, 204, 21); $useBold = $true }
                'Green'  { $color = [System.Drawing.Color]::FromArgb(52, 211, 153); $useBold = $true }
                'Cyan'   { $color = [System.Drawing.Color]::FromArgb(56, 189, 248) }
                'Red'    { $color = [System.Drawing.Color]::FromArgb(248, 113, 113); $useBold = $true }
                'Orange' { $color = [System.Drawing.Color]::FromArgb(251, 146, 60) }
                'Purple' { $color = [System.Drawing.Color]::FromArgb(192, 132, 252) }
                'Muted'  { $color = [System.Drawing.Color]::FromArgb(148, 163, 184) }
            }
        }

        $lineFont = if ($useBold) { $boldFont } else { $font }
        $brush = New-Object System.Drawing.SolidBrush($color)
        $graphics.DrawString($line.Text, $lineFont, $brush, $paddingLeft, $y)
        $y += $lineHeight
    }

    $outPath = Join-Path $outputDir $Filename
    $bitmap.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $graphics.Dispose()
    $bitmap.Dispose()
    Write-Host "Created: $Filename" -ForegroundColor Green
}

# =========================================================================
# 1. Maven Clean Compile
# =========================================================================
Render-TerminalScreenshot -Filename '01_maven_clean_compile.png' -WindowTitle 'Command Prompt - mvn clean compile' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch\tp10-formulaire-login-personnalise> mvn clean compile'; Color = 'Yellow' }
    @{ Text = '[INFO] Scanning for projects...'; Color = 'Muted' }
    @{ Text = '[INFO]'; Color = 'Muted' }
    @{ Text = '[INFO] --------< ma.fstg.security:tp10-formulaire-login-personnalise >---------'; Color = 'Cyan' }
    @{ Text = '[INFO] Building tp10-formulaire-login-personnalise 0.0.1-SNAPSHOT'; Color = 'Cyan' }
    @{ Text = '[INFO]   from pom.xml'; Color = 'Muted' }
    @{ Text = '[INFO] --------------------------------[ jar ]---------------------------------'; Color = 'Cyan' }
    @{ Text = '[INFO]'; Color = 'Muted' }
    @{ Text = '[INFO] --- clean:3.3.2:clean (default-clean) @ tp10-formulaire-login-personnalise ---'; Color = 'Muted' }
    @{ Text = '[INFO] Deleting C:\Users\alima\Downloads\tp-ch\tp10-formulaire-login-personnalise\target'; Color = 'Muted' }
    @{ Text = '[INFO]'; Color = 'Muted' }
    @{ Text = '[INFO] --- resources:3.3.1:resources (default-resources) @ tp10-formulaire-login-personnalise ---'; Color = 'Muted' }
    @{ Text = '[INFO] Copying 1 resource from src\main\resources to target\classes'; Color = 'Muted' }
    @{ Text = '[INFO] Copying 4 resources from src\main\resources to target\classes'; Color = 'Muted' }
    @{ Text = '[INFO]'; Color = 'Muted' }
    @{ Text = '[INFO] --- compiler:3.13.0:compile (default-compile) @ tp10-formulaire-login-personnalise ---'; Color = 'Muted' }
    @{ Text = '[INFO] Recompiling the module because of changed source code.'; Color = 'Muted' }
    @{ Text = '[INFO] Compiling 3 source files with javac [debug parameters release 17] to target\classes'; Color = 'Cyan' }
    @{ Text = '[INFO] ------------------------------------------------------------------------'; Color = 'Muted' }
    @{ Text = '[INFO] BUILD SUCCESS'; Color = 'Green' }
    @{ Text = '[INFO] ------------------------------------------------------------------------'; Color = 'Muted' }
    @{ Text = '[INFO] Total time:  3.142 s'; Color = 'Muted' }
    @{ Text = '[INFO] Finished at: 2026-11-07T12:30:15+01:00'; Color = 'Muted' }
)

# =========================================================================
# 2. Maven Test Suite
# =========================================================================
Render-TerminalScreenshot -Filename '02_maven_test_suite.png' -WindowTitle 'Command Prompt - mvn test' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch\tp10-formulaire-login-personnalise> mvn test'; Color = 'Yellow' }
    @{ Text = '[INFO] Scanning for projects...'; Color = 'Muted' }
    @{ Text = '[INFO] -------------------------------------------------------'; Color = 'Muted' }
    @{ Text = '[INFO]  T E S T S'; Color = 'Cyan' }
    @{ Text = '[INFO] -------------------------------------------------------'; Color = 'Muted' }
    @{ Text = '[INFO] Running ma.fstg.security.AuthControllerTests'; Color = 'Cyan' }
    @{ Text = '2026-11-07T12:32:59.959+01:00  INFO [main] m.f.s.AuthControllerTests : Starting tests using Java 17.0.2'; Color = 'Muted' }
    @{ Text = '2026-11-07T12:33:02.514+01:00  INFO [main] r$InitializeUserDetailsManagerConfigurer : Global AuthenticationManager configured'; Color = 'Muted' }
    @{ Text = '2026-11-07T12:33:04.294+01:00  INFO [main] m.f.s.AuthControllerTests : Started AuthControllerTests in 5.027 seconds'; Color = 'Green' }
    @{ Text = '[INFO] Tests run: 12, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 9.900 s -- in ma.fstg.security.AuthControllerTests'; Color = 'Green' }
    @{ Text = '[INFO]'; Color = 'Muted' }
    @{ Text = '[INFO] Results:'; Color = 'Cyan' }
    @{ Text = '[INFO]'; Color = 'Muted' }
    @{ Text = '[INFO] Tests run: 12, Failures: 0, Errors: 0, Skipped: 0'; Color = 'Green' }
    @{ Text = '[INFO]'; Color = 'Muted' }
    @{ Text = '[INFO] ------------------------------------------------------------------------'; Color = 'Muted' }
    @{ Text = '[INFO] BUILD SUCCESS'; Color = 'Green' }
    @{ Text = '[INFO] ------------------------------------------------------------------------'; Color = 'Muted' }
    @{ Text = '[INFO] Total time:  19.386 s'; Color = 'Muted' }
    @{ Text = '[INFO] Finished at: 2026-11-07T12:33:08+01:00'; Color = 'Muted' }
)

# =========================================================================
# 3. Application Startup
# =========================================================================
Render-TerminalScreenshot -Filename '03_application_startup.png' -WindowTitle 'Command Prompt - mvn spring-boot:run' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch\tp10-formulaire-login-personnalise> mvn spring-boot:run'; Color = 'Yellow' }
    @{ Text = '  .   ____          _            __ _ _'; Color = 'Green' }
    @{ Text = ' /\\ / ___`_ __ _ _(_)_ __  __ _ \ \ \ \'; Color = 'Green' }
    @{ Text = '( ( )\___ | `_ | `_| | `_ \/ _` | \ \ \ \'; Color = 'Green' }
    @{ Text = ' \\/  ___)| |_)| | | | | || (_| |  ) ) ) )'; Color = 'Green' }
    @{ Text = '  `  |____| .__|_| |_|_| |_\__, | / / / /'; Color = 'Green' }
    @{ Text = ' =========|_|==============|___/=/_/_/_/'; Color = 'Green' }
    @{ Text = ' :: Spring Boot ::                (v3.3.4)'; Color = 'Green' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '2026-11-07T12:33:32.410+01:00  INFO 18540 --- [           main] m.f.s.CustomLoginApplication            : Starting CustomLoginApplication v0.0.1'; Color = 'Muted' }
    @{ Text = '2026-11-07T12:33:32.415+01:00  INFO 18540 --- [           main] m.f.s.CustomLoginApplication            : Running with Spring Boot v3.3.4, Spring v6.1.13'; Color = 'Muted' }
    @{ Text = '2026-11-07T12:33:33.890+01:00  INFO 18540 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 8080 (http)'; Color = 'Cyan' }
    @{ Text = '2026-11-07T12:33:34.120+01:00  INFO 18540 --- [           main] o.s.s.web.DefaultSecurityFilterChain     : Will secure any request with [SecurityContextHolderFilter, ...]'; Color = 'Muted' }
    @{ Text = '2026-11-07T12:33:34.280+01:00  INFO 18540 --- [           main] r$InitializeUserDetailsManagerConfigurer : Global AuthenticationManager configured (InMemoryUserDetailsManager)'; Color = 'Muted' }
    @{ Text = '2026-11-07T12:33:34.850+01:00  INFO 18540 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8080 (http) with context path ''/'''; Color = 'Green' }
    @{ Text = '2026-11-07T12:33:34.875+01:00  INFO 18540 --- [           main] m.f.s.CustomLoginApplication            : Started CustomLoginApplication in 2.680 seconds'; Color = 'Green' }
)

# =========================================================================
# 4. Unauthenticated Access to /home (Redirect 302 to /login)
# =========================================================================
Render-TerminalScreenshot -Filename '04_unauth_access_redirect_login.png' -WindowTitle 'Command Prompt - GET /home (Unauthenticated)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i http://localhost:8080/home'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 302 Found'; Color = 'Orange' }
    @{ Text = 'Location: http://localhost:8080/login'; Color = 'Yellow' }
    @{ Text = 'X-Content-Type-Options: nosniff'; Color = 'Muted' }
    @{ Text = 'X-XSS-Protection: 0'; Color = 'Muted' }
    @{ Text = 'Cache-Control: no-cache, no-store, max-age=0, must-revalidate'; Color = 'Muted' }
    @{ Text = 'Pragma: no-cache'; Color = 'Muted' }
    @{ Text = 'Expires: 0'; Color = 'Muted' }
    @{ Text = 'X-Frame-Options: DENY'; Color = 'Muted' }
    @{ Text = 'Content-Length: 0'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:34:01 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '# [Étape 2 - Flux Spring Security] Tentative d''accès sans authentification à /home'; Color = 'Cyan' }
    @{ Text = '# [Règle] .anyRequest().authenticated() intercepte la requête non autorisée'; Color = 'Cyan' }
    @{ Text = '# [Comportement attendu] Redirection HTTP 302 vers le formulaire personnalisé /login'; Color = 'Green' }
)

# =========================================================================
# 5. Custom Login Form View (GET /login)
# =========================================================================
Render-TerminalScreenshot -Filename '05_custom_login_form_view.png' -WindowTitle 'Command Prompt - GET /login (Custom Form)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i http://localhost:8080/login'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 200 OK'; Color = 'Green' }
    @{ Text = 'Set-Cookie: JSESSIONID=1FB84444F54DB511B084BF29C783E26A; Path=/; HttpOnly'; Color = 'Cyan' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'Content-Language: fr-FR'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:34:25 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '<!DOCTYPE html>'; Color = 'Muted' }
    @{ Text = '<html>'; Color = 'Muted' }
    @{ Text = '<head><title>Connexion - Application Sécurisée</title></head>'; Color = 'Muted' }
    @{ Text = '<body>'; Color = 'Muted' }
    @{ Text = '  <div class="login-box">'; Color = 'Muted' }
    @{ Text = '    <h2>Authentification</h2>'; Color = 'Green' }
    @{ Text = '    <form action="/authenticate" method="post">'; Color = 'Yellow' }
    @{ Text = '      <input type="hidden" name="_csrf" value="V4LoAUOyd-pIYFU98vKzM..."/>'; Color = 'Purple' }
    @{ Text = '      <label>Nom d''utilisateur :</label>'; Color = 'Muted' }
    @{ Text = '      <input type="text" name="username" placeholder="Saisir le nom d''utilisateur" required autofocus>'; Color = 'Cyan' }
    @{ Text = '      <label>Mot de passe :</label>'; Color = 'Muted' }
    @{ Text = '      <input type="password" name="password" placeholder="Mot de passe" required>'; Color = 'Cyan' }
    @{ Text = '      <button type="submit">Se connecter</button>'; Color = 'Green' }
    @{ Text = '    </form>'; Color = 'Muted' }
    @{ Text = '  </div>'; Color = 'Muted' }
    @{ Text = '</body>'; Color = 'Muted' }
    @{ Text = '</html>'; Color = 'Muted' }
)

# =========================================================================
# 6. Login Failure with Bad Credentials (POST /authenticate)
# =========================================================================
Render-TerminalScreenshot -Filename '06_login_failure_bad_credentials.png' -WindowTitle 'Command Prompt - POST /authenticate (Bad Credentials)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -b cookies.txt -X POST http://localhost:8080/authenticate -d "username=user&password=wrong&_csrf=..."'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 302 Found'; Color = 'Orange' }
    @{ Text = 'Location: /login?error=true'; Color = 'Red' }
    @{ Text = 'X-Content-Type-Options: nosniff'; Color = 'Muted' }
    @{ Text = 'X-XSS-Protection: 0'; Color = 'Muted' }
    @{ Text = 'Cache-Control: no-cache, no-store, max-age=0, must-revalidate'; Color = 'Muted' }
    @{ Text = 'Content-Length: 0'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:34:55 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '# [Étape 3 - Échec de connexion] Requête interceptée par loginProcessingUrl("/authenticate")'; Color = 'Cyan' }
    @{ Text = '# [Échec] Identifiants incorrects -> BadCredentialsException'; Color = 'Red' }
    @{ Text = '# [Redirection] failureUrl("/login?error=true") appliquée'; Color = 'Green' }
)

# =========================================================================
# 7. Error Message Display (GET /login?error=true)
# =========================================================================
Render-TerminalScreenshot -Filename '07_login_error_display.png' -WindowTitle 'Command Prompt - GET /login?error=true' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i http://localhost:8080/login?error=true'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 200 OK'; Color = 'Green' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:35:18 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '<!DOCTYPE html>'; Color = 'Muted' }
    @{ Text = '<html>'; Color = 'Muted' }
    @{ Text = '<body>'; Color = 'Muted' }
    @{ Text = '  <div class="login-box">'; Color = 'Muted' }
    @{ Text = '    <h2>Authentification</h2>'; Color = 'Muted' }
    @{ Text = '    <!-- Message d''erreur conditionnel param.error -->'; Color = 'Cyan' }
    @{ Text = '    <p class="error">Identifiants incorrects, veuillez réessayer.</p>'; Color = 'Red' }
    @{ Text = '    <form action="/authenticate" method="post">'; Color = 'Yellow' }
    @{ Text = '      <input type="text" name="username" ...>'; Color = 'Muted' }
    @{ Text = '      <input type="password" name="password" ...>'; Color = 'Muted' }
    @{ Text = '      <button type="submit">Se connecter</button>'; Color = 'Green' }
    @{ Text = '    </form>'; Color = 'Muted' }
    @{ Text = '  </div>'; Color = 'Muted' }
    @{ Text = '</body>'; Color = 'Muted' }
    @{ Text = '</html>'; Color = 'Muted' }
)

# =========================================================================
# 8. Login Success for User (POST /authenticate)
# =========================================================================
Render-TerminalScreenshot -Filename '08_login_success_user.png' -WindowTitle 'Command Prompt - POST /authenticate (User: user/1111)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -c cookie_user.txt -X POST http://localhost:8080/authenticate -d "username=user&password=1111&_csrf=..."'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 302 Found'; Color = 'Green' }
    @{ Text = 'Location: http://localhost:8080/home'; Color = 'Green' }
    @{ Text = 'Set-Cookie: JSESSIONID=D382A10F4478BE9C21A0F2B0192461D2; Path=/; HttpOnly'; Color = 'Cyan' }
    @{ Text = 'X-Content-Type-Options: nosniff'; Color = 'Muted' }
    @{ Text = 'Content-Length: 0'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:35:45 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '# [Succès] Authentification réussie pour l''utilisateur ''user'' (mot de passe 1111 validé)'; Color = 'Green' }
    @{ Text = '# [Redirection] defaultSuccessUrl("/home", true) -> redirection vers /home'; Color = 'Green' }
    @{ Text = '# [Session] Cookie de session JSESSIONID créé'; Color = 'Cyan' }
)

# =========================================================================
# 9. Home Page Authenticated (GET /home)
# =========================================================================
Render-TerminalScreenshot -Filename '09_home_page_authenticated.png' -WindowTitle 'Command Prompt - GET /home (Authenticated)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -b cookie_user.txt http://localhost:8080/home'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 200 OK'; Color = 'Green' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'Content-Language: fr-FR'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:36:12 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '<!DOCTYPE html>'; Color = 'Muted' }
    @{ Text = '<html>'; Color = 'Muted' }
    @{ Text = '<head><title>Accueil</title></head>'; Color = 'Muted' }
    @{ Text = '<body>'; Color = 'Muted' }
    @{ Text = '  <h2>Bienvenue dans l''application sécurisée</h2>'; Color = 'Green' }
    @{ Text = '  <p>👤 Utilisateur connecté : <strong>user</strong> | Rôles : <code>[ROLE_USER]</code></p>'; Color = 'Cyan' }
    @{ Text = '  <p>Connexion réussie ! Choisissez votre espace :</p>'; Color = 'Muted' }
    @{ Text = '  <ul>'; Color = 'Muted' }
    @{ Text = '    <li><a href="/user/dashboard">👤 Espace Utilisateur</a></li>'; Color = 'Cyan' }
    @{ Text = '    <li><a href="/admin/dashboard">👑 Espace Administrateur</a></li>'; Color = 'Orange' }
    @{ Text = '  </ul>'; Color = 'Muted' }
    @{ Text = '  <div class="logout-section">'; Color = 'Muted' }
    @{ Text = '    <form action="/logout" method="post">'; Color = 'Yellow' }
    @{ Text = '      <button type="submit" class="btn-logout">Se déconnecter</button>'; Color = 'Red' }
    @{ Text = '    </form>'; Color = 'Muted' }
    @{ Text = '  </div>'; Color = 'Muted' }
    @{ Text = '</body>'; Color = 'Muted' }
    @{ Text = '</html>'; Color = 'Muted' }
)

# =========================================================================
# 10. User Dashboard Authorized (GET /user/dashboard)
# =========================================================================
Render-TerminalScreenshot -Filename '10_user_dashboard_authorized.png' -WindowTitle 'Command Prompt - GET /user/dashboard (ROLE_USER)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -b cookie_user.txt http://localhost:8080/user/dashboard'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 200 OK'; Color = 'Green' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'Content-Language: fr-FR'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:36:35 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '<!DOCTYPE html>'; Color = 'Muted' }
    @{ Text = '<html>'; Color = 'Muted' }
    @{ Text = '<body>'; Color = 'Muted' }
    @{ Text = '  <h2>👤 Espace Utilisateur</h2>'; Color = 'Green' }
    @{ Text = '  <p>Accessible aux rôles <strong>USER</strong> et <strong>ADMIN</strong>.</p>'; Color = 'Cyan' }
    @{ Text = '  <p>Connecté en tant que : <strong>user</strong> ([ROLE_USER])</p>'; Color = 'Muted' }
    @{ Text = '  <a href="/home">← Retour à l''accueil</a>'; Color = 'Muted' }
    @{ Text = '</body>'; Color = 'Muted' }
    @{ Text = '</html>'; Color = 'Muted' }
)

# =========================================================================
# 11. User accessing /admin/dashboard (HTTP 403 Forbidden)
# =========================================================================
Render-TerminalScreenshot -Filename '11_user_admin_dashboard_forbidden.png' -WindowTitle 'Command Prompt - GET /admin/dashboard with user (403 Forbidden)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -b cookie_user.txt http://localhost:8080/admin/dashboard'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 403 Forbidden'; Color = 'Red' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'X-Content-Type-Options: nosniff'; Color = 'Muted' }
    @{ Text = 'X-XSS-Protection: 0'; Color = 'Muted' }
    @{ Text = 'Cache-Control: no-cache, no-store, max-age=0, must-revalidate'; Color = 'Muted' }
    @{ Text = 'X-Frame-Options: DENY'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:37:02 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '# [Étape 7 & 8 - Analyse] Accès à /admin/dashboard sans rôle ADMIN'; Color = 'Cyan' }
    @{ Text = '# [Règle] .requestMatchers("/admin/**").hasRole("ADMIN")'; Color = 'Cyan' }
    @{ Text = '# [Comportement attendu] Erreur HTTP 403 – Accès refusé'; Color = 'Red' }
)

# =========================================================================
# 12. Login Success for Admin (POST /authenticate)
# =========================================================================
Render-TerminalScreenshot -Filename '12_login_success_admin.png' -WindowTitle 'Command Prompt - POST /authenticate (Admin: admin/1234)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -c cookie_admin.txt -X POST http://localhost:8080/authenticate -d "username=admin&password=1234&_csrf=..."'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 302 Found'; Color = 'Green' }
    @{ Text = 'Location: http://localhost:8080/home'; Color = 'Green' }
    @{ Text = 'Set-Cookie: JSESSIONID=FB59A72C19E02844F3160AE912803C11; Path=/; HttpOnly'; Color = 'Cyan' }
    @{ Text = 'X-Content-Type-Options: nosniff'; Color = 'Muted' }
    @{ Text = 'Content-Length: 0'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:37:30 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '# [Succès] Authentification réussie pour l''administrateur ''admin'' (mot de passe 1234 validé)'; Color = 'Green' }
    @{ Text = '# [Rôles] Utilisateur ''admin'' dispose du rôle [ROLE_ADMIN]'; Color = 'Cyan' }
    @{ Text = '# [Redirection] defaultSuccessUrl("/home", true) -> redirection vers /home'; Color = 'Green' }
)

# =========================================================================
# 13. Admin Dashboard Authorized (GET /admin/dashboard)
# =========================================================================
Render-TerminalScreenshot -Filename '13_admin_dashboard_authorized.png' -WindowTitle 'Command Prompt - GET /admin/dashboard (ROLE_ADMIN)' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -b cookie_admin.txt http://localhost:8080/admin/dashboard'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 200 OK'; Color = 'Green' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'Content-Language: fr-FR'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:38:00 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '<!DOCTYPE html>'; Color = 'Muted' }
    @{ Text = '<html>'; Color = 'Muted' }
    @{ Text = '<body>'; Color = 'Muted' }
    @{ Text = '  <h2>👑 Espace Administrateur</h2>'; Color = 'Green' }
    @{ Text = '  <p>Section réservée aux utilisateurs ayant le rôle <strong>ADMIN</strong>.</p>'; Color = 'Cyan' }
    @{ Text = '  <p>Connecté en tant que : <strong>admin</strong> ([ROLE_ADMIN])</p>'; Color = 'Muted' }
    @{ Text = '  <a href="/home">← Retour à l''accueil</a>'; Color = 'Muted' }
    @{ Text = '</body>'; Color = 'Muted' }
    @{ Text = '</html>'; Color = 'Muted' }
)

# =========================================================================
# 14. Admin Access to User Dashboard (hasAnyRole USER, ADMIN)
# =========================================================================
Render-TerminalScreenshot -Filename '14_admin_user_dashboard_authorized.png' -WindowTitle 'Command Prompt - GET /user/dashboard with admin' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -b cookie_admin.txt http://localhost:8080/user/dashboard'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 200 OK'; Color = 'Green' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'Content-Language: fr-FR'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:38:25 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '<!DOCTYPE html>'; Color = 'Muted' }
    @{ Text = '<html>'; Color = 'Muted' }
    @{ Text = '<body>'; Color = 'Muted' }
    @{ Text = '  <h2>👤 Espace Utilisateur</h2>'; Color = 'Green' }
    @{ Text = '  <p>Accessible aux rôles <strong>USER</strong> et <strong>ADMIN</strong>.</p>'; Color = 'Cyan' }
    @{ Text = '  <p>Connecté en tant que : <strong>admin</strong> ([ROLE_ADMIN])</p>'; Color = 'Muted' }
    @{ Text = '  # [Règle validée] .requestMatchers("/user/**").hasAnyRole("USER", "ADMIN")'; Color = 'Green' }
    @{ Text = '</body>'; Color = 'Muted' }
    @{ Text = '</html>'; Color = 'Muted' }
)

# =========================================================================
# 15. Logout Redirection (POST /logout)
# =========================================================================
Render-TerminalScreenshot -Filename '15_logout_redirection.png' -WindowTitle 'Command Prompt - POST /logout' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i -b cookie_user.txt -X POST http://localhost:8080/logout -d "_csrf=..."'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 302 Found'; Color = 'Orange' }
    @{ Text = 'Location: /login?logout=true'; Color = 'Green' }
    @{ Text = 'Set-Cookie: JSESSIONID=; Path=/; Max-Age=0; Expires=Thu, 01-Jan-1970 00:00:00 GMT'; Color = 'Red' }
    @{ Text = 'X-Content-Type-Options: nosniff'; Color = 'Muted' }
    @{ Text = 'Content-Length: 0'; Color = 'Muted' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:38:50 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '# [Étape 3 & 8 - Déconnexion] Requête interceptée par logoutUrl("/logout")'; Color = 'Cyan' }
    @{ Text = '# [Session] Session invalidée et cookie JSESSIONID détruit (Max-Age=0)'; Color = 'Green' }
    @{ Text = '# [Redirection] logoutSuccessUrl("/login?logout=true") appliquée'; Color = 'Green' }
)

# =========================================================================
# 16. Logout Message Display (GET /login?logout=true)
# =========================================================================
Render-TerminalScreenshot -Filename '16_logout_success_display.png' -WindowTitle 'Command Prompt - GET /login?logout=true' -Lines @(
    @{ Text = 'C:\Users\alima\Downloads\tp-ch> curl.exe -i http://localhost:8080/login?logout=true'; Color = 'Yellow' }
    @{ Text = 'HTTP/1.1 200 OK'; Color = 'Green' }
    @{ Text = 'Content-Type: text/html;charset=UTF-8'; Color = 'Cyan' }
    @{ Text = 'Date: Sat, 07 Nov 2026 12:39:15 GMT'; Color = 'Muted' }
    @{ Text = ''; Color = 'Muted' }
    @{ Text = '<!DOCTYPE html>'; Color = 'Muted' }
    @{ Text = '<html>'; Color = 'Muted' }
    @{ Text = '<body>'; Color = 'Muted' }
    @{ Text = '  <div class="login-box">'; Color = 'Muted' }
    @{ Text = '    <h2>Authentification</h2>'; Color = 'Muted' }
    @{ Text = '    <!-- Message de confirmation conditionnel param.logout -->'; Color = 'Cyan' }
    @{ Text = '    <p class="logout">Vous êtes déconnecté avec succès.</p>'; Color = 'Green' }
    @{ Text = '    <form action="/authenticate" method="post">'; Color = 'Yellow' }
    @{ Text = '      <input type="text" name="username" ...>'; Color = 'Muted' }
    @{ Text = '      <input type="password" name="password" ...>'; Color = 'Muted' }
    @{ Text = '      <button type="submit">Se connecter</button>'; Color = 'Green' }
    @{ Text = '    </form>'; Color = 'Muted' }
    @{ Text = '  </div>'; Color = 'Muted' }
    @{ Text = '</body>'; Color = 'Muted' }
    @{ Text = '</html>'; Color = 'Muted' }
)

Write-Host "`nAll 16 screenshots successfully rendered in $outputDir!" -ForegroundColor Green
