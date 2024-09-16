<%@ page session="true" %>
<c:if test="${sessionScope.usuario == null}">
    <script>
        window.location.href = 'login.jsp';
    </script>
</c:if>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listado de Estudiantes</title>
        <!-- CDN de Bootstrap -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- CSS personalizado -->
        <link href="../css/styles.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <img src="../images/Logo_ipchile.png" alt="Logotipo de la empresa" class="mr-3" style="width:100px;">
            <a class="navbar-brand ml-3" href="../index.jsp">Gestión de Cursos</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="estudiantes.jsp">Estudiantes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cursos.jsp">Cursos</a>
                    </li>
                    <c:if test="${empty sessionScope.usuario}">
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty sessionScope.usuario}">
                        <li class="nav-item">
                            <a class="nav-link" href="CerrarSesion">Cerrar Sesión</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </nav>

        <div class="container">
            <h1 class="text-center my-4">Listado de Estudiantes</h1>
            <!-- Mostrar mensaje de éxito o error si existen -->
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success">${mensaje}</div>
            </c:if>
            <c:if test="${not empty errorMensaje}">
                <div class="alert alert-danger">${errorMensaje}</div>
            </c:if>
            
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Edad</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="estudiante" items="${estudiantes}">
                        <tr>
                            <td>${estudiante.id}</td>
                            <td>${estudiante.nombre}</td>
                            <td>${estudiante.email}</td>
                            <td>${estudiante.edad}</td>
                            <td>
                                <a href="EstudianteControlador?action=editar&id=${estudiante.id}" class="btn btn-primary btn-sm">Editar</a>
                                <a href="EstudianteControlador?action=eliminar&id=${estudiante.id}" 
                                   class="btn btn-danger btn-sm" 
                                   onclick="return confirm('¿Está seguro que desea eliminar este estudiante?');">
                                    Eliminar
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="container">
            <h3>Eliminar Estudiantes No Inscritos en Ningún Curso</h3>
            <form action="EstudianteControlador?action=eliminarNoInscritos" method="post">
                <button type="submit" class="btn btn-danger">Eliminar Estudiantes No Inscritos</button>
            </form>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
