-- AlterTable
SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'Setting'
    AND column_name = 'qrTimeout'
);

SET @sql := IF(@column_exists = 0,
  'ALTER TABLE `Setting` ADD COLUMN `qrTimeout` INT NULL;',
  'SELECT "Column already exists";'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
