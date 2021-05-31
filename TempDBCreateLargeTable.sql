CREATE TABLE #LargeTempTable (col1 char(3000) default 'a', col2 char(3000) default 'b')

SET NOCOUNT ON;
DECLARE @i INT = 1

BEGIN TRAN
 WHILE @i <= 950000
 BEGIN
  INSERT INTO #LargeTempTable DEFAULT VALUES
  SET @i += 1
 END

COMMIT TRAN

DROP TABLE #LargeTempTable