<%@ page session="true" %>
<c:if test="${sessionScope.usuario == null}">
    <script>
        window.location.href = 'login.jsp';
    </script>
</c:if>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listado de Cursos</title>

        <!-- CDN de Bootstrap -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <!-- CSS personalizados -->
        <link href="styles.css" rel="stylesheet">
    </head>
    <body>
        <!-- Barra de navegación -->
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

        <!-- Listado de Cursos -->
        <div class="container mt-4">
            <h1 class="text-center my-4">Listado de Cursos</h1>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="curso" items="${cursos}">
                    <tr>
                        <td>${curso.id}</td>
                        <td>${curso.nombre}</td>
                        <td>${curso.descripcion}</td>
                        <td>
                            <a href="CursoControlador?action=editar&id=${curso.id}" class="btn btn-primary btn-sm">Editar</a>
                            <a href="CursoControlador?action=eliminar&id=${curso.id}" class="btn btn-danger btn-sm">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Formulario para Añadir Curso -->
        <div class="container mt-4">
            <h2 class="text-center">Añadir un Nuevo Curso</h2>
            <form action="CursoControlador?action=crear" method="post" class="mt-4">
                <div class="form-group">
                    <label for="nombre">Nombre del curso:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="descripcion">Descripción del curso:</label>
                    <textarea id="descripcion" name="descripcion" class="form-control" rows="4"></textarea>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Añadir Curso</button>
                </div>
            </form>
        </div>

        <!-- Actualizar Edades de Estudiantes en un Curso -->
        <div class="container mt-5">
            <h3 class="text-center">Actualizar Edad de Estudiantes en un Curso</h3>
            <form action="CursoControlador?action=actualizarEdades" method="post" class="mt-4">
                <div class="form-group">
                    <label for="cursoId">Seleccione un Curso:</label>
                    <select id="cursoId" name="cursoId" class="form-control">
                        <c:forEach var="curso" items="${cursos}">
                            <option value="${curso.id}">${curso.nombre}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="nuevaEdad">Nueva Edad para los Estudiantes:</label>
                    <input type="number" id="nuevaEdad" name="nuevaEdad" class="form-control" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-success">Actualizar Edad</button>
                </div>
            </form>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
