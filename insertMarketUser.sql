
--trebuie inserat in fiecare DB Atlanta, Albuquerque etc. 
--din STRATUS-DBDEV
DECLARE @login_name nvarchar(20) = 'abuda'

insert into users (login_name, first_name, last_name, is_corporate, is_market_manager, is_sales_manager, is_business_manager, is_traffic_manager, is_active)
values (@login_name, 'Adrian', 'Buda', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y')

DECLARE @new_user_id int = @@Identity

select * from user_role

insert into user_role(user_id, role_name_id)
values(@new_user_id, (select id from role_name where name = 'Add Manual Invoice'))
insert into user_role(user_id, role_name_id)
values(@new_user_id, (select id from role_name where name = 'Automatic Invoicing'))
insert into user_role(user_id, role_name_id)
values(@new_user_id, (select id from role_name where name = 'Invoice Printing'))