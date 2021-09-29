CREATE TABLE equipment (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    description TEXT    NOT NULL,
    serial      TEXT    NOT NULL,
    deviceType  TEXT    NOT NULL,
    duration    INTEGER NOT NULL
)

CREATE TABLE users (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    email       TEXT    NOT NULL,
    password    TEXT    NOT NULL,
    priviledges INTEGER NOT NULL
)

CREATE TABLE bookings (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    equipmentId     INTEGER NOT NULL,
    userId          INTEGER NOT NULL,
    startDate       TEXT    NOT NULL,
    endDate         TEXT    NOT NULL,
    FOREIGN KEY(equipmentId) REFERENCES equipment(id),
    FOREIGN KEY(userId) REFERENCES users(id)
)