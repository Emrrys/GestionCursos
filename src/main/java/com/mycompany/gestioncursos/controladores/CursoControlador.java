package com.mycompany.gestioncursos.controladores;

import com.mycompany.gestioncursos.modelos.Curso;
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

@WebServlet("/CursoControlador")
public class CursoControlador extends HttpServlet {

    @PersistenceUnit(unitName = "GestionCursosPU")
    private EntityManagerFactory emf;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Asume "listar" si no hay acción definida
        if (action == null || action.isEmpty()) {
            action = "listar";
        }

        switch (action) {
            case "listar":
                listarCursos(request, response);
                break;
            case "editar":
                editarCurso(request, response);
                break;
            case "eliminar":
                eliminarCurso(request, response);
                break;
            default:
                listarCursos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("actualizar".equals(action)) {
            actualizarCurso(request, response);
        } else if ("actualizarEdades".equals(action)) {
            actualizarEdadesEstudiantes(request, response);
        } else {
            doGet(request, response);  // Redirige a `doGet` para otras acciones
        }
    }

    // Método para listar cursos
    private void listarCursos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try {
            List<Curso> cursos = em.createQuery("SELECT c FROM Curso c", Curso.class).getResultList();
            request.setAttribute("cursos", cursos);
            request.getRequestDispatcher("/vistas/cursos.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }

    // Método para editar curso (muestra formulario)
    private void editarCurso(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        EntityManager em = emf.createEntityManager();
        try {
            Curso curso = em.find(Curso.class, id);
            if (curso != null) {
                request.setAttribute("curso", curso);
                request.getRequestDispatcher("/vistas/editarCurso.jsp").forward(request, response);
            } else {
                response.sendRedirect("CursoControlador");
            }
        } finally {
            em.close();
        }
    }

    // Método para actualizar curso
    private void actualizarCurso(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Curso curso = em.find(Curso.class, id);
            if (curso != null) {
                curso.setNombre(nombre);
                curso.setDescripcion(descripcion);
                em.merge(curso);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }

        response.sendRedirect("CursoControlador");
    }

    // Método para eliminar curso
    private void eliminarCurso(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));

        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Curso curso = em.find(Curso.class, id);
            if (curso != null) {
                em.remove(curso);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }

        response.sendRedirect("CursoControlador");
    }

    // Método para actualizar la edad de los estudiantes de un curso específico
    private void actualizarEdadesEstudiantes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long cursoId = Long.parseLong(request.getParameter("cursoId"));
        int nuevaEdad = Integer.parseInt(request.getParameter("nuevaEdad"));

        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            List<Estudiante> estudiantes = em.createQuery(
                    "SELECT e FROM Estudiante e JOIN e.cursos c WHERE c.id = :cursoId", Estudiante.class)
                    .setParameter("cursoId", cursoId)
                    .getResultList();

            for (Estudiante estudiante : estudiantes) {
                estudiante.setEdad(nuevaEdad);
                em.merge(estudiante);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }

        response.sendRedirect("CursoControlador");
    }

    // Consulta JPQL para obtener cursos en los que está inscrito un estudiante
    public List<Curso> getCursosPorEstudiante(Long estudianteId) {
        EntityManager em = emf.createEntityManager();
        List<Curso> cursos;
        try {
            cursos = em.createQuery(
                    "SELECT c FROM Curso c JOIN c.estudiantes e WHERE e.id = :estudianteId", Curso.class)
                    .setParameter("estudianteId", estudianteId)
                    .getResultList();
        } finally {
            em.close();
        }
        return cursos;
    }
}
