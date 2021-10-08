CREATE TABLE User (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    senha      TEXT,
    email       TEXT,
    name        TEXT
);

CREATE TABLE Nota (
    id      INTEGER  PRIMARY KEY AUTOINCREMENT,
    titulo  TEXT,
    desc    TEXT,
    cor     TEXT,
    date    TEXT,
    user_id REFERENCES User(id)
);
