declare @rid int = 130
declare @coop varchar(1) = 'N'

UPdate order_spot SET invoice_detail_id = null where id IN(
--Select * from order_spot where id in(
select 
os.id
--od.agency_rate,
--isnull(drt.description, '') as detail_revenue_type_name,
--case when oh.coop = 'Y' then 1 when oh.notarized = 'Y' then 2 else 3 end as sort_1,
--convert(varchar(50),ih.invoice_date,1) as invoice_date,
--rp.value2 as company_name,rp.value1,case when rp.value1  is null then '' else 'Advertiser:' end as  advertiser_label,
--rp.value3 address1, 
--rp.value4 address2,
--value5  as citystatezip,
--isnull(u.first_name,'')+' '+isnull(u.last_name,'') as ae,
--ih.order_header_id as order_number,
--s.id as station_id, 
--s.name as station_name,
--s.invoice_text,
--m.name as market_name,m.telephone as phone,
--ih.id as invoice_id, ih.net as net,
--convert(varchar(50),isnull(l.log_date,os.run_date),1) as Date,
--substring(datename(weekday,isnull(l.log_date,os.run_date)),1,3) as Day,
--right(convert(varchar(50),dateadd(second,isnull(l.actual_time,l.seconds_into_the_hour),dateadd(hour,l.hour_of_the_day,'01/01/01'))),7) as Time,
--dateadd(second,isnull(l.actual_time,l.seconds_into_the_hour),dateadd(hour,l.hour_of_the_day,'01/01/01')) as sort_time,
--od.length as Length,
--case when od.log_name = 'Sales Tax' then 0 else id.amount end as Rate,
--case 
--	when od.priority = 1 or od.priority = 2 then 'A' 
--	when od.priority >= 3 and od.priority <= 5 then 'B' 
--	when od.priority = 6 or od.priority = 7 or od.priority = 9 then 'C' 
--	when od.priority = 8 then 'T' 
--	else '' 
--end as CI,
--isnull(ocd.description,isnull(od.log_name,isnull(oh.description,''))) as Product,
--s.payment_address_1 as payment_address_1,
--s.payment_address_2 as payment_address_2,
--case when od.non_spot ='Y' then 0 else 1 end as is_spot,
--ih.gross as gross,ih.gross-ih.net as agency_commission,
--rt.description as revenue_type_name,
--oh.estimate as estimate,
--oh.description as description,
--case when a.name is null then '' else c.name end as  advertiser_name, isnull(a.edi_invoicing,'N') as edi_invoicing, 
--od.id as order_detail_id,
--os.bump_reason as bump_reason,
--rp.id  as report_parameter_id,
--oh.suppress_rates as suppress_rates, oh.company_id as company_id, isnull(oh.agency_id,0) as agency_id,
--s.sales_tax_rate as sales_tax_rate, case when od.log_name = 'Sales Tax' then id.amount else 0 end as sales_tax,
--m.use_sales_tax as use_sales_tax, c.credit_status as credit_status 
from report_parameter as rp 
inner join invoice_header as ih on rp.parameter_value = ih.id 
inner join invoice_detail as id on ih.id = id.invoice_header_id 
inner join order_spot as os on id.order_spot_id = os.id 
inner join order_detail as od on os.order_detail_id = od.id 
inner join order_header as oh on od.order_header_id = oh.id 
inner join company as c on oh.company_id = c.id 
inner join users as u on u.id = ih.user_id 
inner join station as s on s.id = oh.station_id 
inner join market as m on 1=1 
inner join revenue_type as rt on oh.revenue_type_id = rt.id 
inner join revenue_type as drt on od.revenue_type_id = drt.id 
left outer join company as a on oh.agency_id = a.id 
left outer join order_copy_detail as ocd on os.order_copy_detail_id = ocd.id 
left outer join log as l on id.log_id = l.id 
where ( oh.coop = @COOP ) and ( rp.parameter_id = @RID )  
--order by sort_1,company_name,rp.id,invoice_id,Date,sort_time
)
--select revenue_type_id from order_detail where id = 747671
--select * from market