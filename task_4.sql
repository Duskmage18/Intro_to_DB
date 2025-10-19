-- task_4.sql
-- Print a full description of the table `books` in the CURRENT DATABASE.
-- The database name is expected to be provided to the mysql client (for example: mysql alx_book_store < task_4.sql)
-- This script MUST NOT use DESCRIBE or EXPLAIN. It relies on INFORMATION_SCHEMA and DATABASE().

SELECT
    C.COLUMN_NAME AS 'Field',
    C.COLUMN_TYPE AS 'Type',
    C.COLLATION_NAME AS 'Collation',
    C.IS_NULLABLE AS 'Null',
    (CASE
         WHEN EXISTS (
             SELECT 1
             FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE K
             WHERE K.TABLE_SCHEMA = C.TABLE_SCHEMA
                 AND K.TABLE_NAME = C.TABLE_NAME
                 AND K.COLUMN_NAME = C.COLUMN_NAME
                 AND K.CONSTRAINT_NAME = 'PRIMARY'
         ) THEN 'PRI'
         WHEN EXISTS (
             SELECT 1
             FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC
             JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE K2
                 ON TC.CONSTRAINT_SCHEMA = K2.CONSTRAINT_SCHEMA
                 AND TC.TABLE_NAME = K2.TABLE_NAME
                 AND TC.CONSTRAINT_NAME = K2.CONSTRAINT_NAME
             WHERE TC.CONSTRAINT_TYPE = 'UNIQUE'
                 AND TC.CONSTRAINT_SCHEMA = C.TABLE_SCHEMA
                 AND K2.TABLE_NAME = C.TABLE_NAME
                 AND K2.COLUMN_NAME = C.COLUMN_NAME
         ) THEN 'UNI'
         WHEN EXISTS (
             SELECT 1
             FROM INFORMATION_SCHEMA.STATISTICS S
             WHERE S.TABLE_SCHEMA = C.TABLE_SCHEMA
                 AND S.TABLE_NAME = C.TABLE_NAME
                 AND S.COLUMN_NAME = C.COLUMN_NAME
                 AND S.INDEX_NAME IS NOT NULL
         ) THEN 'MUL'
         ELSE ''
     END) AS 'Key',
    C.COLUMN_DEFAULT AS 'Default',
    C.EXTRA AS 'Extra',
    C.COLUMN_COMMENT AS 'Comment',
    (
        SELECT GROUP_CONCAT(CONCAT(KC.REFERENCED_TABLE_NAME, '(', KC.REFERENCED_COLUMN_NAME, ')') SEPARATOR ', ')
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE KC
        WHERE KC.TABLE_SCHEMA = C.TABLE_SCHEMA
            AND KC.TABLE_NAME = C.TABLE_NAME
            AND KC.COLUMN_NAME = C.COLUMN_NAME
            AND KC.REFERENCED_TABLE_NAME IS NOT NULL
    ) AS 'Referenced'
FROM INFORMATION_SCHEMA.COLUMNS C
WHERE C.TABLE_SCHEMA = DATABASE()
    AND LOWER(C.TABLE_NAME) = 'books'
ORDER BY C.ORDINAL_POSITION;
