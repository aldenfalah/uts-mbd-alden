-- =====================================================
-- UTS Manajemen Basis Data - Soal 4
-- Bukti hak akses bekerja
-- Jalankan satu per satu (Ctrl+Enter) dan cek current_user dulu.
-- Lebih aman: login langsung sebagai user yang diuji.
-- =====================================================

-- ---------- A. bi_dev (hanya SELECT) ----------
SET ROLE bi_dev;
SELECT current_user;                      -- harus: bi_dev
SELECT * FROM salam.mahasiswas;           -- BERHASIL

INSERT INTO salam.mahasiswas (nim, nama, email, semester, ipk)
VALUES ('555555', 'Tes BI', 'bi@mail.com', 3, 3.00);   -- DITOLAK (permission denied)

DELETE FROM salam.mahasiswas WHERE nim = '1247050050'; -- DITOLAK (permission denied)

-- ---------- B. backend_dev (CRUD, tanpa ubah struktur) ----------
RESET ROLE;
SET ROLE backend_dev;
SELECT current_user;                      -- harus: backend_dev

INSERT INTO salam.mahasiswas (nim, nama, email, semester, ipk)
VALUES ('666666', 'Tes Backend', 'backend@mail.com', 3, 3.10);  -- BERHASIL

UPDATE salam.mahasiswas SET ipk = 3.40 WHERE nim = '666666';    -- BERHASIL
SELECT * FROM salam.mahasiswas;                                  -- BERHASIL
DELETE FROM salam.mahasiswas WHERE nim = '666666';               -- BERHASIL

CREATE TABLE salam.coba (id INT);         -- DITOLAK (permission denied for schema)
DROP TABLE salam.mahasiswas;              -- DITOLAK (must be owner of table)

-- ---------- C. data_engineer (CREATE, ALTER, DROP + CRUD) ----------
RESET ROLE;
SET ROLE data_engineer;
SELECT current_user;                      -- harus: data_engineer

CREATE TABLE salam.log_aktivitas (
    id        SERIAL PRIMARY KEY,
    aktivitas VARCHAR(100),
    waktu     TIMESTAMP DEFAULT NOW()
);                                                                -- BERHASIL

INSERT INTO salam.log_aktivitas (aktivitas) VALUES ('uji coba data_engineer');  -- BERHASIL
ALTER TABLE salam.log_aktivitas ADD COLUMN keterangan TEXT;       -- BERHASIL
SELECT * FROM salam.log_aktivitas;                                -- BERHASIL
DROP TABLE salam.log_aktivitas;                                   -- BERHASIL

-- ---------- Kembali ke postgres dan bersihkan data tes ----------
RESET ROLE;
DELETE FROM salam.mahasiswas WHERE nim IN ('555555', '666666', '777777');
SELECT id, nim, nama FROM salam.mahasiswas;   -- tinggal data Alden