with CTE as(

select Container_uuid, Name, PARENT_FOLDER_UUID, cast(Name as varchar(255)) as [Path], [META_TYPE_UUID], [CREATION_DATE], [OWNER_LOGIN], [LAST_MODIFIED_DATE]--,[USER_NAME]

FROM [V8_CONTAINER]

where parent_folder_uuid = 'REPORTMART' and browsable = 1

union all

select s.Container_uuid, s.Name, s.PARENT_FOLDER_UUID , cast([Path] +'\' + cast(s.Name as varchar(255)) as varchar(255)), s.[META_TYPE_UUID], s.[CREATION_DATE], s.[OWNER_LOGIN], s.[LAST_MODIFIED_DATE]--, s.[USER_NAME]

FROM [V8_CONTAINER] s

INNER JOIN CTE u ON u.Container_uuid = s.PARENT_FOLDER_UUID-- and s.ServerId = u.ServerId

)

select a.Name,Path,Value from CTE a

join [dbo].[V8_VERSION_ATTRIBUTES] b on a.CONTAINER_UUID=b.CONTAINER_UUID

where [META_TYPE_UUID] = 'ID200'

AND b.name='DataSourceIDs'

order by PAth