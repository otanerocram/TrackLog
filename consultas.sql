# Table
CREATE TABLE `Comsatel` (
  `posicionId` int(11) NOT NULL AUTO_INCREMENT,
  `vehiculoId` varchar(24) NOT NULL DEFAULT '',
  `velocidad` int(10) DEFAULT NULL,
  `satelites` smallint(5) DEFAULT NULL,
  `rumbo` double DEFAULT NULL,
  `latitud` double DEFAULT NULL,
  `longitud` double DEFAULT NULL,
  `altitud` double DEFAULT NULL,
  `gpsDateTime` varchar(50) DEFAULT NULL,
  `statusCode` int(11) DEFAULT NULL,
  `ignition` int(11) DEFAULT NULL,
  `odometro` double DEFAULT NULL,
  `horometro` double DEFAULT NULL,
  `nivelBateria` double DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`posicionId`,`vehiculoId`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;



#Trigger:

DECLARE evento INT DEFAULT 47;
DECLARE saveEvent INT DEFAULT 0;
set @newAccountID = new.accountID;
set @newDeviceID = new.deviceID;
set @newTimestamp = new.timestamp;
set @newStatusCode = new.`statusCode`;
set @newLatitude = format(new.latitude,5);
set @newLongitude = format(new.longitude,5);
set @newHeading = format(new.heading,0);
set @newSpeed = format(new.speedKPH,2);
set @fromUnixTime = date_format(from_unixtime(@newTimestamp), '%Y-%m-%d %H:%i:%s');
set @newAltitude 	= new.altitude;
set @newAddress = new.address;
set @newGeozoneID = new.geozoneID;
set @newLicensePlate=(SELECT licensePlate FROM Device WHERE `accountID`=@newAccountID AND `deviceID`=@newDeviceID);
set @agente = (SELECT `customAttributes` FROM Device WHERE `accountID`=@newAccountID AND `deviceID`=@newDeviceID);
set @empresa = (SELECT `groupID` FROM Device WHERE  `accountID`=@newAccountID AND `deviceID`=@newDeviceID);
set @newOdometerKM = round(new.odometerKM,2);
set @description = (SELECT description FROM Device WHERE accountID=@newAccountID AND deviceID=@newDeviceID);
set @newSatelliteCount = new.satelliteCount;
set @newEngineHours = new.engineHours;
set @newBatteryLevel = new.batteryLevel;

IF (instr(@agente, 'CST') > 0) THEN
	set @gpsDateTime = date_format(from_unixtime(@newTimestamp+18000), '%Y%m%d%H%i%s');
	INSERT INTO Comsatel (vehiculoId, velocidad, satelites, rumbo, latitud, longitud, altitud, gpsDateTime, statusCode, ignition, odometro, horometro, nivelBateria, estado)
	VALUES (@newLicensePlate, round(@newSpeed,0), @newSatelliteCount, round(@newHeading,0), format(@newLatitude,5), format(@newLongitude,5), round(@newAltitude,0), @gpsDateTime, @newStatusCode, 1, round(@newOdometerKM,0), round(@newEngineHours,0), round(@newBatteryLevel, 0),'Nuevo');
END IF;


# Consulta
SELECT `posicionId`, `vehiculoId`, `velocidad`, `satelites`, `rumbo`, `latitud`, `longitud`, `altitud`, `gpsDateTime`, `statusCode`, `ignition`, `odometro`, `horometro`, `nivelBateria`, `estado` FROM `Comsatel` WHERE `estado`='Nuevo' ORDER BY `vehiculoId`, `posicionId` DESC LIMIT 100;


