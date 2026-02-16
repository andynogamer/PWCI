CREATE DATABASE infografia_mundiales;
USE infografia_mundiales;

CREATE TABLE tipoUsuario(
    id int NOT NULL AUTO_INCREMENT,
    tipo varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE pais(
    id int NOT NULL AUTO_INCREMENT,
	nombre varchar(255) NOT NULL UNIQUE,
	gentilicioMasculino varchar(255) NOT NULL,
	gentilicioFemenino varchar(255) NOT NULL,
	nombreSeleccion varchar(255) NOT NULL,
    PRIMARY KEY (id)

);

CREATE TABLE mundial(
    id int NOT NULL AUTO_INCREMENT,
	nombre varchar(255) NOT NULL UNIQUE,
	fecha DATE NOT NULL,
	logo BLOB NOT NULL,
	descripcion varchar(800) NOT NULL,
	fechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE categoria(
    id int NOT NULL AUTO_INCREMENT,
    categoria varchar(255) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE tipoEstatus(
    id int NOT NULL AUTO_INCREMENT,
    estatus varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (id) 
);

CREATE TABLE usuario(
    id int NOT NULL AUTO_INCREMENT,
    idTipo int NOT NULL,
	nombre varchar(255) NOT NULL,
	apellido varchar(510) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	foto BLOB,
	genero CHAR(1) NOT NULL,
	idPaisNacimiento int NOT NULL,
	idNacionalidad int NOT NULL,
	correoElectronico varchar(321) NOT NULL,
	contrasena varchar(50) NOT NULL,
    fechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idTipo) REFERENCES tipoUsuario(id),
    FOREIGN KEY (idPaisNacimiento) REFERENCES pais(id),
    FOREIGN KEY (idNacionalidad) REFERENCES pais(id),
    PRIMARY KEY (id)
);

CREATE TABLE sede(
    idMundial int NOT NULL,
    idPais int NOT NULL,
    PRIMARY KEY (idMundial, idPais),
    FOREIGN KEY (idMundial) REFERENCES mundial(id),
    FOREIGN KEY (idPais) REFERENCES pais(id)
);

CREATE TABLE publicacion(
    id int NOT NULL AUTO_INCREMENT,
	idMundial int NOT NULL,
	idUsuario int NOT NULL,
	idCategoria int NOT NULL,
	idPais int NOT NULL,
	descripcion varchar(800), 
	multimedia LONGBLOB,
	idEstatus int NOT NULL,
	vistas int UNSIGNED NOT NULL DEFAULT 0,
	fechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fechaAprobacion TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (idMundial) REFERENCES mundial(id),
    FOREIGN KEY (idUsuario) REFERENCES usuario(id),
    FOREIGN KEY (idCategoria) REFERENCES categoria(id),
    FOREIGN KEY (idPais) REFERENCES pais(id),
    FOREIGN KEY (idEstatus) REFERENCES tipoEstatus(id),
    PRIMARY KEY (id)
);

CREATE TABLE likePublicacion(
    idUsuario int NOT NULL,
	idPublicacion int NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idUsuario, idPublicacion),
    FOREIGN KEY (idUsuario) REFERENCES usuario(id),
    FOREIGN KEY (idPublicacion) REFERENCES publicacion(id) ON DELETE CASCADE
);

CREATE TABLE comentario(
    id int NOT NULL AUTO_INCREMENT,
    idPublicacion int NOT NULL,
    idUsuario int NOT NULL,
    idComentarioPadre int NOT NULL,
    texto varchar(512),
    FOREIGN KEY (idPublicacion) REFERENCES publicacion(id) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES usuario(id),
    FOREIGN KEY (idComentarioPadre) REFERENCES comentario(id) ON DELETE CASCADE,
    PRIMARY KEY (id)
);
