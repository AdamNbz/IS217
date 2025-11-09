CREATE TABLE [DIM_MODEL] (
    [model_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [model_name] VARCHAR(50),
);

CREATE TABLE [DIM_FUEL] (
    [fuel_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [fuel_type] VARCHAR(50),
);

CREATE TABLE [DIM_BRAND] (
    [brand_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [brand_name] VARCHAR(50),
);

CREATE TABLE [DIM_YEAR] (
    [year_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [manufacture_year] VARCHAR(50),
);

CREATE TABLE [DIM_ENGINE] (
    [engine_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [engine_type] VARCHAR(50),
);

CREATE TABLE [DIM_AGE_BUCKET] (
    [age_bucket_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [age_bucket_label] VARCHAR(50),
    [age_bucket_order] VARCHAR(50),
    [min_age] VARCHAR(50),
    [max_age] VARCHAR(50),
);

CREATE TABLE [DIM_MILEAGE_BUCKET] (
    [mileage_bucket_id] INT IDENTITY(1, 1) PRIMARY KEY,
    [mileage_bucket_label] VARCHAR(50),
    [mileage_bucket_order] VARCHAR(50),
    [min_km] VARCHAR(50),
    [max_km] VARCHAR(50),
);

CREATE TABLE [FACT_CAR_LISTING] (
    [listing_id] BIGINT IDENTITY(1, 1) PRIMARY KEY,
    [brand_id] INT NOT NULL,
    [model_id] INT NOT NULL,
    [fuel_id] INT NOT NULL,
    [engine_id] INT NOT NULL,
    [year_id] INT NOT NULL,
    [mileage_bucket_id] INT NOT NULL,
    [age_bucket_id] INT NOT NULL,
    [price_usd] DECIMAL(12, 2) NOT NULL,
    [mileage_km] INT NOT NULL,
    [age] INT NOT NULL,
    [price_per_1k_km] DECIMAL(12, 2),
    [overprice_threshold] FLOAT,
    [is_overpriced] BIT,
    [ingest_dt] DATETIME DEFAULT(GETDATE()),
);

ALTER TABLE [FACT_CAR_LISTING]
ADD CONSTRAINT FK_Fact_Brand FOREIGN KEY ([brand_id]) REFERENCES [DIM_BRAND]([brand_id]);

ALTER TABLE [FACT_CAR_LISTING]
ADD CONSTRAINT FK_Fact_Model FOREIGN KEY ([model_id]) REFERENCES [DIM_MODEL]([model_id]);

ALTER TABLE [FACT_CAR_LISTING]
ADD CONSTRAINT FK_Fact_Fuel FOREIGN KEY ([fuel_id]) REFERENCES [DIM_FUEL]([fuel_id]);

ALTER TABLE [FACT_CAR_LISTING]
ADD CONSTRAINT FK_Fact_Engine FOREIGN KEY ([engine_id]) REFERENCES [DIM_ENGINE]([engine_id]);

ALTER TABLE [FACT_CAR_LISTING]
ADD CONSTRAINT FK_Fact_Year FOREIGN KEY ([year_id]) REFERENCES [DIM_YEAR]([year_id]);

ALTER TABLE [FACT_CAR_LISTING]
ADD CONSTRAINT FK_Fact_Mileage FOREIGN KEY ([mileage_bucket_id]) REFERENCES [DIM_MILEAGE_BUCKET]([mileage_bucket_id]);

ALTER TABLE [FACT_CAR_LISTING]
ADD CONSTRAINT FK_Fact_Age FOREIGN KEY ([age_bucket_id]) REFERENCES [DIM_AGE_BUCKET]([age_bucket_id]);


IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Fact_Brand')
    ALTER TABLE [FACT_CAR_LISTING] DROP CONSTRAINT FK_Fact_Brand;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Fact_Model')
    ALTER TABLE [FACT_CAR_LISTING] DROP CONSTRAINT FK_Fact_Model;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Fact_Fuel')
    ALTER TABLE [FACT_CAR_LISTING] DROP CONSTRAINT FK_Fact_Fuel;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Fact_Engine')
    ALTER TABLE [FACT_CAR_LISTING] DROP CONSTRAINT FK_Fact_Engine;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Fact_Year')
    ALTER TABLE [FACT_CAR_LISTING] DROP CONSTRAINT FK_Fact_Year;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Fact_Mileage')
    ALTER TABLE [FACT_CAR_LISTING] DROP CONSTRAINT FK_Fact_Mileage;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Fact_Age')
    ALTER TABLE [FACT_CAR_LISTING] DROP CONSTRAINT FK_Fact_Age;



TRUNCATE TABLE [FACT_CAR_LISTING];

TRUNCATE TABLE [DIM_BRAND];
TRUNCATE TABLE [DIM_MODEL];
TRUNCATE TABLE [DIM_FUEL];
TRUNCATE TABLE [DIM_ENGINE];
TRUNCATE TABLE [DIM_YEAR];
TRUNCATE TABLE [DIM_MILEAGE_BUCKET];
TRUNCATE TABLE [DIM_AGE_BUCKET];
