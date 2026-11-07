package ma.fstg.security;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestBuilders.formLogin;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestBuilders.logout;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.unauthenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class AuthControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("1. Page de login accessible publiquement (HTTP 200)")
    void loginPageIsPublic() throws Exception {
        mockMvc.perform(get("/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("login"));
    }

    @Test
    @DisplayName("2. Accès anonyme à /home redirige vers /login (HTTP 302)")
    @WithAnonymousUser
    void unauthenticatedAccessToHomeRedirectsToLogin() throws Exception {
        mockMvc.perform(get("/home"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrlPattern("**/login"));
    }

    @Test
    @DisplayName("3. Accès anonyme à /user/dashboard redirige vers /login (HTTP 302)")
    @WithAnonymousUser
    void unauthenticatedAccessToUserDashboardRedirectsToLogin() throws Exception {
        mockMvc.perform(get("/user/dashboard"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrlPattern("**/login"));
    }

    @Test
    @DisplayName("4. Accès anonyme à /admin/dashboard redirige vers /login (HTTP 302)")
    @WithAnonymousUser
    void unauthenticatedAccessToAdminDashboardRedirectsToLogin() throws Exception {
        mockMvc.perform(get("/admin/dashboard"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrlPattern("**/login"));
    }

    @Test
    @DisplayName("5. Connexion réussie pour 'user' avec redirection vers /home")
    void loginSuccessForUser() throws Exception {
        mockMvc.perform(formLogin("/authenticate").user("user").password("1111"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/home"))
                .andExpect(authenticated().withUsername("user").withRoles("USER"));
    }

    @Test
    @DisplayName("6. Connexion réussie pour 'admin' avec redirection vers /home")
    void loginSuccessForAdmin() throws Exception {
        mockMvc.perform(formLogin("/authenticate").user("admin").password("1234"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/home"))
                .andExpect(authenticated().withUsername("admin").withRoles("ADMIN"));
    }

    @Test
    @DisplayName("7. Échec de connexion avec mot de passe incorrect -> /login?error=true")
    void loginFailureWithBadCredentials() throws Exception {
        mockMvc.perform(formLogin("/authenticate").user("user").password("wrong"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/login?error=true"))
                .andExpect(unauthenticated());
    }

    @Test
    @DisplayName("8. Utilisateur avec ROLE_USER accède à /user/dashboard (HTTP 200)")
    @WithMockUser(username = "user", roles = {"USER"})
    void userCanAccessUserDashboard() throws Exception {
        mockMvc.perform(get("/user/dashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("user-dashboard"));
    }

    @Test
    @DisplayName("9. Utilisateur avec ROLE_USER refusé sur /admin/dashboard (HTTP 403)")
    @WithMockUser(username = "user", roles = {"USER"})
    void userCannotAccessAdminDashboard() throws Exception {
        mockMvc.perform(get("/admin/dashboard"))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("10. Administrateur avec ROLE_ADMIN accède à /admin/dashboard (HTTP 200)")
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void adminCanAccessAdminDashboard() throws Exception {
        mockMvc.perform(get("/admin/dashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("admin-dashboard"));
    }

    @Test
    @DisplayName("11. Administrateur avec ROLE_ADMIN accède aussi à /user/dashboard (hasAnyRole)")
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    void adminCanAccessUserDashboard() throws Exception {
        mockMvc.perform(get("/user/dashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("user-dashboard"));
    }

    @Test
    @DisplayName("12. Déconnexion via /logout redirige vers /login?logout=true")
    @WithMockUser(username = "user", roles = {"USER"})
    void logoutRedirectsToLoginWithLogoutParam() throws Exception {
        mockMvc.perform(logout("/logout"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/login?logout=true"))
                .andExpect(unauthenticated());
    }
}
