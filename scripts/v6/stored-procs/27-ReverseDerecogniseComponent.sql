CREATE  procedure [dbo].[ReverseDerecogniseComponent] 
	@FinYear INT,
	@ComponentID VARCHAR(40),
	@AddToFollwingYear bit = 0
	
AS

BEGIN
	 -- SET NOCOUNT ON added to prevent extra result sets from
	 -- interfering with SELECT statements.
	 SET NOCOUNT ON

	 DECLARE @SQL VARCHAR(MAX)
	 DECLARE @CurrentFinTableName VARCHAR(30)
	 DECLARE @NextFinTableName VARCHAR(30)

	 SET @CurrentFinTableName = 'AssetRegisterIconFin' + CAST(@FinYear AS VARCHAR(4));
	 SET @NextFinTableName	  =	'AssetRegisterIconFin' + CAST(@FinYear + 1 AS VARCHAR(4));

	BEGIN TRANSACTION [Tran1]
	BEGIN TRY
		
	--Re-add Component to the Next Financial Year
	IF @AddToFollwingYear = 1
	BEGIN
		Execute RollOverComponent @FinYear, @ComponentID
	END
	--Remove Component for the AssetRegisterDerecognitions
	SET @SQL = 'DELETE FROM AssetRegisterDerecognitions WHERE ComponentID = ''' + @ComponentID + '''';
	EXEC(@SQL);
	PRINT 'commited'
	COMMIT TRANSACTION [Tran1]
	
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION [Tran1]
		---raise the error
		DECLARE @ErrorMessage NVARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT;
		SELECT @ErrorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
	 
END
;





