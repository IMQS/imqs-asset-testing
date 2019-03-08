CREATE OR REPLACE FUNCTION purge(tableName varchar)
	returns integer AS $$
BEGIN
	execute format('delete from "%s" where EXISTS(SELECT 1 FROM information_schema.tables WHERE table_name = ''%s '') ', tableName, tableName);
	return 0;
END;
$$
LANGUAGE plpgsql;

create or replace function truncate_if_exists(tablename text)
	returns void language plpgsql as $$
begin
	perform 1
	from information_schema.tables
	where table_name = tablename;
	if found then
		execute format('truncate %I cascade;', tablename);
	end if;
end $$;

select truncate_if_exists('CapitalisationGroupExpenditure');
select truncate_if_exists('CapitalisationGroup');
select truncate_if_exists('ComponentTransaction');
select truncate_if_exists('ComponentReplacement');
select truncate_if_exists('ComponentOwnership');
select truncate_if_exists('ComponentLocation');
select truncate_if_exists('ComponentLifeCycleIndicators');
select truncate_if_exists('ComponentDerecognition');
select truncate_if_exists('ComponentBomPolicy');
select truncate_if_exists('ComponentDescription');
select truncate_if_exists('ActualFinancials');
select truncate_if_exists('ActualDetails');
select truncate_if_exists('ActualIdentification');
select truncate_if_exists('BudgetApportions');
select truncate_if_exists('ProjectBudgetLink');
select truncate_if_exists('ProjectFinancials');
select truncate_if_exists('ProjectWorkflow');
select truncate_if_exists('ProjectGeneral');
select truncate_if_exists('BudgetSCOA');
select truncate_if_exists('Budget');