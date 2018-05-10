INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('assetfinformref', 0,1,2);
INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('componentidpostfix', 0,1,2);
INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('imqsBatchId', NULL,0,1);
INSERT INTO AssetRefCounter (counter_name, counter_prev_id, counter_current_id, counter_next_id) VALUES ('scoaPostingId', NULL,0,1);

-- AssetFinYear inserts
INSERT INTO AssetFinYear (FinYear, Period) VALUES(2015,1);
UPDATE AssetFinYear SET SCOAVersion = '6.1'