-- Upgrade MetaStore schema from 3.0.0 to 3.1.0
-- HIVE-19440
ALTER TABLE "APP"."GLOBAL_PRIVS" ADD "AUTHORIZER" VARCHAR(128);
DROP INDEX "APP"."GLOBALPRIVILEGEINDEX";
CREATE UNIQUE INDEX "APP"."GLOBALPRIVILEGEINDEX" ON "APP"."GLOBAL_PRIVS" ("AUTHORIZER", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "USER_PRIV", "GRANTOR", "GRANTOR_TYPE");

ALTER TABLE "APP"."DB_PRIVS" ADD "AUTHORIZER" VARCHAR(128);
DROP INDEX "APP"."DBPRIVILEGEINDEX";
CREATE UNIQUE INDEX "APP"."DBPRIVILEGEINDEX" ON "APP"."DB_PRIVS" ("AUTHORIZER", "DB_ID", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "DB_PRIV", "GRANTOR", "GRANTOR_TYPE");

ALTER TABLE "APP"."TBL_PRIVS" ADD "AUTHORIZER" VARCHAR(128);
DROP INDEX "APP"."TABLEPRIVILEGEINDEX";
CREATE INDEX "APP"."TABLEPRIVILEGEINDEX" ON "APP"."TBL_PRIVS" ("AUTHORIZER", "TBL_ID", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "TBL_PRIV", "GRANTOR", "GRANTOR_TYPE");

ALTER TABLE "APP"."PART_PRIVS" ADD "AUTHORIZER" VARCHAR(128);
DROP INDEX "APP"."PARTPRIVILEGEINDEX";
CREATE INDEX "APP"."PARTPRIVILEGEINDEX" ON "APP"."PART_PRIVS" ("AUTHORIZER", "PART_ID", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "PART_PRIV", "GRANTOR", "GRANTOR_TYPE");

ALTER TABLE "APP"."TBL_COL_PRIVS" ADD "AUTHORIZER" VARCHAR(128);
DROP INDEX "APP"."TABLECOLUMNPRIVILEGEINDEX";
CREATE INDEX "APP"."TABLECOLUMNPRIVILEGEINDEX" ON "APP"."TBL_COL_PRIVS" ("AUTHORIZER", "TBL_ID", "COLUMN_NAME", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "TBL_COL_PRIV", "GRANTOR", "GRANTOR_TYPE");

ALTER TABLE "APP"."PART_COL_PRIVS" ADD "AUTHORIZER" VARCHAR(128);
DROP INDEX "APP"."PARTITIONCOLUMNPRIVILEGEINDEX";
CREATE INDEX "APP"."PARTITIONCOLUMNPRIVILEGEINDEX" ON "APP"."PART_COL_PRIVS" ("AUTHORIZER", "PART_ID", "COLUMN_NAME", "PRINCIPAL_NAME", "PRINCIPAL_TYPE", "PART_COL_PRIV", "GRANTOR", "GRANTOR_TYPE");

-- HIVE-19340
ALTER TABLE TXNS ADD COLUMN TXN_TYPE integer;

CREATE INDEX "APP"."TAB_COL_STATS_IDX" ON "APP"."TAB_COL_STATS" ("CAT_NAME", "DB_NAME", "TABLE_NAME", "COLUMN_NAME");

-- This needs to be the last thing done.  Insert any changes above this line.
UPDATE "APP".VERSION SET SCHEMA_VERSION='3.1.0', VERSION_COMMENT='Hive release version 3.1.0' where VER_ID=1;
