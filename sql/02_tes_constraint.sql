-- =====================================================
-- UTS Manajemen Basis Data - Soal 3
-- Bukti constraint bekerja (semua perintah di bawah HARUS ERROR)
-- Jalankan satu per satu (Ctrl+Enter), bukan sekaligus
-- =====================================================

-- Tes 1: UNIQUE (NIM kembar)
INSERT INTO salam.mahasiswas (nim, nama, email, semester, ipk)
VALUES ('1247050050', 'Budi', 'budi@mail.com', 3, 3.20);

-- Tes 2: CHECK IPK (di luar 0 - 4)
INSERT INTO salam.mahasiswas (nim, nama, email, semester, ipk)
VALUES ('999999', 'Citra', 'citra@mail.com', 3, 5.00);

-- Tes 3: CHECK semester (di luar 1 - 14)
INSERT INTO salam.mahasiswas (nim, nama, email, semester, ipk)
VALUES ('888888', 'Dina', 'dina@mail.com', 20, 3.00);

-- Tes 4: PRIMARY KEY (id kembar, memakai id milik Alden)
INSERT INTO salam.mahasiswas (id, nim, nama, email, semester, ipk)
VALUES (
    (SELECT id FROM salam.mahasiswas WHERE nim = '1247050050'),
    '777777', 'Eko', 'eko@mail.com', 3, 3.00
);