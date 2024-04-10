-- Crear la base de datos Coworking
CREATE DATABASE Pruebas;

-- Seleccionar la base de datos Coworking
USE Pruebas;

-- Crear la tabla availability
CREATE TABLE availability(
    availlability_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    available_desks INTEGER,
    available_meeting_rooms INTEGER
);

-- Crear la tabla dateSpace
CREATE TABLE date_space(
    date_Space_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    effective_Date DATE,
    end_date DATE
);

-- Crear la tabla Locaciones
CREATE TABLE location (
    location_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name_location VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(100),
    postal_code INTEGER,
    availlability_id INTEGER,
    foreign key(availlability_id) references availability(availlability_id)
);

-- Crear la tabla priceSpace
CREATE TABLE price_space (
    price_space_id INT PRIMARY KEY AUTO_INCREMENT,
    hourly_rate DECIMAL(10, 2),
    daily_rate DECIMAL(10, 2),
    monthly_rate DECIMAL(10, 2),
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- Crear la tabla dateRol
CREATE TABLE date_rol(
    date_rol_id INTEGER  not null AUTO_INCREMENT PRIMARY KEY,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_modified_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla equipment
CREATE TABLE equipmment(
    equipmment_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    name_equipmment VARCHAR(100),
    description VARCHAR(500),
    quantity INTEGER,
    availability integer
);

-- Crear la tabla Rol
CREATE TABLE rol(
    rol_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50),
    descripcion VARCHAR(500),
    permisions VARCHAR(200),
    access_level INTEGER,
    manage_rol_id INTEGER,
    date_rol_id INTEGER,
    FOREIGN KEY (date_rol_id) REFERENCES date_rol(date_rol_id)
);

CREATE TABLE usuario(
    user_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    password VARCHAR(20),
    email VARCHAR(150),
    register_date DATE,
	estado varchar(100),
    rol_id INTEGER,
    comment_id INTEGER,
    FOREIGN KEY (rol_id) REFERENCES rol(rol_id)
);

-- Crear la tabla dateReservation
CREATE TABLE date_reservation(
    date_time_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    date_start DATE,
    hour_start TIME,
    date_end DATE,
    hour_end TIME
);

-- Crear la tabla manageRol
CREATE TABLE manage_rol(
    manage_rol_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    rol_id INTEGER,
    accion VARCHAR(70),
    user_id INTEGER,
    action_date DATE,
    FOREIGN KEY (rol_id) REFERENCES rol(rol_id),
    FOREIGN KEY (user_id) REFERENCES usuario(user_id)
);

-- Crear la tabla reservation sin la restricción de clave externa hacia coworkingSpace
CREATE TABLE reservation(
    reservation_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER,
    coworking_space_id INTEGER,
    date_time_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES usuario(user_id),
    FOREIGN KEY (date_time_id) REFERENCES date_reservation(date_time_id)
);

-- Crear la tabla coworkingSpace
CREATE TABLE coworking_space (
    coworking_space_id INT PRIMARY KEY AUTO_INCREMENT,
    space_name VARCHAR(255),
    descripcion varchar(500),
	num_person integer,
    price_space_id INTEGER,
    location_id INTEGER,
    equipmment_id integer,
    manage_rol_id integer,
    reservation_id integer,
    FOREIGN KEY (price_space_id) REFERENCES price_space(price_space_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id),
    foreign key (equipmment_id) references equipmment(equipmment_id),
    foreign key (manage_rol_id) references manage_rol(manage_rol_id),
    foreign key (reservation_id) references reservation(reservation_id)
);

-- Agregar la llave foranea a reservation 
ALTER TABLE reservation
ADD FOREIGN KEY (coworking_space_id) REFERENCES coworking_space(coworking_space_id);

CREATE TABLE card_info (
    card_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER ,
    card_number VARCHAR(16),
    expiration_date DATE,
    cvv INTEGER,
    last_four_digits VARCHAR(4),
    FOREIGN KEY (user_id) REFERENCES usuario(user_id)
);

create table card_info(
card_info_id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
card_number varchar(16),
expiration_date date,
cvv integer,
last_four_digits VARCHAR(4),
user_id integer,
foreign key (user_id) references usuario(user_id)
);

CREATE TABLE payment_method(
	payment_method_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    type ENUM('Tarjeta', 'PayPal') NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    card_info_id integer,
    foreign key (card_info_id) references card_info(card_info_id)
);

-- Crear la tabla comentarios
CREATE TABLE comment(
    comment_id INTEGER not null AUTO_INCREMENT PRIMARY KEY,
    comment VARCHAR(500),
    date_comment DATE,
	user_id INTEGER,
    coworking_space_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES usuario(user_id),
    FOREIGN KEY (coworking_space_id) REFERENCES coworking_space(coworking_space_id)
);

ALTER TABLE usuario
ADD FOREIGN KEY (comment_id) REFERENCES comment(comment_id);

-- Definir la base de datos a utilizar
USE Pruebas;

-- Insertar datos en la tabla availability
INSERT INTO availability (availableDesks, AvailableMeetingRooms) VALUES ("15", "4");

-- Insertar datos en la tabla dateSpace
INSERT INTO dateSpace (effectiveDate, endDate) VALUES ("2024-02-25", "2024-03-15");

-- Insertar datos en la tabla location
INSERT INTO location (nameLocation, address, city, postalCode) VALUES ("Conexion", "Calle de oro", "soyapango", "554");
INSERT INTO location (nameLocation, address, city, postalCode) VALUES ("The Commons", "Upper East Side", "New York City", "698");
INSERT INTO location (nameLocation, address, city, postalCode) VALUES ("Union Cowork", "Arts District", "Los Angeles", "396");


-- Insertar datos en la tabla pricespace
INSERT INTO pricespace (hourlyRate, dailyRate, monthlyRate, idLocation) VALUES ("10", "90", "500", 1);
INSERT INTO pricespace (hourlyRate, dailyRate, monthlyRate, idLocation) VALUES ("20", "100", "700", 2);
INSERT INTO pricespace (hourlyRate, dailyRate, monthlyRate, idLocation) VALUES ("50", "230", "1500", 3);


-- Insertar datos en la tabla daterol
INSERT INTO daterol (creationDate, lastModifiedDate) VALUES ("2024-03-20", "2024-04-02");

-- Insertar datos en la tabla equipment
INSERT INTO equipment (equipmentName, description, quantity, availability) VALUES ("Computadoras", "Son computadoras muy buenas", "15", "6");

-- Insertar datos en la tabla Rol
INSERT INTO Rol (rolName, descripcion, permisions, accessLevel, idDateRol) VALUES ("Administrador", "Usuario que puede modificar diferentes campos", "todas", "3", 1);

-- Insertar datos en la tabla usuario
INSERT INTO usuario (firstName, lastName, contraseña, email, registerDate, estado ,idRol) VALUES ("Juan", "Perez", "1234", "juan123@gmail.com", "2024-01-12", "Activo", 1);

-- Insertar datos en la tabla datereservation
INSERT INTO datereservation (dateStart, hourStart, dateEnd, hourEnd) VALUES ("2024-02-06", "12:20:00", "2024-03-08", "14:30:00");

-- Insertar datos en la tabla managerol
INSERT INTO managerol (idRol, accion, idUser, actionDate) VALUES (1, "Cambio de datos de usuario", 1, "2024-02-09");

-- Insertar datos en la tabla Services
INSERT INTO services (serviceName) values ("Escritorio para trabajo de front-End");

-- Insertar datos en la tabla coworkingspace
INSERT INTO coworkingspace (spaceName, Descripcion, numPerson, idPrice, idLocation) VALUES ("Sala de reuniones", "Sala para reuniones laborales", 8, 1, 1);
INSERT INTO coworkingspace (spaceName, Descripcion, numPerson, idPrice, idLocation) VALUES ("The Commons", "Un entorno productivo donde las nuevas empresas, los emprendedores y los trabajadores remotos pueden trabajar, reunirse y colaborar.", 4, 2, 2);
INSERT INTO coworkingspace (spaceName, Descripcion, numPerson, idPrice, idLocation) VALUES ("Union Cowork", "El ambiente energizante y la estética cautivadora del espacio lo inspirarán a realizar sus tareas con entusiasmo.", 3, 3, 3);


-- Insertar datos en la tabla space_services
INSERT INTO space_services (idSpace, idService) values (1, 1);

-- Insertar datos en la tabla reservation, asegurándote de usar un idSpace válido
INSERT INTO reservation (idUser, idDateTime, idSpace) VALUES (1, 1, 1);

-- Insertar datos en la tabla comentarios
INSERT INTO comentarios (idUser, idSpace, comentario, dateComment) VALUES (1, 1, "El lugar era muy bueno", "2024-03-05");