select a.AirportName, s.FirstName, s.LastName
from Airports a 
join AirportStaff s 
on s.AirportID = a.AirportID 
where a.Nickname is not null and a.Country = 'USA'
order by a.AirportName asc

select Airport = a.AirportName, Hangar = p.HangarID, DistinctAirplanes = count (distinct p.Model) /*counts the types of airplanes in each hangar*/
from Airplanes p
join Hangars h on h.HangarID = p.HangarID
join Airports a on a.AirportID = h.AirportID
group by p.HangarID, a.AirportName
having count(p.Model) > 1

select AVG = avg(s.Salary), c.CompanyName		/*avg salary for a company*/
from FlightStaff s
join Companies c on c.CompanyID = s.HiringCompany
where c.CompanyName = 'Emirates'
group by c.CompanyName

select OutgoingSalary = sum(s.Salary), a.AirportName	/*amount of money that an airport has to pay at the end of each month*/
from AirportStaff s
join Airports a on a.AirportID = s.AirportID
group by a.AirportName
having sum(s.Salary) < 
any(select sum(fs.Salary) 
from FlightStaff fs 
join Companies c on c.CompanyID = fs.HiringCompany)

select top(5)s.PerformanceRating, s.FirstName, s.LastName, c.CompanyName 
from FlightStaff s
join Companies c on c.CompanyID = s.HiringCompany
where s.Salary >= all(select sa.Salary from AirportStaff sa)
order by s.PerformanceRating desc


select distinct Airplane = p.Model, s.FirstName, s.LastName /*the planes that are available for the staff to work on*/
from FlightStaff s
join Companies c on c.CompanyID = s.HiringCompany
join Airplanes p on p.Company = c.CompanyID
where p.HangarID not in (select h.HangarID 
	from Hangars h 
	join Airports ap on ap.AirportID = h.AirportID 
	where ap.Nickname != NULL)
order by p.Model

select Flight = f.FlightID, t.TicketID, t.Class, a.Username
from Flights f
full outer join Tickets t on t.Flight = f.FlightID
full outer join Accounts a on a.Username = t.TiedAccount
where t.Class = 'E' or t.Class = 'B'
order by f.FlightID

select TotalCountries = a.Country /*all the countries that out management company does business with*/
from Airports a
union 
select c.OriginCountry
from Companies c

select CommonCountries = a.Country /*all the airports that operate from the same countries as the companies*/
from Airports a
intersect
select c.OriginCountry
from Companies c

select Airplane = p.Model, s.FirstName, s.LastName /*the planes that are available for the staff to work on*/
from FlightStaff s
join Companies c on c.CompanyID = s.HiringCompany
join Airplanes p on p.Company = c.CompanyID
where p.HangarID in (
select h.HangarId 
from Hangars h 
except 
select h2.HangarID 
from Hangars h2
join Airports ap on ap.AirportID = h2.AirportID 
where ap.Nickname != NULL)
order by p.Model