-- Convenience Proc that sets the values of a supplied AssetRefCounter
CREATE PROCEDURE SetValueFor
	@assetRefCounter VARCHAR(30), @newValue INT
AS
BEGIN
	IF @newValue > 0
		update AssetRefCounter set counter_prev_id = @newValue-1, counter_current_id = @newValue, counter_next_id = @newValue+1
			where counter_name = @assetRefCounter;
	ELSE
		IF (@newValue = 1)
			update AssetRefCounter set counter_prev_id = NULL, counter_current_id = @newValue, counter_next_id = @newValue+1
				where counter_name = @assetRefCounter;
		;
	;
END;