<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Cursos</title>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=divice-width, initial-scale=1.0">

        <!-- CDN de Bootstrap -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <!-- CSS personalizados -->
        <link href="styles.css" rel="stylesheet">
    </head>
    <body>
        <div>
            <h1 class="text-center my-4">Listado de Cursos</h1>

            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="curso" items="${cursos}">
                    <tr>
                        <td>${curso.id}</td>
                        <td>${curso.nombre}</td>
                        <td>${curso.descripcion}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <h2>Añadir un nuevo curso</h2>
            <form action="CursoControlador" method="post">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" required><br>

                <label for="descripcion">Descripción:</label>
                <input type="text" id="descripcion" name="descripcion"><br>

                <button type="submit" class="btn btn-primary">Añadir Curso</button>
            </form>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
