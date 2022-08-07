-- gts.TrackLog definition

CREATE TABLE `TrackLog` (
  `posicionId` int(11) NOT NULL AUTO_INCREMENT,
  `vehiculoId` varchar(24) NOT NULL DEFAULT '',
  `velocidad` int(10) DEFAULT NULL,
  `satelites` smallint(5) DEFAULT NULL,
  `rumbo` double DEFAULT NULL,
  `latitud` double DEFAULT NULL,
  `longitud` double DEFAULT NULL,
  `altitud` double DEFAULT NULL,
  `gpsDate` varchar(50) DEFAULT NULL,
  `gpsTime` varchar(50) DEFAULT NULL,
  `statusCode` int(11) DEFAULT NULL,
  `ignition` int(11) DEFAULT NULL,
  `odometro` double DEFAULT NULL,
  `horometro` double DEFAULT NULL,
  `nivelBateria` double DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`posicionId`,`vehiculoId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

IF (instr(@agente, 'TKL') > 0) THEN
	set @gpsDate = date_format(from_unixtime(@newTimestamp), '%Y-%m-%d');
		set @gpsTime = date_format(from_unixtime(@newTimestamp), '%H:%i:%s');
		set @newEngineHours = new.engineHours;
		set @newBatteryLevel = new.batteryLevel;
		set @newSatelliteCount = new.satelliteCount;
		INSERT INTO TrackLog (vehiculoId, velocidad, satelites, rumbo, latitud, longitud, altitud, gpsDate, gpsTime, statusCode, ignition, odometro, horometro, nivelBateria, estado)
		VALUES (@newLicensePlate, round(@newSpeed,0),@newSatelliteCount,round(@newHeading,0),format(@newLatitude,5), format(@newLongitude,5),round(@newAltitude,0),@gpsDate,@gpsTime,@newStatusCode,1,round(@newOdometerKM,0),round(@newEngineHours,0),round(@newBatteryLevel,0),'Nuevo');
END IF;