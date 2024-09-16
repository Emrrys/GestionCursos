<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de cursos y alumnos</title>
        <!-- CDN de Bootstrap -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- CSS personalizados -->
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <img src="images/Logo_ipchile.png" alt="Logotipo de la empresa" class="mr-3" style="width:100px;" href="index.jsp">
            <a class="navbar-brand ml-3" href="index.jsp">Gestión de Cursos</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="vistas/estudiantes.jsp">Estudiantes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="vistas/cursos.jsp">Cursos</a>
                    </li>

                    <!-- Si NO hay una sesión activa, mostrar el enlace de login -->
                    <c:if test="${empty sessionScope.usuario}">
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a> <!-- Corregido a 'login.jsp' -->
                        </li>
                    </c:if>

                    <!-- Si hay una sesión activa, mostrar el enlace de cerrar sesión -->
                    <c:if test="${not empty sessionScope.usuario}">
                        <li class="nav-item">
                            <a class="nav-link" href="LogoutControlador">Cerrar Sesión</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </nav>

        <!-- muestra distinto contenido dependiendo si existe un usuario autentificado en la sesión -->
        <div class="container mt-4">
            <c:choose>
                <c:when test="${empty sessionScope.usuario}">
                    <h2 class="text-center">Bienvenido</h2>
                    <p class="text-center">Usa el menú de navegación para iniciar sesión y poder gestionar estudiantes y cursos.</p>
                    <img class="d-block mx-auto img-fluid" src="images/cursos.jpg" style="width: 60%;" alt="Imagen de cursos"/>
                </c:when>
                <c:otherwise>
                    <h2 class="text-center">Bienvenido, ${sessionScope.usuario.nombre}</h2> <!-- Mostrar nombre del usuario -->
                    <p class="text-center">Usa el menú de navegación para gestionar estudiantes y cursos.</p>
                    <img class="d-block mx-auto img-fluid" src="images/cursos.jpg" style="width: 60%;" alt="Imagen de cursos"/>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
