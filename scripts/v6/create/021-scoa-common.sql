create function convertDateToInt(@date DATE) RETURNS INT as
BEGIN
	return CONVERT(INT, REPLACE(STR(YEAR(@date),4), ' ', '0')+REPLACE(STR(MONTH(@date),2), ' ', '0')+REPLACE(STR(DAY(@date),2), ' ', '0'));
END

