package com.mycompany.gestioncursos.controladores;

import com.mycompany.gestioncursos.modelos.Usuario;
import java.io.IOException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt; // Asegúrate de añadir esta dependencia a tu proyecto

@WebServlet("/LoginControlador")
public class LoginControlador extends HttpServlet {

    @PersistenceUnit(unitName = "GestionCursosPU")
    private EntityManagerFactory emf;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        EntityManager em = emf.createEntityManager();
        try {
            // Buscar el usuario por nombre de usuario
            Usuario usuario = em.createQuery("SELECT u FROM Usuario u WHERE u.username = :username", Usuario.class)
                    .setParameter("username", username)
                    .getSingleResult();

            // Verificar si la contraseña ingresada coincide con la almacenada (hash)
            if (BCrypt.checkpw(password, usuario.getPassword())) {
                // Si la contraseña es correcta, crear la sesión
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);

                // Establecer tiempo de expiración de la sesión (opcional)
                session.setMaxInactiveInterval(30 * 60); // 30 minutos

                // Redirigir al index o página principal
                response.sendRedirect("index.jsp");
            } else {
                // Contraseña incorrecta
                request.setAttribute("mensajeError", "Nombre de usuario o contraseña incorrectos.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }

        } catch (NoResultException e) {
            // Si no se encuentra el usuario
            request.setAttribute("mensajeError", "Nombre de usuario o contraseña incorrectos.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }
}
