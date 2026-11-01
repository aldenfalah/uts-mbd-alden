-- =====================================================
-- UTS Manajemen Basis Data - Soal 3
-- Skema SALAM dan tabel mahasiswas
-- =====================================================

CREATE SCHEMA salam;

CREATE TABLE salam.mahasiswas (
    id         SERIAL PRIMARY KEY,
    nim        VARCHAR(15)  NOT NULL UNIQUE,
    nama       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) UNIQUE,
    semester   INT CHECK (semester BETWEEN 1 AND 14),
    ipk        NUMERIC(3,2) CHECK (ipk BETWEEN 0 AND 4),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Data valid
INSERT INTO salam.mahasiswas (nim, nama, email, semester, ipk)
VALUES ('1247050050', 'Alden', 'aldenfalah26@gmail.com', 5, 3.50);

SELECT * FROM salam.mahasiswas;