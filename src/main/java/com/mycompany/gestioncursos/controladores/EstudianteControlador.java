package com.mycompany.gestioncursos.controladores;

import com.mycompany.gestioncursos.modelos.Estudiante;
import java.io.IOException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EstudianteControlador")
public class EstudianteControlador extends HttpServlet {

    @PersistenceUnit(unitName = "GestionCursosPU")
    private EntityManagerFactory emf;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Si la acción no está definida, se asume que es "listar"
        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        switch (action) {
            case "listar":
                listarEstudiantes(request, response);
                break;
            case "editar":
                editarEstudiante(request, response);
                break;
            case "eliminar":
                eliminarEstudiante(request, response);
                break;
            default:
                listarEstudiantes(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("actualizar".equals(action)) {
            actualizarEstudiante(request, response);
        } else if ("eliminarNoInscritos".equals(action)) {
            eliminarEstudiantesNoInscritos(request, response);
        } else {
            doGet(request, response);  // Otras acciones, como listar
        }
    }

    // Método para listar estudiantes
    private void listarEstudiantes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try {
            List<Estudiante> estudiantes = em.createQuery("SELECT e FROM Estudiante e", Estudiante.class).getResultList();
            request.setAttribute("estudiantes", estudiantes);
            request.getRequestDispatcher("/vistas/estudiantes.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }

    // Método para editar un estudiante
    private void editarEstudiante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        EntityManager em = emf.createEntityManager();
        try {
            Estudiante estudiante = em.find(Estudiante.class, id);
            if (estudiante != null) {
                request.setAttribute("estudiante", estudiante);
                request.getRequestDispatcher("/vistas/editarEstudiante.jsp").forward(request, response);
            } else {
                response.sendRedirect("EstudianteControlador");
            }
        } finally {
            em.close();
        }
    }

    // Método para actualizar un estudiante
    private void actualizarEstudiante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        int edad = Integer.parseInt(request.getParameter("edad"));

        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Estudiante estudiante = em.find(Estudiante.class, id);
            if (estudiante != null) {
                estudiante.setNombre(nombre);
                estudiante.setEmail(email);
                estudiante.setEdad(edad);
                em.merge(estudiante);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }

        response.sendRedirect("EstudianteControlador");
    }

    // Método para eliminar un estudiante
    private void eliminarEstudiante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Estudiante estudiante = em.find(Estudiante.class, id);
            if (estudiante != null) {
                em.remove(estudiante);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        response.sendRedirect("EstudianteControlador");
    }

    // Método para eliminar estudiantes no inscritos en ningún curso
    private void eliminarEstudiantesNoInscritos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            List<Estudiante> noInscritos = em.createQuery(
                    "SELECT e FROM Estudiante e WHERE e.cursos IS EMPTY", Estudiante.class)
                    .getResultList();

            for (Estudiante estudiante : noInscritos) {
                em.remove(estudiante);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }

        response.sendRedirect("EstudianteControlador");
    }

    // Método para obtener estudiantes por curso
    public List<Estudiante> getEstudiantesPorCurso(Long cursoId) {
        EntityManager em = emf.createEntityManager();
        List<Estudiante> estudiantes;
        try {
            estudiantes = em.createQuery(
                    "SELECT e FROM Estudiante e JOIN e.cursos c WHERE c.id = :cursoId", Estudiante.class)
                    .setParameter("cursoId", cursoId)
                    .getResultList();
        } finally {
            em.close();
        }
        return estudiantes;
    }
}
