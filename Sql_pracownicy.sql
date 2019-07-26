-- 1. Tworzenie tabeli pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko)
CREATE TABLE employee(
	id INT auto_increment PRIMARY KEY,
	imie varchar(30), 
    nazwisko varchar(30), 
    wyplata decimal (6,2), 
    data_urodzenia date, 
    stanowisko varchar(30));
    
-- 2. Wstawianie do tabeli co najmniej 6 pracowników
INSERT INTO pracownicy_zadanie.employee(imie, nazwisko, wyplata, data_urodzenia, stanowisko)
VALUES
('Jan', 'Kowalski', 2500.00, '1968-10-10', 'Engineer'),
('Jadwiga', 'Kowalska', 4500, '1993-08-22', 'Staff'),
('Zofia', 'Kowalski', 3500, '1985-02-18', 'Engineer'),
('Tomasz', 'Kowalski', 2500, '1981-03-10', 'Director'),
('Tamara', 'Tartak', 2500, '1978-11-06', 'Engineer'),
('Jan', 'Niemlak', 2000, '1989-10-06', 'Staff'),
('Janusz', 'Hortex', 1999, '1990-01-01', 'HR');

-- 3. Pobieranie wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employee
ORDER BY nazwisko;

-- 4. Pobieranie pracowników na wybranym stanowisku
SELECT * FROM employee
WHERE stanowisko='Engineer'; 

-- 5. Pobieranie pracowników, którzy mają co najmniej 30 lat
SELECT * FROM employee
WHERE ABS(extract(YEAR from data_urodzenia)-extract(YEAR from current_date())) >=30; 

-- 6. Zwiększanie wypłaty pracowników na wybranym stanowisku o 10%
SELECT imie, nazwisko, wyplata*1.1 as wyplata_powiekszona_o_10pro, data_urodzenia, stanowisko FROM employee; 

-- 7. Usuwanie najmłodszego pracownika
DELETE FROM employee
where data_urodzenia in (SELECT * FROM (SELECT MIN(data_urodzenia) from employee) as t);

-- 8. Usuwanie tabeli pracownik
DROP TABLE employee;

-- 9. Tworzenie tabeli stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE stanowisko( 
	id INT auto_increment PRIMARY KEY,
	nazwa varchar(30), 
    opis varchar(100), 
    wyplata DECIMAL(6,2));

-- 10. Tworzenie tabeli adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE adres( 
	id INT auto_increment PRIMARY KEY,
	ulica varchar(50), 
    kod_pocztowy varchar(6), 
    miasto varchar(30));

-- 11. Tworzenie tabeli pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE pracownik( 
	id INT auto_increment PRIMARY KEY,
	imie varchar(30), 
    nazwisko varchar(30),
    stanowisko_id INT,
    adres_id INT);
    
--     CONSTRAINT stanowisko_id FOREIGN KEY (id) REFERENCES stanowisko(id),
--     CONSTRAINT adres_id FOREIGN KEY (id) REFERENCES adres(id));


-- 12. Dodawanie danych testowych (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO pracownicy_zadanie.stanowisko(nazwa, opis, wyplata)
VALUES
('Engineer','Engineers apply the principles of science and mathematics to develop economical solutions to technical problems. ',2500.00),
('Staff', 'Office assistants handle organizational and clerical support tasks.',4000),
('Consulting', 'Specialist consultants have knowledge, and sometimes certifications, for a specific industry, or segment of a company.',3000),
('Director','The boss', 8000),
('Sales', 'The primary goal is to sell the company’s products, whether you work from a storefront or cover a territory.',3660);

INSERT INTO pracownicy_zadanie.adres(ulica, kod_pocztowy,miasto)
VALUES
('Konopnicka 1/3','30-199','Wroclaw'),
('Bema 22a','29-229','Wroclaw'),
('Trzebnicka 3/10','44-100', 'Legnica'),
('wyszynskiego 4','50-344','Opole');

INSERT INTO pracownicy_zadanie.pracownik(imie, nazwisko, stanowisko_id,adres_id)
VALUES
('Jan', 'Kowalski', '3','2'),
('Jadwiga', 'Kowalska','1','4'),
('Tamara', 'Tartak', '2','2'),
('Jan', 'Niemlak', '3','3'),
('Janusz', 'Hortex', '4','1');


-- 13.Pobieranie pełnych informacji o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT imie,nazwisko,ulica, kod_pocztowy, miasto, nazwa as Nazwa_stanowiska FROM pracownik p 
JOIN stanowisko s ON p.stanowisko_id = s.id
JOIN adres a ON p.adres_id = a.id;

-- 14. Obliczanie sumy wypłat dla wszystkich pracowników w firmie
SELECT sum(wyplata) FROM pracownik p 
JOIN stanowisko s ON p.stanowisko_id = s.id;

-- 15. Pobiera pracowników mieszkających w lokalizacji z wybranym kodem pocztowym 
SELECT * FROM pracownik p
JOIN adres a ON p.adres_id = a.id
WHERE kod_pocztowy='44-100';














