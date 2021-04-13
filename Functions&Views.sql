USE Airport_Management

go
create or alter function dbo.validflight (@val int)
returns int
as 
begin
 declare @nr int
 select @nr = count(*) from Flights where FlightID = @val
 return @nr
end
go

go
create or alter function dbo.validstaff (@val varchar(20))
returns int
as 
begin
 declare @nr int
 select @nr = Count(*) from FlightStaff where FlightStaffID = @val
 return @nr
end


go
create or alter function dbo.Isint(@number varchar(20))
returns bit
as
begin
 return ISNUMERIC(Replace(Replace(@number,'.','A'),'-','A'))
end


go
create or alter function dbo.GetLen (@Table varchar(20), @Column varchar(20), @Key varchar(max))
returns int
as
begin
 declare @len int
 select @len = CHARACTER_MAXIMUM_LENGTH 
 from INFORMATION_SCHEMA.COLUMNS 
 where TABLE_NAME = @Table AND COLUMN_NAME = @Column
 if @len < len(@Key)
 begin
  set @len = 0
 end
 else
 begin
  set @len = 1
 end
 return @len
end
go

go
create or alter function dbo.Topn (@nr int)
returns table 
as
 return 
 select top(@nr) AvgPayment, CompanyName
 from company_avg_payments
 order by AvgPayment desc
go

go
create or alter function dbo.Bottomn (@nr int)
returns table 
as
 return 
 select top(@nr) AvgPayment, CompanyName
 from company_avg_payments
 order by AvgPayment asc
go

go
alter procedure insertschedule (@Table varchar(20), @EID varchar(30), @FID varchar(20), @Start varchar(20), @End varchar(20))
as
begin
 declare @query varchar(max)
 declare @temp int
 set @query = 'INSERT INTO ' + @Table + ' VALUES (' + @EID + ', ' + @FID + ', ' + @Start + ', ' + @End + ')'

 select @temp = dbo.Isint(@FID)
 if (@temp = 0)
 begin
  raiserror (50001,1,1)
  return
 end

 select @temp = dbo.GetLen (@Table,'EmployeeID',@EID)
 if (@temp = 0)
 begin
  raiserror (50003,1,1)
  return
 end

 select @temp = dbo.validflight(@FID)
 if (@temp = 0)
 begin
  raiserror (50002,1,1)
  return
 end

 select @temp = dbo.validstaff(@EID)
 if (@temp = 0)
 begin
  raiserror (50002,1,1)
  return
 end

 print (@query)
 exec (@query) 
end
go

go
alter view total_company_payout as 
select c.CompanyName, Sum(f.Salary) as Total from FlightStaff f
join Companies c on c.CompanyID = f.HiringCompany
group by c.CompanyName

go
alter view ticket_owners as 
select t.TicketID, t.AssociatedPassenger, a.Username from Tickets t
join Accounts a on a.Username = t.TiedAccount

--drop view ticket_owners

go
alter view company_payments as
select f.FirstName, f.LastName, c.CompanyName, f.Salary from FlightStaff f
join Companies c on c.CompanyID = f.HiringCompany
go



create or alter view salaries as
select FirstName, LastName, HiringCompany, Salary from FlightStaff
go

select o.TicketID, p.FirstName, p.LastName, o.Username from ticket_owners o
full outer join Passengers p on p.SSN = o.AssociatedPassenger

--select * from ticket_owners
--select * from company_payments
--select * from total_company_payout

select * from company_avg_payments

select * from dbo.Topn(2)
select * from dbo.Bottomn(2)

exec sp_addmessage @msgnum = 50003, @severity = 4, @msgtext = 'Maximum length exceeded'

select * from sys.messages where message_id in (50001,50002, 50003)

exec insertschedule 'FlightStaffSchedule', '1','1',"'08:00:00'", "'10:00:00'"
exec insertschedule 'FlightStaffSchedule', '2','1',"'08:00:00'", "'10:00:00'"

exec insertschedule 'FlightStaffSchedule', '3','1',"'08:00:00'", "'10:00:00'"
exec insertschedule 'FlightStaffSchedule', '4','1',"'08:00:00'", "'10:00:00'"

exec insertschedule 'FlightStaffSchedule','100','2',"'9:00:00'", "'12:00:00'"
exec insertschedule 'FlightStaffSchedule','100','2A',"'9:00:00'", "'12:00:00'" 
exec insertschedule 'FlightStaffSchedule','100','2.3',"'9:00:00'", "'12:00:00'" 
exec insertschedule 'FlightStaffSchedule','10A11111111111111111111111111111111','2',"'9:00:00'", "'12:00:00'" 
exec insertschedule 'FlightStaffSchedule', '1','70',"'9:00:00'", "'12:00:00'" 

select * from FlightStaffSchedule

go
create or alter function dbo.CompanySalary (@Comp varchar(20) = NULL)
returns table
as
 return select f.FirstName, f.LastName, f.Salary, c.CompanyName from FlightStaff  f
 join Companies c on c.CompanyID = f.HiringCompany
 where c.CompanyName = @Comp
go

go
alter view company_avg_payments as
select c.CompanyName, avg(f.Salary) as AvgPayment from FlightStaff f
join Companies c on c.CompanyID = f.HiringCompany
group by c.CompanyName
go

declare @Comp varchar(20)
set @Comp = 'Emirates'
select * from CompanySalary(@Comp) a where a.Salary >= (select AvgPayment from company_avg_payments c 
													where c.CompanyName = @Comp)

select * from company_avg_payments
