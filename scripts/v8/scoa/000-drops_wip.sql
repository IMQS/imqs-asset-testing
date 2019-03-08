CREATE OR REPLACE FUNCTION purge(tableName varchar)
	returns integer AS $$
BEGIN
	execute format('delete from "%s" where EXISTS(SELECT 1 FROM information_schema.tables WHERE table_name = ''%s '') ', tableName, tableName);
	return 0;
END;
$$
LANGUAGE plpgsql;

select purge('CapitalisationGroupExpenditure');
select purge('CapitalisationGroup');
select purge('ComponentTransaction');
select purge('ComponentReplacement');
select purge('ComponentOwnership');
select purge('ComponentLocation');
select purge('ComponentLifeCycleIndicators');
select purge('ComponentDerecognition');
select purge('ComponentBomPolicy');
select purge('ComponentDescription');
select purge('ActualFinancials');
select purge('ActualDetails');
select purge('ActualIdentification');
select purge('BudgetApportions');
select purge('ProjectBudgetLink');
select purge('ProjectFinancials');
select purge('ProjectWorkflow');
select purge('ProjectGeneral');
select purge('BudgetSCOA');
select purge('Budget');