-- =====================================================
-- UTS Manajemen Basis Data - Soal 4
-- Membuat user dan hak akses
-- Jalankan sebagai user postgres
-- =====================================================

-- 1. Buat user
CREATE ROLE backend_dev   LOGIN PASSWORD 'backend123';
CREATE ROLE bi_dev        LOGIN PASSWORD 'bi123';
CREATE ROLE data_engineer LOGIN PASSWORD 'engineer123';

-- 2. Izin masuk database
GRANT CONNECT ON DATABASE postgres TO backend_dev, bi_dev, data_engineer;

-- 3. data_engineer menjadi pemilik skema dan tabel (boleh CREATE, ALTER, DROP)
ALTER SCHEMA salam OWNER TO data_engineer;
ALTER TABLE salam.mahasiswas OWNER TO data_engineer;

-- 4. backend_dev: CRUD semua tabel
GRANT USAGE ON SCHEMA salam TO backend_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA salam TO backend_dev;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA salam TO backend_dev;

-- 5. bi_dev: hanya baca
GRANT USAGE ON SCHEMA salam TO bi_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA salam TO bi_dev;

-- 6. Berlaku juga untuk tabel baru yang dibuat data_engineer
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA salam
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA salam
  GRANT SELECT ON TABLES TO bi_dev;
ALTER DEFAULT PRIVILEGES FOR ROLE data_engineer IN SCHEMA salam
  GRANT USAGE, SELECT ON SEQUENCES TO backend_dev;

-- 7. Verifikasi user
SELECT rolname, rolcanlogin FROM pg_roles
WHERE rolname IN ('backend_dev', 'bi_dev', 'data_engineer');