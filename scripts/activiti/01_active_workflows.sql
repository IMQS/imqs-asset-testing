-- A query to determine whether there are active activiti workflows lurking somewhere.
-- Under normal circumstances, a workflow will be terminated after completion of a process or it will timeout after 24 hours have elapsed since it was started.
-- If a workflow has been active for more than 24 hours that's a definite sign of a deeper problem!! See ElapsedTime field in the results.

SELECT act.proc_inst_id_ as "ProcessInstanceId", def.name_ as "Name", act.start_time_ as "ActivityStartTime",  age(now()::timestamp, act.start_time_) as "ElapsedTime",
act.act_name_ as "ActivityName", act.act_type_ as "ActivityType"
FROM public.act_hi_actinst act
INNER JOIN public.act_re_procdef def ON act.proc_def_id_ =  def.id_
INNER JOIN public.act_ru_execution ex ON act.proc_inst_id_ = ex.proc_inst_id_
WHERE act.end_time_ IS NULL AND ex.is_active_ = true
ORDER BY act.start_time_ DESC;
