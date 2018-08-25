CREATE TABLE IF NOT EXISTS user (
    id              SERIAL          PRIMARY KEY,
    nickname        TEXT            DEFAULT "null",
    nickname_set    BOOLEAN         NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS scores (
    id              SERIAL          PRIMARY KEY,
    score           REAL            NOT NULL DEFAULT 0,
    type            TEXT            NOT NULL
);
