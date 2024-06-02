CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;


-- PREPARO ENTREGA
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240112120823_BaseInicialPreparoEntrega') THEN
    CREATE SEQUENCE "CodigoPedidoSequence" AS integer START WITH 1000 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240112120823_BaseInicialPreparoEntrega') THEN
    CREATE TABLE "PedidosPreparoEntrega" (
        "Id" uuid NOT NULL,
        "PedidoCorrelacaoId" uuid NOT NULL,
        "Codigo" integer NOT NULL,
        "Status" integer NOT NULL,
        "DataCriacao" timestamp with time zone NOT NULL,
        "DataAtualizacao" timestamp with time zone,
        CONSTRAINT "PK_PedidosPreparoEntrega" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240112120823_BaseInicialPreparoEntrega') THEN
    CREATE TABLE "ItensPreparoEntrega" (
        "Id" uuid NOT NULL,
        "Quantidade" integer NOT NULL,
        "ProdutoId" uuid NOT NULL,
        "NomeProduto" text NOT NULL,
        "TempoPreparoEstimado" integer NOT NULL,
        "PedidoId" uuid NOT NULL,
        CONSTRAINT "PK_ItensPreparoEntrega" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_ItensPreparoEntrega_PedidosPreparoEntrega_PedidoId" FOREIGN KEY ("PedidoId") REFERENCES "PedidosPreparoEntrega" ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240112120823_BaseInicialPreparoEntrega') THEN
    CREATE INDEX "IX_ItensPreparoEntrega_PedidoId" ON "ItensPreparoEntrega" ("PedidoId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240112120823_BaseInicialPreparoEntrega') THEN
    CREATE INDEX "IDX_PreparoEntrega_PedidoCorrelacaoId" ON "PedidosPreparoEntrega" ("PedidoCorrelacaoId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20240112120823_BaseInicialPreparoEntrega') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20240112120823_BaseInicialPreparoEntrega', '8.0.0');
    END IF;
END $EF$;
COMMIT;

