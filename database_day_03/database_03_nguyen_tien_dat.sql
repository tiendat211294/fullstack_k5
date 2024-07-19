-- Tạo bảng PHONG
CREATE TABLE IF NOT EXISTS public."PHONG"
(
    "MaPhong" character varying COLLATE pg_catalog."default" NOT NULL,
    "LoaiPhong" character varying COLLATE pg_catalog."default" NOT NULL,
    "SoKhachToiDa" integer NOT NULL,
    "GiaPhong" integer NOT NULL,
    "MoTa" character varying COLLATE pg_catalog."default",
    CONSTRAINT "PHONG_pkey" PRIMARY KEY ("MaPhong")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."PHONG"
    OWNER to postgres;

-- Tạo bảng KHACH_HANG
CREATE TABLE IF NOT EXISTS public."KHACH_HANG"
(
    "MaKH" character varying COLLATE pg_catalog."default" NOT NULL,
    "TenKH" character varying COLLATE pg_catalog."default" NOT NULL,
    "DiaChi" character varying COLLATE pg_catalog."default" NOT NULL,
    "SoDT" character varying COLLATE pg_catalog."default",
    CONSTRAINT "KHACH_HANG_pkey" PRIMARY KEY ("MaKH")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."KHACH_HANG"
    OWNER to postgres;

-- Tạo bảng DICH_VU_DI_KEM
CREATE TABLE IF NOT EXISTS public."DICH_VU_DI_KEM"
(
    "MaDV" character varying COLLATE pg_catalog."default" NOT NULL,
    "TenDV" character varying COLLATE pg_catalog."default" NOT NULL,
    "DonViTinh" character varying COLLATE pg_catalog."default" NOT NULL,
    "DonGia" integer NOT NULL,
    CONSTRAINT "DICH_VU_DI_KEM_pkey" PRIMARY KEY ("MaDV")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."DICH_VU_DI_KEM"
    OWNER to postgres;

-- Tạo bảng DAT_PHONG
CREATE TABLE IF NOT EXISTS public."DAT_PHONG"
(
    "MaDatPhong" character varying COLLATE pg_catalog."default" NOT NULL,
    "MaPhong" character varying COLLATE pg_catalog."default" NOT NULL,
    "MaKH" character varying COLLATE pg_catalog."default" NOT NULL,
    "NgayDat" date NOT NULL,
    "GioBatDau" time without time zone NOT NULL,
    "GioKetThuc" time without time zone NOT NULL,
    "TienDatCoc" integer,
    "GhiChu" character varying COLLATE pg_catalog."default",
    "TrangThaiDat" boolean NOT NULL DEFAULT true,
    CONSTRAINT "DAT_PHONG_pkey" PRIMARY KEY ("MaDatPhong"),
    CONSTRAINT "DAT_PHONG_MaKH_foreign" FOREIGN KEY ("MaKH")
        REFERENCES public."KHACH_HANG" ("MaKH") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "DAT_PHONG_MaPhong_foreign" FOREIGN KEY ("MaPhong")
        REFERENCES public."PHONG" ("MaPhong") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."DAT_PHONG"
    OWNER to postgres;

-- Tạo bảng CHI_TIET_SU_DUNG_DICH_VU
CREATE TABLE IF NOT EXISTS public."CHI_TIET_SU_DUNG_DICH_VU"
(
    "MaDatPhong" character varying COLLATE pg_catalog."default" NOT NULL,
    "MaDV" character varying COLLATE pg_catalog."default" NOT NULL,
    "SoLuong" integer NOT NULL,
    CONSTRAINT "CHI_TIET_SU_DUNG_DICH_VU_MaDV_foreign" FOREIGN KEY ("MaDV")
        REFERENCES public."DICH_VU_DI_KEM" ("MaDV") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "CHI_TIET_SU_DUNG_DICH_VU_MaDatPhong_foreign" FOREIGN KEY ("MaDatPhong")
        REFERENCES public."DAT_PHONG" ("MaDatPhong") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."CHI_TIET_SU_DUNG_DICH_VU"
    OWNER to postgres;

-- Thêm dữ liệu bảng
INSERT INTO public."PHONG"(
	"MaPhong", "LoaiPhong", "SoKhachToiDa", "GiaPhong", "MoTa")
	VALUES 
	('P0001','Loai 1', 20, 60000,''),
	('P0002','Loai 1', 25, 80000,''),
	('P0003','Loai 2', 15, 50000,''),
	('P0004','Loai 3', 20, 50000,'')

INSERT INTO public."KHACH_HANG"(
	"MaKH", "TenKH", "DiaChi", "SoDT")
	VALUES 
	('KH0001','Nguyen Van A','Hoa Xuan','111111111'),
	('KH0002','Nguyen Van B','Hoa Hai','111111112'),
	('KH0003','Phan Van A','Cam Le','111111113'),
	('KH0004','Phan Van B','Hoa Xuan','111111114')

INSERT INTO public."DICH_VU_DI_KEM"(
	"MaDV", "TenDV", "DonViTinh", "DonGia")
	VALUES 
	('DV001','Beer','Lon',10000),
	('DV002','Nuoc ngot','lon',8000),
	('DV003','Trai cay','dia',35000),
	('DV004','Khan uot','Cai',2000)

INSERT INTO public."DAT_PHONG"(
	"MaDatPhong", "MaPhong", "MaKH", "NgayDat", "GioBatDau", "GioKetThuc", "TienDatCoc", "GhiChu", "TrangThaiDat")
	VALUES 
	('DP0001','P0001','KH0002','2018-03-26','11:00','13:30',100000,'',true),
	('DP0002','P0001','KH0003','2018-03-27','17:15','19:15',50000,'',false),
	('DP0003','P0002','KH0002','2018-03-26','20:30','22:15',100000,'',true),
	('DP0004','P0003','KH0001','2018-04-01','19:30','21:15',200000,'',true)

INSERT INTO public."CHI_TIET_SU_DUNG_DICH_VU"(
	"MaDatPhong", "MaDV", "SoLuong")
	VALUES 
	('DP0001','DV001',20),
	('DP0001','DV003',3),
	('DP0001','DV002',10),
	('DP0002','DV002',10),
	('DP0002','DV003',1),
	('DP0003','DV003',2),
	('DP0003','DV004',10)

-- Câu 1

SELECT "DAT_PHONG"."MaDatPhong", "DAT_PHONG"."MaPhong", "PHONG"."LoaiPhong", "PHONG"."GiaPhong","KHACH_HANG"."TenKH",
	"DAT_PHONG"."NgayDat", ("PHONG"."GiaPhong"*EXTRACT(HOUR FROM("DAT_PHONG"."GioKetThuc" - "DAT_PHONG"."GioBatDau"))) AS "TongTienHat",
	(CASE 
	WHEN SUM("CHI_TIET_SU_DUNG_DICH_VU"."SoLuong" * "DICH_VU_DI_KEM"."DonGia") IS Null THEN 0
	ELSE SUM("CHI_TIET_SU_DUNG_DICH_VU"."SoLuong" * "DICH_VU_DI_KEM"."DonGia")
	END)
	AS "TongTienSuDungDichVu", 
	(("PHONG"."GiaPhong"*EXTRACT(HOUR FROM("DAT_PHONG"."GioKetThuc" - "DAT_PHONG"."GioBatDau")))+
	(CASE 
	WHEN SUM("CHI_TIET_SU_DUNG_DICH_VU"."SoLuong" * "DICH_VU_DI_KEM"."DonGia") IS Null THEN 0
	ELSE SUM("CHI_TIET_SU_DUNG_DICH_VU"."SoLuong" * "DICH_VU_DI_KEM"."DonGia")
	END)) AS "TongTienThanhToan"
FROM "DAT_PHONG"
INNER JOIN "PHONG"
ON "DAT_PHONG"."MaPhong" = "PHONG"."MaPhong"
INNER JOIN "KHACH_HANG"
ON "DAT_PHONG"."MaKH" = "KHACH_HANG"."MaKH"
LEFT JOIN "CHI_TIET_SU_DUNG_DICH_VU"
ON "DAT_PHONG"."MaDatPhong"="CHI_TIET_SU_DUNG_DICH_VU"."MaDatPhong"
LEFT JOIN "DICH_VU_DI_KEM"
ON "CHI_TIET_SU_DUNG_DICH_VU"."MaDV"="DICH_VU_DI_KEM"."MaDV"
WHERE "DAT_PHONG"."TrangThaiDat"=true	
GROUP BY "DAT_PHONG"."MaDatPhong","PHONG"."LoaiPhong","KHACH_HANG"."TenKH","PHONG"."GiaPhong"


-- Câu 2



-- Câu 3













