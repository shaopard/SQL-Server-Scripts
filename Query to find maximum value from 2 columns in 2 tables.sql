declare @id int

declare @maxVersion int 
SEt @maxVersion = 1 + (
SELECT TOP 1
   MAX([Version]) as mv
FROM
    (
    SELECT ID, [Version] FROM OrderHeader oh where id = @id
    UNION All
    SELECT ID, [Version] FROM OrderHeaderHistory where OrderHeaderID = @id 
    ) foo
GROUP BY ID
order by mv desc
)

select @maxVersion