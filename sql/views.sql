
CREATE OR REPLACE VIEW vw_MundialesSedes AS
SELECT m.id, m.nombre AS Mundial, m.fecha, m.logo, p.id AS idPais, p.nombre as Pais
FROM mundial m 
INNER JOIN sede s ON m.id = s.idMundial
INNER JOIN pais p ON p.id = s.idPais
ORDER BY m.fecha DESC;

CREATE OR REPLACE VIEW vw_PublicacionesDefault AS
SELECT p.id, m.id AS idMundial, m.nombre AS nombreMundial, m.fecha AS fechaMundial, 
u.id AS idUsuario, u.nombre AS nombreUsuario, u.correoElectronico, c.id AS idCategoria, c.categoria, ps.id AS idPais, 
ps.nombre, ps.nombreSeleccion, p.descripcion, p.multimedia, 
e.id AS idEstatus, e.estatus, p.vistas, p.fechaCreacion, p.fechaAprobacion
FROM publicacion p
INNER JOIN mundial m ON p.idMundial = m.id
INNER JOIN usuario u ON p.idUsuario = u.id
INNER JOIN categoria c ON p.idCategoria = c.id
INNER JOIN pais ps ON p.idPais = ps.id
INNER JOIN tipoEstatus e ON p.idEstatus = e.id;