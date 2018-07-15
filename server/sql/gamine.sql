CREATE TABLE gamine (
    id              SERIAL          PRIMARY KEY,
    nickname        TEXT            NOT NULL,
    type            TEXT            NOT NULL,
    score           FLOAT           NOT NULL DEFAULT 0,
    added           TIMESTAMP       NOT NULL DEFAULT now()
);
