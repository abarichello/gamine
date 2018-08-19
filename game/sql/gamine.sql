CREATE TABLE IF NOT EXISTS user (
    id              SERIAL          PRIMARY KEY,
    nickname        TEXT            DEFAULT "null",
    nickname_set    BOOLEAN         NOT NULL DEFAULT 0
);
