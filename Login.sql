CREATE SCHEMA Master;

--select * from Master.Category
CREATE TABLE Master.Category
(
	ID SERIAL,
	Category VARCHAR(100),
	SortOrder INT,
	IsActive BOOLEAN,
	CreatedBy VARCHAR(100),
	CreatedDate TIMESTAMP,
	UpdatedBy VARCHAR(100),
	UpdatedDate TIMESTAMP
);

--adding primary key :
ALTER TABLE Master.Category
ADD CONSTRAINT PK_Category_ID
PRIMARY KEY (ID);

--adding default :
ALTER TABLE Master.Category
ALTER COLUMN IsActive
SET DEFAULT TRUE;

--inserting values :
INSERT INTO Master.Category (Category, SortOrder, CreatedBy, CreatedDate) VALUES ('Admin', 2, 'ishit', NOW());
INSERT INTO Master.Category (Category, SortOrder, CreatedBy, CreatedDate) VALUES ('Patient', 1, 'ishit', NOW());

--select * from Master.Category_Activevw
CREATE VIEW Master.Category_Activevw
AS
SELECT
	ID,
	Category,
	SortOrder,
	CreatedBy,
	CreatedDate,
	UpdatedBy,
	UpdatedDate
FROM
	Master.Category
WHERE
	IsActive IS TRUE;
	
--Procedure to list the main category :
--CALL Master.ssp_Category(null, null);
CREATE OR REPLACE PROCEDURE Master.ssp_Category(INOUT CategoryID INT, INOUT CategoryName VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
	
	SELECT
		ID,
		Category
	INTO
		CategoryID,
		CategoryName
	FROM
		Master.Category
	ORDER BY
		SortOrder;
		
END;$$