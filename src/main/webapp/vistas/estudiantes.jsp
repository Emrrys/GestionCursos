<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Estudiantes</title>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=divice-width, initial-scale=1.0">

        <!-- CDN de Bootstrap -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <!-- CSS personalizados -->
        <link href="styles.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1 class="text-center my-4">Listado de Estudiantes</h1>

            <table class="table table-striped table-bordered">
                <thead>
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
                                <button class="btn btn-primary btn-sm">Editar</button>
                                <button class="btn btn-danger btn-sm">Eliminar</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
