SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


CREATE TABLE `airport` (
  `ICAO` varbinary(8) NOT NULL,
  `IATA` varbinary(8) DEFAULT NULL,
  `GPS` varbinary(8) DEFAULT NULL,
  `LOCAL` varbinary(8) DEFAULT NULL,
  `name` varbinary(256) NOT NULL,
  `type` varbinary(32) NOT NULL,
  `restriction` varbinary(32) DEFAULT NULL,
  `tier` tinyint NOT NULL DEFAULT '0',
  `lat` double NOT NULL DEFAULT '0',
  `lon` double NOT NULL DEFAULT '0',
  `alt` double DEFAULT '0',
  `gmt_offset` int NOT NULL DEFAULT '0',
  `timezone` varbinary(32) DEFAULT NULL,
  `continent` varbinary(8) DEFAULT NULL,
  `country` varbinary(8) DEFAULT NULL,
  `region` varbinary(8) DEFAULT NULL,
  `municipality` varbinary(256) DEFAULT NULL,
  `activation` varbinary(32) DEFAULT NULL,
  `service` tinyint(1) NOT NULL DEFAULT '0',
  `home` blob,
  `wiki` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `continent` (
  `code` varbinary(2) NOT NULL,
  `name` varbinary(256) NOT NULL,
  `lat` double NOT NULL,
  `lon` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `country` (
  `code` varbinary(2) NOT NULL,
  `name` varbinary(256) NOT NULL,
  `continent` varbinary(2) DEFAULT NULL,
  `lat` double NOT NULL,
  `lon` double NOT NULL,
  `zoom` int NOT NULL DEFAULT '5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `frequency` (
  `_id` int NOT NULL,
  `airport` varbinary(8) NOT NULL,
  `type` varbinary(32) NOT NULL,
  `frequency` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `image` (
  `_id` int NOT NULL,
  `airport` varbinary(8) NOT NULL,
  `file` varbinary(256) DEFAULT NULL,
  `url` blob NOT NULL,
  `credits` blob,
  `_touched` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `metar` (
  `station` varbinary(8) NOT NULL,
  `raw` blob NOT NULL,
  `reported` datetime NOT NULL,
  `wx` varbinary(32) DEFAULT NULL,
  `temp` double NOT NULL,
  `dewp` double NOT NULL,
  `altim` double DEFAULT NULL,
  `altim_sea` double DEFAULT NULL,
  `wind_dir` int DEFAULT NULL,
  `wind_spd` int DEFAULT NULL,
  `wind_gust` int DEFAULT NULL,
  `precip` double NOT NULL DEFAULT '0',
  `snow` double NOT NULL DEFAULT '0',
  `vis_horiz` double DEFAULT NULL,
  `vis_vert` int DEFAULT NULL,
  `flight_cat` varbinary(8) DEFAULT NULL,
  `cloud_1_cover` varbinary(8) DEFAULT NULL,
  `cloud_1_base` int DEFAULT NULL,
  `cloud_2_cover` varbinary(8) DEFAULT NULL,
  `cloud_2_base` int DEFAULT NULL,
  `cloud_3_cover` varbinary(8) DEFAULT NULL,
  `cloud_3_base` int DEFAULT NULL,
  `cloud_4_cover` varbinary(8) DEFAULT NULL,
  `cloud_4_base` int DEFAULT NULL,
  `_touched` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `navaid` (
  `_id` int NOT NULL,
  `ident` varbinary(8) NOT NULL,
  `type` varbinary(16) NOT NULL,
  `name` varbinary(256) NOT NULL,
  `frequency` int NOT NULL,
  `lat` double NOT NULL,
  `lon` double NOT NULL,
  `alt` int NOT NULL DEFAULT '0',
  `country` varbinary(2) NOT NULL,
  `airport` varbinary(8) DEFAULT NULL,
  `level` varbinary(32) DEFAULT NULL,
  `power` varbinary(32) DEFAULT NULL,
  `dme_frequency` int DEFAULT NULL,
  `dme_channel` varbinary(32) DEFAULT NULL,
  `dme_lat` double DEFAULT NULL,
  `dme_lon` double DEFAULT NULL,
  `dme_alt` int DEFAULT NULL,
  `slaved_deg` double DEFAULT NULL,
  `magnetic_deg` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `region` (
  `code` varbinary(16) NOT NULL,
  `name` varbinary(256) DEFAULT NULL,
  `continent` varbinary(2) NOT NULL,
  `country` varbinary(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `runway` (
  `_id` int NOT NULL,
  `airport` varbinary(8) NOT NULL,
  `ident` varbinary(16) NOT NULL,
  `length` int DEFAULT NULL,
  `width` int DEFAULT NULL,
  `vertical` int DEFAULT NULL,
  `slope` double DEFAULT NULL,
  `surface` varbinary(8) NOT NULL,
  `inuse` tinyint(1) NOT NULL DEFAULT '0',
  `lighted` tinyint(1) NOT NULL DEFAULT '0',
  `l_ident` varbinary(8) DEFAULT NULL,
  `l_hdg` int DEFAULT NULL,
  `l_lat` double DEFAULT NULL,
  `l_lon` double DEFAULT NULL,
  `l_alt` int DEFAULT NULL,
  `l_dthr` int DEFAULT NULL,
  `r_ident` varbinary(8) DEFAULT NULL,
  `r_hdg` int DEFAULT NULL,
  `r_lat` double DEFAULT NULL,
  `r_lon` double DEFAULT NULL,
  `r_alt` int DEFAULT NULL,
  `r_dthr` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `sigmet` (
  `_id` int NOT NULL,
  `airport` varbinary(8) DEFAULT NULL,
  `fir` varbinary(32) DEFAULT NULL,
  `name` varbinary(256) DEFAULT NULL,
  `series` varbinary(32) DEFAULT NULL,
  `hazard` varbinary(32) NOT NULL,
  `qualifier` varbinary(32) DEFAULT NULL,
  `severity` int DEFAULT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime NOT NULL,
  `low_1` int DEFAULT NULL,
  `low_2` int DEFAULT NULL,
  `hi_1` int DEFAULT NULL,
  `hi_2` int DEFAULT NULL,
  `dir` varbinary(8) DEFAULT NULL,
  `spd` int DEFAULT NULL,
  `cng` varbinary(8) DEFAULT NULL,
  `raw` blob NOT NULL,
  `polygon` blob,
  `_touched` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `timezone` (
  `ident` varbinary(32) NOT NULL,
  `short` varbinary(32) NOT NULL,
  `gmt_offset` int NOT NULL,
  `name` varbinary(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


ALTER TABLE `airport`
  ADD PRIMARY KEY (`ICAO`),
  ADD KEY `IATA` (`IATA`),
  ADD KEY `GPS` (`GPS`),
  ADD KEY `LOCAL` (`LOCAL`),
  ADD KEY `name` (`name`),
  ADD KEY `type` (`type`),
  ADD KEY `continent` (`continent`),
  ADD KEY `country` (`country`),
  ADD KEY `region` (`region`),
  ADD KEY `restriction` (`restriction`),
  ADD KEY `tier` (`tier`),
  ADD KEY `timezone` (`timezone`);

ALTER TABLE `continent`
  ADD PRIMARY KEY (`code`);

ALTER TABLE `country`
  ADD PRIMARY KEY (`code`),
  ADD KEY `continent` (`continent`);

ALTER TABLE `frequency`
  ADD PRIMARY KEY (`_id`),
  ADD KEY `airport` (`airport`),
  ADD KEY `type` (`type`);

ALTER TABLE `image`
  ADD PRIMARY KEY (`_id`),
  ADD KEY `airport` (`airport`);

ALTER TABLE `metar`
  ADD PRIMARY KEY (`station`);

ALTER TABLE `navaid`
  ADD PRIMARY KEY (`_id`),
  ADD KEY `ident` (`ident`),
  ADD KEY `name` (`name`),
  ADD KEY `type` (`type`),
  ADD KEY `level` (`level`),
  ADD KEY `country` (`country`),
  ADD KEY `airport` (`airport`),
  ADD KEY `power` (`power`);

ALTER TABLE `region`
  ADD PRIMARY KEY (`code`),
  ADD KEY `continent` (`continent`),
  ADD KEY `country` (`country`);

ALTER TABLE `runway`
  ADD PRIMARY KEY (`_id`),
  ADD KEY `airport` (`airport`),
  ADD KEY `surface` (`surface`);

ALTER TABLE `sigmet`
  ADD PRIMARY KEY (`_id`),
  ADD KEY `airport` (`airport`),
  ADD KEY `hazard` (`hazard`);

ALTER TABLE `timezone`
  ADD PRIMARY KEY (`ident`),
  ADD UNIQUE KEY `timezone` (`short`,`gmt_offset`);


ALTER TABLE `frequency`
  MODIFY `_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `image`
  MODIFY `_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `navaid`
  MODIFY `_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `runway`
  MODIFY `_id` int NOT NULL AUTO_INCREMENT;


COMMIT;