DROP DATABASE IF EXISTS stock;
CREATE DATABASE stock;
USE stock;

CREATE TABLE productes(
CodProducte VARCHAR(10) NOT NULL,
Nom VARCHAR(20) NOT NULL,
PreuUnitari DECIMAL(6),
Stock INT(5),
PRIMARY KEY (CodProducte) );

CREATE TABLE vendes(
CodVenda VARCHAR(10) NOT NULL,
CodProducte VARCHAR(10) NOT NULL,
DataVenda DATE,
UnitatsVenudes INT(3),
PRIMARY KEY (CodVenda),
FOREIGN KEY (CodProducte) REFERENCES productes(CodProducte) );

CREATE TABLE registre
(id_targeta VARCHAR(10),
data TIMESTAMP,
ent_sort ENUM('E','S')
);

DELIMITER //
CREATE PROCEDURE  actualitza_stock(IN codi_producte VARCHAR(10), IN unitats_vendides INT(3), IN data_venda DATE, IN codi_venda VARCHAR(10))
BEGIN
	DECLARE stock_actual INT;
    SELECT Stock INTO stock_actual FROM productes WHERE CodProducte = codi_producte;
    IF (stock_actual >= unitats_vendides) THEN
        UPDATE productes SET Stock = Stock - unitats_vendides WHERE CodProducte = codi_producte;
        INSERT INTO vendes (CodVenda, CodProducte, DataVenda, UnitatsVenudes) VALUES (codi_venda, codi_producte, data_venda, unitats_vendides);
        SELECT 'Venda realitzada amb èxit!' AS Missatge;
    ELSE
        SELECT 'No hi ha suficient stock per fer la venda' AS Missatge;
    END IF;
END //
DELIMITER ;
CALL actualitza_stock(10, 1, ‘2022-05-26’, 22);

CREATE TABLE registre
(id_targeta VARCHAR(10),
data TIMESTAMP,
ent_sort ENUM('E','S')
);

INSERT INTO registre VALUES(1, '15/5/17 9:18', 'E');
INSERT INTO registre VALUES(1, '15/5/17 12:18', 'S');

DELIMITER //
CREATE FUNCTION  hores_fetes(id_targeta VARCHAR(10), data_consulta DATE) RETURNS TIME
DETERMINISTIC
BEGIN
    DECLARE hores_fetes TIME;
    SELECT TIMEDIFF(MAX(CASE WHEN ent_sort = 'S' THEN data ELSE NULL END), MIN(CASE WHEN ent_sort = 'E' THEN data ELSE NULL END)) INTO hores_fetes
    FROM registre
    WHERE DATE(data) = data_consulta AND id_targeta = id_targeta;
    RETURN hores_fetes;
END // 
DELIMITER ;
SELECT hores_fetes(1, '15/5/17') AS HoresRealitzades;
DELIMITER //
CREATE FUNCTION anomalies(id_targeta VARCHAR(10), data_consulta DATE) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE missatge VARCHAR(50);
    SELECT CONCAT('Entrada el dia ', DATE_FORMAT(data, '%y/%m/%d'), ' a les ', TIME_FORMAT(data, '%H:%i')) INTO missatge
    FROM registre
    WHERE id_targeta = id_targeta AND DATE(data) = data_consulta AND ent_sort = 'E' AND TIME(data) > '09:00:00'
    ORDER BY data ASC LIMIT 1;
    RETURN missatge;
END //
DELIMITER ;
SELECT anomalies(1, '15/5/17') AS AnomaliaTrobada;