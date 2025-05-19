CREATE TABLE `clase` (
  `id` INT AUTO_INCREMENT NOT NULL COMMENT 'Id Clases' ,
  `clase_nombre` VARCHAR(100) NOT NULL COMMENT 'Nombres de Clases' ,
  `duracion` TIME NOT NULL COMMENT 'Duracion de la Clase' ,
  `id_sala` INT NOT NULL,
  `id_horario` INT NOT NULL,
  `id_monitor` INT NOT NULL,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB
COMMENT = 'Tabla de las Clases';
CREATE TABLE `horario_clase` (
  `id` INT AUTO_INCREMENT NOT NULL COMMENT 'Id horario de clase' ,
  `id_clase` INT NOT NULL COMMENT 'Id tabla clases' ,
  `fecha` DATE NOT NULL COMMENT 'Fecha de inicio de clase ' ,
  `hora_inicio` TIMESTAMP NOT NULL DEFAULT 'current_timestamp()'  COMMENT 'inicio de clase' ,
  `hora_fin` TIMESTAMP NOT NULL DEFAULT '\'0000-00-00 00:00:00''  COMMENT 'fin de la clase ' ,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
CREATE TABLE `pagos` (
  `id` INT AUTO_INCREMENT NOT NULL,
  `precio` DECIMAL(10,0) NULL DEFAULT NULL ,
  `fecha_pago` DATE NULL DEFAULT NULL ,
  `metodo_pago` ENUM('tarjeta','efectivo','transferencia') NULL DEFAULT NULL ,
  `id_usuarios` INT NULL DEFAULT NULL ,
  `id_suscripcion` INT NOT NULL,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
CREATE TABLE `plan_pagos` (
  `id` INT AUTO_INCREMENT NOT NULL,
  `plan_pago` TEXT NOT NULL,
  `precio` INT NOT NULL,
  `duracion_dias` INT NOT NULL,
  `acceso_clases` TINYINT NOT NULL,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
CREATE TABLE `reservas_clase` (
  `id` INT AUTO_INCREMENT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha_reserva` DATETIME NOT NULL,
  `id_reserva` INT NOT NULL,
  `id_clase` INT NOT NULL,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
CREATE TABLE `roles` (
  `id` INT AUTO_INCREMENT NOT NULL,
  `rol_name` VARCHAR(250) NOT NULL,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
CREATE TABLE `salas` (
  `id` INT AUTO_INCREMENT NOT NULL COMMENT 'id salas ' ,
  `nombre_sala` VARCHAR(250) NOT NULL COMMENT 'nombre de la sala' ,
  `aforo` INT NOT NULL,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB
COMMENT = 'salas ';
CREATE TABLE `suscripciones` (
  `id` INT AUTO_INCREMENT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `estado` INT NOT NULL,
  `id_plan` INT NULL DEFAULT NULL ,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
CREATE TABLE `usuarios` (
  `id` INT AUTO_INCREMENT NOT NULL,
  `nombre` VARCHAR(250) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `telefono` INT NOT NULL,
  `id_reserva` INT NULL DEFAULT NULL ,
  `id_rol` INT NOT NULL,
  `id_suscripcion` INT NOT NULL,
   PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
ALTER TABLE `clase` ADD CONSTRAINT `id_horario` FOREIGN KEY (`id_horario`) REFERENCES `horario_clase` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `clase` ADD CONSTRAINT `id_monitor` FOREIGN KEY (`id_monitor`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `clase` ADD CONSTRAINT `id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `pagos` ADD CONSTRAINT `fkid_suscripcion` FOREIGN KEY (`id_suscripcion`) REFERENCES `suscripciones` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `pagos` ADD CONSTRAINT `id_usuarios` FOREIGN KEY (`id_usuarios`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `reservas_clase` ADD CONSTRAINT `id_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `suscripciones` ADD CONSTRAINT `id_plan` FOREIGN KEY (`id_plan`) REFERENCES `plan_pagos` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `usuarios` ADD CONSTRAINT `id_suscripcion` FOREIGN KEY (`id_suscripcion`) REFERENCES `suscripciones` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `usuarios` ADD CONSTRAINT `id_reserva` FOREIGN KEY (`id_reserva`) REFERENCES `reservas_clase` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `usuarios` ADD CONSTRAINT `id_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
