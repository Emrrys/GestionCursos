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
        <title>Editar Estudiante</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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

        <!-- Contenedor para el formulario de edición -->
        <div class="container mt-5">
            <h2 class="text-center">Editar Estudiante</h2>
            <form action="EstudianteControlador?action=actualizar" method="post">
                <input type="hidden" name="id" value="${estudiante.id}">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" value="${estudiante.nombre}" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" value="${estudiante.email}" required>
                </div>
                <div class="form-group">
                    <label for="edad">Edad:</label>
                    <input type="number" id="edad" name="edad" class="form-control" value="${estudiante.edad}" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-success">Guardar Cambios</button>
                    <a href="estudiantes.jsp" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>