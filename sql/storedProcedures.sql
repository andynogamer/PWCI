USE DATABASE infografia_mundiales;

----------------------------------USUARIOS--------------------------------------

--ALTA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_RegistrarUsuario //
CREATE PROCEDURE sp_RegistrarUsuario(
    IN p_idTipo int,
    IN p_nombre varchar(255),
    IN p_apellido varchar(510),
    IN p_fechaNacimiento DATE,
    IN p_foto BLOB,
    IN p_genero CHAR(1),
    IN p_idPaisNacimiento int,
    IN p_idNacionalidad int,
    IN p_correoElectronico varchar(321),
    IN p_contrasena varchar(50)

)
BEGIN
    INSERT INTO usuario(
        idTipo,
        nombre,
        apellido,
        fechaNacimiento,
        foto,
        genero,
        idPaisNacimiento,
        idNacionalidad,
        correoElectronico,
        contrasena
    )
    VALUES(
        p_idTipo,
        p_nombre,
        p_apellido,
        p_fechaNacimiento,
        p_foto,
        p_genero,
        p_idPaisNacimiento,
        p_idNacionalidad,
        p_correoElectronico,
        p_contrasena
    );
END //


--CAMBIOS--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_CambioContrasena // --CONTRASENA
CREATE PROCEDURE sp_CambioContrasena(
    IN p_id int,
    IN p_contrasena varchar(50)
)
BEGIN
    UPDATE usuario
    SET contrasena = p_contrasena
    WHERE id = p_id;
END; //

DROP PROCEDURE IF EXISTS sp_CambioFoto; --FOTO
DELIMITER //
CREATE PROCEDURE sp_CambioFoto(
    IN p_id int,
    IN p_foto BLOB
)
BEGIN
    UPDATE usuario
    SET foto = p_foto
    WHERE id = p_id;
END //


DELIMITER // 
DROP PROCEDURE IF EXISTS sp_CambiosGeneralesUsuario // --GENERALES
CREATE PROCEDURE sp_CambiosGeneralesUsuario(
    IN p_id int,
    IN p_nombre varchar(255),
    IN p_apellido varchar(510),
    IN p_fechaNacimiento DATE,
    IN p_genero CHAR(1),
    IN p_idPaisNacimiento int,
    IN p_idNacionalidad int
)
BEGIN
    UPDATE usuario
    SET nombre = p_nombre, apellido = p_apellido, fechaNacimiento = p_fechaNacimiento, genero = p_genero, idPaisNacimiento = p_idPaisNacimiento, idNacionalidad = p_idNacionalidad
    WHERE id = p_id;
END //

--CONSULTA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaUsuario //
CREATE PROCEDURE sp_ConsultaUsuario(
    IN p_id int
)
BEGIN 
    SELECT u.id, u.idTipo, u.nombre, u.apellido, u.fechaNacimiento, u.foto, u.genero, p.nombre AS pais, n.gentilicioMasculino AS nacionalidadMasculino, n.gentilicioFemenino AS nacionalidadFemenino, u.correoElectronico
    FROM usuario u
    INNER JOIN pais p ON p.id = u.idPaisNacimiento
    INNER JOIN pais n ON n.id = u.idNacionalidad
    WHERE u.id = p_id;
END //


---------------------------------------------------------------------------------

------------------------------------PAIS-----------------------------------------
--ALTA--

DELIMITER //
DROP PROCEDURE IF EXISTS sp_RegistrarPais //
CREATE PROCEDURE sp_RegistrarPais(
    IN p_nombre varchar(255),
    IN p_gentilicioMasculino varchar(255),
    IN p_gentilicioFemenino varchar(255),
    IN p_nombreSeleccion varchar(255)

)
BEGIN
    INSERT INTO pais(
        nombre,
        gentilicioMasculino,
        gentilicioFemenino,
        nombreSeleccion
    )
    VALUES(
        p_nombre,
        p_gentilicioMasculino,
        p_gentilicioFemenino,
        p_nombreSeleccion
        
    );
END //

--CAMBIOS--
DELIMITER // 
DROP PROCEDURE IF EXISTS sp_CambiosGeneralesPais // --GENERALES
CREATE PROCEDURE sp_CambiosGeneralesPais(
    IN p_id int,
    IN p_nombre varchar(255),
    IN p_gentilicioMasculino varchar(255),
    IN p_gentilicioFemenino varchar(255),
    IN p_nombreSeleccion varchar(255)
)
BEGIN
    UPDATE pais
    SET nombre = p_nombre, gentilicioMasculino = p_gentilicioMasculino, gentilicioFemenino = p_gentilicioFemenino, nombreSeleccion = p_nombreSeleccion    
    WHERE id = p_id;
END //

--CONSULTAS--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaPaises //
CREATE PROCEDURE sp_ConsultaPaises()
BEGIN
    SELECT id, nombre
    FROM pais;
END //

---------------------------------------------------------------------------------

-----------------------------------MUNDIAL---------------------------------------
--ALTA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_RegistrarMundial //
CREATE PROCEDURE sp_RegistrarMundial(
    IN p_nombre varchar(255),
    IN p_fecha DATE,
    IN p_logo BLOB,
    IN p_descripcion varchar(800)
)
BEGIN
    INSERT INTO mundial(
        nombre,
        fecha,
        logo,
        descripcion
    )
    VALUES(
        p_nombre,
        p_fecha,
        p_logo,
        p_descripcion
    );
END //

--CAMBIOS--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_CambioFotoMundial // --FOTO
CREATE PROCEDURE sp_CambioFotoMundial(
    IN p_id int,
    IN p_logo BLOB
)
BEGIN
    UPDATE mundial
    SET logo = p_logo
    WHERE id = p_id;
END //

 
DELIMITER // 
DROP PROCEDURE IF EXISTS sp_CambiosGeneralesMundial //  --GENERALES
CREATE PROCEDURE sp_CambiosGeneralesMundial(
    IN p_id int,
    IN p_nombre varchar(255),
    IN p_fecha DATE,
    IN p_descripcion varchar(800)
)
BEGIN
    UPDATE mundial
    SET nombre = p_nombre, fecha = p_fecha, descripcion = p_descripcion
    WHERE id = p_id;
END //

--CONSULTAS--
DELIMITER // --TODOS LOS MUNDIALES
DROP PROCEDURE IF EXISTS sp_ConsultaMundiales //
CREATE PROCEDURE sp_ConsultaMundiales()
BEGIN   
    SELECT id, mundial, fecha, logo, pais
    FROM vw_MundialesSedes;
END //

DELIMITER // --POR PAIS SEDE
DROP PROCEDURE IF EXISTS sp_ConsultaMundialesPorSede //
CREATE PROCEDURE sp_ConsultaMundialesPorSede(
    IN p_idPais int
)
BEGIN   
    SELECT id, mundial, fecha, logo, pais
    FROM vw_MundialesSedes
    WHERE idPais =p_idPais;
END //

---------------------------------------------------------------------------------

-------------------------------CATEGORIA-----------------------------------------
--ALTA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_RegistrarCategoria //
CREATE PROCEDURE sp_RegistrarCategoria(
    IN p_categoria varchar(255)
)
BEGIN
    INSERT INTO categoria(
        categoria
    )
    VALUES(
        p_categoria
    );
END //

--CAMBIOS--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_CambioCategoria //
CREATE PROCEDURE sp_CambioCategoria(
    IN p_id int,
    IN p_categoria varchar(255)
)
BEGIN
    UPDATE categoria
    SET categoria = p_categoria
    WHERE id = p_id;
END //

--CONSULTAS--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaCategorias //
CREATE PROCEDURE sp_ConsultaCategorias()
BEGIN   
    SELECT id, categoria
    FROM categoria;
END //
---------------------------------------------------------------------------------

----------------------------------SEDE-------------------------------------------
/*CUANDO SE MODIFICA EL PAIS DE UN MUNDIAL SE TIENE QUE VER AFECTADA LA TABLA SEDE*/
--ALTA--
DELIMITER // 
DROP PROCEDURE IF EXISTS sp_RegistrarSede //
CREATE PROCEDURE sp_RegistrarSede(
    IN p_idMundial int,
    IN p_idPais int
)
BEGIN
    INSERT INTO sede(
        idMundial, 
        idPais
    ) 
    VALUES(
        p_idMundial,
        p_idPais
    );
END //

--CAMBIOS--
---------------------------------------------------------------------------------

-------------------------------PUBLICACION---------------------------------------
--ALTA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_RegistrarPublicacion //
CREATE PROCEDURE sp_RegistrarPublicacion(
    IN p_idMundial int,
    IN p_idUsuario int,
    IN p_idCategoria int,
    IN p_idPais int,
    IN p_descripcion varchar(800),
    IN p_multimedia LONGBLOB,
    IN p_idEstatus int
)
BEGIN 
    INSERT INTO publicacion(
        idMundial,
        idUsuario,
        idCategoria,
        idPais,
        descripcion,
        multimedia,
        idEstatus
    )
    VALUES(
        p_idMundial,
        p_idUsuario,
        p_idCategoria,
        p_idPais,
        p_descripcion,
        p_multimedia,
        p_idEstatus
    );
END //

--BAJA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_EliminarPublicacion //
CREATE PROCEDURE sp_EliminarPublicacion(
    IN p_id int
)
BEGIN
    DELETE FROM publicacion 
    WHERE id = p_id;
END //

--CONSULTA--

DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaPublicacion // --DETALLE INDIVIDUAL PUBLICACION
CREATE PROCEDURE sp_ConsultaPublicacion(
    IN p_id int
)
BEGIN
    SELECT id, nombreMundial, fechaMundial, nombreUsuario, correoElectronico, categoria,
    nombre, nombreSeleccion, descripcion, multimedia
    FROM vw_PublicacionesDefault
    WHERE id = p_id;
END //

DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaPublicacionesMundial // --PUBLICACIONES DENTRO DE CADA MUNDIAL
CREATE PROCEDURE sp_ConsultaPublicacionesMundial(
    IN p_idMundial int
)
BEGIN
    
    SELECT id, idMundial, nombreMundial, fechaMundial, nombreUsuario, correoElectronico, categoria,
    nombre, nombreSeleccion, descripcion, multimedia
    FROM vw_PublicacionesDefault
    WHERE idMundial = p_idMundial;
END //

DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaPublicacionesMundialCategoria // --MUNDIALCATEGORIA
CREATE PROCEDURE sp_ConsultaPublicacionesMundialCategoria(
    IN p_idMundial int,
    IN p_idCategoria int
)
BEGIN
    
    SELECT id, idMundial, nombreMundial, fechaMundial, nombreUsuario, correoElectronico, categoria,
    nombre, nombreSeleccion, descripcion, multimedia
    FROM vw_PublicacionesDefault
    WHERE idMundial = p_idMundial AND idCategoria = p_idCategoria;
END //

DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaPublicacionesBusqueda // --BUSQUEDA DE PUBLICACIONES
CREATE PROCEDURE sp_ConsultaPublicacionesBusqueda(
    IN p_busqueda varchar(100)
)
BEGIN
    SET @termino = CONCAT('%',p_busqueda,'%');
    SELECT id, idMundial, nombreMundial, fechaMundial, nombreUsuario, correoElectronico, categoria,
    nombre, nombreSeleccion, descripcion, multimedia
    FROM vw_PublicacionesDefault
    WHERE (
        categoria LIKE @termino
        OR correoElectronico LIKE @termino
        OR CAST(YEAR(fechaMundial) AS CHAR) LIKE @termino
        OR idMundial IN(
            SELECT s.idMundial
            FROM sede s 
            INNER JOIN pais p ON s.idPais = p.id
            WHERE p.nombre LIKE @termino
        )
    ) AND idEstatus = 1;
END //

DELIMITER //
DROP PROCEDURE IF EXISTS sp_ConsultaPublicacionesUsuario// --PUBLICACIONES DEL USUARIO
CREATE PROCEDURE sp_ConsultaPublicacionesUsuario(
    IN p_idUsuario int
)
BEGIN
    
    SELECT id, idMundial, nombreMundial, fechaMundial, nombreUsuario, correoElectronico, categoria,
    nombre, nombreSeleccion, descripcion, multimedia
    FROM vw_PublicacionesDefault
    WHERE idUsuario = p_idUsuario;
END //
---------------------------------------------------------------------------------

-----------------------------------LIKE------------------------------------------

--ALTA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_RegistrarLike //
CREATE PROCEDURE sp_RegistrarLike(
    IN p_idUsuario int,
    IN p_idPublicacion int
)
BEGIN
    INSERT INTO likePublicacion(
        idUsuario,
        idPublicacion
    )
    VALUES(
        p_idUsuario,
        p_idPublicacion
    );
END //

--BAJA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_EliminarLike //
CREATE PROCEDURE sp_EliminarLike(
    IN p_idUsuario int,
    IN p_idPublicacion int
)
BEGIN
    DELETE FROM likePublicacion
    WHERE idUsuario = p_idUsuario AND idPublicacion = p_idPublicacion;
END //
---------------------------------------------------------------------------------

--------------------------------COMENTARIO---------------------------------------
--ALTA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_RegistrarComentario //
CREATE PROCEDURE sp_RegistrarComentario(
    IN p_idPublicacion int,
    IN p_idUsuario int,
    IN p_idComentarioPadre int,
    IN p_texto varchar(512)
)
BEGIN
    INSERT INTO comentario(
        idPublicacion,
        idUsuario,
        idComentarioPadre,
        texto
    )
    VALUES(
        p_idPublicacion,
        p_idUsuario,
        p_idComentarioPadre,
        p_texto
    );
END //

--BAJA--
DELIMITER //
DROP PROCEDURE IF EXISTS sp_EliminarComentario //
CREATE PROCEDURE sp_EliminarComentario(
    IN p_id int
)
BEGIN
    DELETE FROM comentario 
    WHERE id = p_id;
END //
