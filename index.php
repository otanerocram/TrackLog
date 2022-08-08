<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
header('Content-Type: text/html; charset=UTF-8');
header("Expires: Tue, 03 Jul 2001 06:00:00 GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");
error_reporting(E_ALL);
date_default_timezone_set('America/Lima');
?>
<html>

<head>
    <title>Lista de Comandos Enviados</title>
    <link rel='stylesheet' type='text/css' href='css/bootstrap.min.css'>
    <link href="https://getbootstrap.com/docs/4.0/examples/album/album.css" rel="stylesheet">
</head>

<body>

    <header>
        <div class="collapse bg-dark" id="navbarHeader">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 col-md-7 py-4">
                        <h4 class="text-white">Información</h4>
                        <p class="text-muted">En la columna "Estado" se muestran los códigos de respuesta recibidos por el webservice</p>
                    </div>
                    <div class="col-sm-4 offset-md-1 py-4">
                        <h4 class="text-white">Contacto</h4>
                        <ul class="list-unstyled">
                            <li><a href="http://www.aguilacontrol.com" target="_blank" class="text-white">AguilaControl</a></li>
                            <li><a href="mailTo:sistemas@aguilacontrol.com" target="_blank" class="text-white">sistemas@aguilacontrol.com</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="navbar navbar-dark bg-dark box-shadow">
            <div class="container d-flex justify-content-between">
                <a href="#" class="navbar-brand d-flex align-items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                        <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path>
                        <circle cx="12" cy="13" r="4"></circle>
                    </svg>
                    <strong>Tabla de Envío de Mensajes</strong>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
        </div>
    </header>
    <main role="main">
        <div class"well">

            <?php

            require('config.php');

            $con = mysqli_connect($dbHost, $dbUser, $dbPass, $dbName, $dbPort);
            // Check connection
            if (mysqli_connect_errno()) {
                echo "Failed to connect to MySQL: " . mysqli_connect_error();
            }

            $result = mysqli_query($con, "SELECT `posicionId`, `vehiculoId`, `velocidad`, `satelites`, `rumbo`, `latitud`, `longitud`, `altitud`, `gpsDate`, `gpsTime`, `statusCode`, `ignition`, `odometro`, `horometro`, `nivelBateria`, `estado` FROM `$dbName` ORDER BY `posicionId` DESC LIMIT 100;");

            echo "<table class='table table-striped table-hover'>
<thead class='thead-dark'>
<tr>
<th>ID</th>
<th>Placa</th>
<th>Ubicación</th>
<th>Fecha de Envío</th>
<th>Estado</th>
</tr>
</thead>";

            while ($row = mysqli_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['posicionId'] . "</td>";
                echo "<td>" . $row['vehiculoId'] . "</td>";
                echo "<td>" . $row['latitud'] . "," . $row['longitud'] . "</td>";
                echo "<td>" . $row['gpsDate'] . " " . $row['gpsTime'] . "</td>";
                echo "<td>" . $row['estado'] . "</td>";
                echo "</tr>";
            }
            echo "</table>";


            mysqli_close($con);
            ?>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/holder.min.js"></script>
</body>