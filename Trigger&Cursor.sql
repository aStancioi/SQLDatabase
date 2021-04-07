USE Airport_Management

create table Logs(
LogId int PRIMARY KEY NOT NULL ,
OccurringDate datetime default SYSDATETIME(),
EventType varchar(10),
TargetTable varchar(30),
NrOccurrences int)

go
create or alter trigger dbo.SaveAirportStaffEvent 
on AirportStaff
after insert, update, delete
as
begin
 declare @nr int
 set @nr = 1
 declare @tablename varchar(30)
 set @tablename = 'AirportStaff'
 declare @event varchar(10)

 if(exists(select*from inserted))
 begin

  if(exists(select*from deleted))
  begin
   set @event = 'UPDATE'
   select @nr = Count(*) from inserted
  end

  else
  begin
   set @event = 'INSERT'
   select @nr = Count(*) from inserted
  end
 end

 else
 begin
  set @event = 'DELETE'
  select @nr = Count(*) from deleted
 end

 declare @logid int
 set @logid = 1
 if((select max(LogId) from Logs)>0)
 begin
  select @logid = max(LogId) from Logs
  set @logid = @logid+1
 end

 insert into Logs (LogId, EventType, TargetTable, NrOccurrences) values (@logid,@event,@tablename,@nr) 
end


insert into AirportStaff (StaffID,FirstName,LastName,AirportID)values (88,'Heidi','Montag',3),(89,'Heidi','Sonntag',3)
insert into AirportStaff (StaffID,FirstName,LastName,AirportID)values (89,'Heidi','Sonntag',3)
insert into AirportStaff (StaffID,FirstName,LastName,AirportID)values (81,'Heidi','Freitag',3)

delete from AirportStaff where StaffID in (18,16)

update AirportStaff set FirstName = 'Hans' where StaffID in (81,89)

update AirportStaff set PerformanceRating = 9 where PerformanceRating = 8

delete from Logs

select * from Logs
select * from AirportStaff

select f.FirstName, f.LastName, c.CompanyName, f.Salary 
from FlightStaff f 
join Companies c on c.CompanyID = f.HiringCompany
where (f.PerformanceRating <= (select PerformanceRating from FlightStaff where FlightStaffID = 4)) 
and (f.Salary < (select Salary from FlightStaff where FlightStaffID = 4))

--cursor-------------------------------------------------------------------------------------------------------

go
create or alter procedure getbetterpayments (@id varchar(20))
as
begin
 select f.FlightStaffID, f.FirstName, f.LastName, c.CompanyName, f.Salary 
 from FlightStaff f 
 join Companies c on c.CompanyID = f.HiringCompany
 where (f.PerformanceRating <= (select PerformanceRating from FlightStaff where FlightStaffID = @id)
 and f.Salary > (select Salary from FlightStaff where FlightStaffID = @id))
 or f.FlightStaffID = @id
 order by Salary desc
end
go

------------------------------------------------------------------------------------------------

select FlightStaffID, Salary from FlightStaff order by FlightStaffID asc

declare cursor_flightstaff cursor
for 
select FlightStaffID
from FlightStaff

open cursor_flightstaff

declare @empid varchar(20) 

fetch next 
from cursor_flightstaff 
into @empid

while @@FETCH_STATUS = 0
begin
 print @empid
 exec getbetterpayments @empid
 fetch next 
 from cursor_flightstaff 
 into @empid
end

close cursor_flightstaff

----------------------------------------------
deallocate cursor_flightstaff

