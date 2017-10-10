-- Convenience Proc that uses the AssetRefCounter table to increment a named counter and return its new value
CREATE PROCEDURE NextValueFor
	@assetRefCounter VARCHAR(30), @newValue INT OUTPUT
AS
BEGIN
	update AssetRefCounter set counter_prev_id = counter_current_id, counter_current_id = counter_next_id, counter_next_id = counter_next_id+1
		where counter_name = @assetRefCounter;
	SET @newValue = (select counter_current_id from AssetRefCounter where counter_name = @assetRefCounter)
END;