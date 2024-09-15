package com.mycompany.gestioncursos.controladores;

import com.mycompany.gestioncursos.modelos.Curso;
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        //Obtenemos la lista de cursos
        List<Curso> cursos = em.createQuery("SELECT c FROM Curso c", Curso.class).getResultList();

        //pasamos la lista de cursos a la vista
        request.setAttribute("cursos", cursos);
        request.getRequestDispatcher("/vistas/cursos.jsp").forward(request, response);

        em.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        em.getTransaction().begin();
        Curso nuevoCurso = new Curso(nombre, descripcion);
        em.persist(nuevoCurso);
        em.getTransaction().commit();

        em.close();
        response.sendRedirect("CursoControlador");
    }

    //consulta JPQL para saber cursos en los que esta inscrito un estudiante
    public List<Curso> getCursosPorEstudiante(Long estudianteId) {
        EntityManager em = emf.createEntityManager();
        List<Curso> cursos = em.createQuery(
                "SELECT c FROM Curso c JOIN c.estudiantes e WHERE e.id = :estudianteId", Curso.class)
                .setParameter("estudianteId", estudianteId)
                .getResultList();
        em.close();
        return cursos;
    }
}
