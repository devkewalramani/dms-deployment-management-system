<cfquery name="dstask" datasource="SBSEFD">
SELECT *
FROM dbo.ProjectTask
order by Project_Task ASC
</cfquery>

<cfoutput query="dstask">

<cfquery name="task" datasource="SBSEFD">
INSERT INTO dbo.ES_ProjectTask (Project_Task) Values ('#Project_Task#')
</cfquery>

</cfoutput>