-- This is a utility method for our mock setups that allows us to switch between financial years
CREATE PROCEDURE [dbo].[P_F_G_UPD_FIN_PERIOD] (@NewYear VARCHAR(4), @NewPeriod VARCHAR(2))
AS
BEGIN
	UPDATE Budget SET FINANCIAL_YEAR = @NewYear;
	UPDATE ProjectSCOASegment SET FINANCIAL_YEAR = @NewYear;
	UPDATE Item SET FINANCIAL_YEAR = @NewYear;

	UPDATE OpenPeriods SET 
		FINANCIAL_YEAR = @NewYear,  
		PERIOD_STATUS = (SELECT DESCRIPTION FROM PeriodStatus WHERE CODE = 1),
		FINANCIAL_PERIOD = '20'+LEFT(@NewYear,2)+@NewPeriod
	WHERE PERIOD_STATUS_CODE = 1;
END

