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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        //Obtener la lista de estudiantes
        List<Estudiante> estudiantes = em.createQuery("SELECT e FROM Estudiante e", Estudiante.class).getResultList();

        //Pasamos la lista a la vista
        request.setAttribute("estudiantes", estudiantes);
        request.getRequestDispatcher("/vistas/estudiantes.jsp").forward(request, response);

        em.close();
    }

    //Consulta JPQL para saber los estudiantes inscritos en un curso especifico
    public List<Estudiante> getEstudiantesPorCurso(Long cursoId) {
        EntityManager em = emf.createEntityManager();
        List<Estudiante> estudiantes = em.createQuery(
                "SELECT e FROM Estudiante e JOIN e.cursos c WHERE c.id = :cursoId", Estudiante.class)
                .setParameter("cursoId", cursoId)
                .getResultList();
        em.close();
        return estudiantes;
    }
}
