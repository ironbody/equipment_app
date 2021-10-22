CREATE TABLE equipment (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    description TEXT    NOT NULL,
    serial      TEXT    NOT NULL,
    deviceType  TEXT    NOT NULL,
    duration    INTEGER NOT NULL
);

INSERT INTO equipment (
    name, description, serial, deviceType, duration
) VALUES 
(
    "TEST",
    "TESTTESTTEST",
    "ABC123",
    "other",
    7
),
(
    "TEST2",
    "TESTTESTTEST",
    "ABC1232",
    "other",
    7
);

CREATE TABLE users (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    email       TEXT    NOT NULL,
    password    TEXT    NOT NULL,
    priviledges INTEGER NOT NULL
);

INSERT INTO users (
    name, email, password, priviledges
) VALUES (
    "superuser",
    "superuser@bth.se",
    "super",
    0
);

CREATE TABLE bookings (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    equipmentId     INTEGER NOT NULL,
    userId          INTEGER NOT NULL,
    startDate       TEXT    NOT NULL,
    endDate         TEXT    NOT NULL,
    returned        INTEGER DEFAULT 0,
    FOREIGN KEY(equipmentId) REFERENCES equipment(id),
    FOREIGN KEY(userId) REFERENCES users(id)
);

CREATE VIEW v_equipment 
AS
SELECT
    e.id,
    e.name,
    e.description,
    e.serial,
    e.deviceType,
    e.duration,
    b.id as bookingId,
    b.startDate,
    b.endDate
FROM equipment as e
  JOIN bookings as b
    ON e.id = b.equipmentId
GROUP BY e.id
ORDER BY e.name,b.id DESC
;
