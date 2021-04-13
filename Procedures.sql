USE Airport_Management

/*procedure to modify the type of a desired column in the chosen table, 
input: table name, column, new type*/
go
create or alter procedure modtype (@Tablename varchar(20), @Column varchar(20), @newtype varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Tablename + ' ALTER COLUMN ' + @Column + ' ' + @newtype
 print (@query)
 exec (@query)
 print('The datatype of the column ' + @Column + ' from the table ' + @Tablename + ' is now ' + @newtype)
end
go

/*changes the type of the HangarNumber column of the table Hangars to float*/
exec modtype 'Hangars','HangarNumber','float' 


/*procedure made for defining a default value for a the desired column in a chosen table
input: table name, column, default value*/
go
create or alter procedure definedefault (@Tablename varchar(20), @Column varchar(20), @defaultval varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Tablename + ' ADD CONSTRAINT df_' + @Tablename + '_' + @Column + ' DEFAULT ' 
			+ @defaultval +' FOR '+ @Column
 print(@query)
 exec(@query)
 print('The default type of the column ' + @Column + ' is now ' + @defaultval)
end
go

/*the default value for the Bonus column in AirportStaff will be set to 0*/
exec definedefault 'AirportStaff' ,'Bonus', '0'

/*procedure made for creating a new table containing only an id column
input: table name, name of the id column, type of the id column*/
go
create or alter procedure newtable (@Tablename varchar(20), @Idcolumn varchar(20), @Idtype varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'CREATE TABLE ' + @Tablename + ' (' + @Idcolumn + ' ' + @Idtype + ' NOT NULL PRIMARY KEY)' 
 print (@query)
 exec (@query)
 print ('Table ' + @Tablename + ' Created')
end
go

/*creation of two disposable tables*/
exec newtable 'experiment', 'idd', 'varchar(20)'
exec newtable 'experiment2', 'iddd', 'int'

/*procedure that adds a new column to a table
input: table name, column name, column content type*/
go
create or alter procedure newcolumn (@Tablename varchar(20), @Column varchar(20), @Type varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Tablename + ' ADD ' + @Column + ' ' + @Type
 print (@query)
 exec (@query)
 print('Column ' + @Column + ' added to table ' + @Tablename)
end
go

/*adds a new column to one of the disposable tables*/
exec newcolumn 'experiment', 'random', 'int'

/*procedure that defines a foreign key between two different tables
input: table 1, table 2, column 1, column 2*/
go
create or alter procedure newfk (@Table1 varchar(20), @Table2 varchar(20), @Key1 varchar(20), @Key2 varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table1 + ' ADD CONSTRAINT FK_' + @Table1 + '_' + @Table2 + ' FOREIGN KEY (' + @Key1 
			+ ') REFERENCES ' + @Table2 + '(' + @Key2 +')'
 print (@query)
 exec (@query)
 print ('Foreign key counstraint FK_' + @Table1 + '_' + @Table2 + ' was created between the columns ' + @Key1 + ' and '
		+ @Key2)
end
go

/*adds a foreign key constraint between the disposable tables*/
exec newfk 'experiment', 'experiment2', 'random', 'iddd'

/*procedure made for dropping a default value
input: table name, target column*/
go
create or alter procedure dropdefault (@Table varchar(20), @Column varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table + ' DROP CONSTRAINT df_' + @Table + '_' + @Column
 print (@query)
 exec (@query)
 print('Default constraint dropped from column ' + @Column + ' in table ' + @Table)
end
go

/*drops the previously defined default value on the Bonus column on the AirportStaff table*/
exec dropdefault 'AirportStaff', 'Bonus'

/*procedure that drops a targeted column
input: table name, target column*/
go
create or alter procedure dropcolumn (@Table varchar(20), @Column varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table + ' DROP COLUMN ' + @Column
 print(@query)
 exec(@query)
 print ('Column ' + @Column + ' dropped from table ' +@Table)
end
go

/*removal of a column from one of the disposable tables*/
exec dropcolumn 'experiment', 'random'

/*procedure created for dropping a table
input: target table*/
go
create or alter procedure droptable (@Table varchar(20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'DROP TABLE ' + @Table
 print (@query)
 exec (@query)
 print ('Table ' + @Table + ' dropped')
end
go

/*disposal of the disposable tables*/
exec droptable 'experiment'
exec droptable 'experiment2'

/*procedure that drops the foreign key constraing between two tables
input: both of the targeted tables*/
go
create or alter procedure dropfk (@Table1 varchar(20),@Table2 varchar (20))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table1 + ' DROP CONSTRAINT FK_' + @Table1 + '_' + @Table2
 print(@query)
 exec(@query)
 print('Foreign key constraint FK_' + @Table1 + '_' + @Table2 + ' dropped from table ' + @Table1)
end
go

/*drops the previously created foreign key constraint on the disposable tables*/
exec dropfk 'experiment','experiment2'

/*procedure that drops a constraint from a table
input: target table, constraing name*/
go
create or alter procedure dropconstraint (@Table varchar(20), @Constraint varchar(50))
as
begin
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table + ' DROP CONSTRAINT ' + @Constraint
 print(@query)
 exec(@query)
 print('Constraint ' + @Constraint + ' dropped from table ' + @Table)
end
go

/****** Object:  Table [dbo].[Versions]    Script Date: 4/8/2021 12:27:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Versions](
	[cver] [int] NULL
) ON [PRIMARY]
GO



/*the previously executed operations grouped for ease of access*/

exec newtable 'experiment', 'idd', 'int'
exec newtable 'experiment2', 'iddd', 'int'

exec newcolumn 'experiment', 'random', 'varchar(100)'
exec newcolumn 'experiment', 'randomfloat', 'float'
exec newcolumn 'experiment2', 'randomint', 'int'

exec modtype 'experiment','random','varchar(20)'
exec modtype 'experiment','randomfloat','int' 

exec definedefault 'experiment', 'random', "'N/A'"
exec definedefault 'experiment2', 'randomint', '0'

exec newfk 'experiment', 'experiment2', 'randomfloat', 'iddd'

exec dropfk 'experiment','experiment2'

exec dropdefault 'experiment', 'random'
exec dropdefault 'experiment', 'randomint'

exec dropcolumn 'experiment', 'random'

exec droptable 'experiment'
exec droptable 'experiment2'

exec dropconstraint 'experiment', 'FK_experiment_experiment2'
exec dropconstraint 'experiment2', 'df_experiment2_randomint'

/*editing the previous procedures in order to obtain a history and version control, each operation now adds
the operation and its reversal into the history table, the current version is stored in a table which is updated
each time we run one of the procedures. The goToVer(n) procedure rolls the database back to the nth version
starting from the current one, it searches whether it needs to go to a newer or to an older version then proceeds to run the 
queries from the history table accordingly*/

go
create or alter procedure modtype (@Tablename varchar(20), @Column varchar(20), @newtype varchar(20), @oldtype varchar(50) = 0)
as
begin
 declare @rbq as varchar(MAX)
 exec gettype @Table = @Tablename, @Column = @Column, @result = @oldtype output
 print @oldtype
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Tablename + ' ALTER COLUMN ' + @Column + ' ' + @newtype
 set @rbq = 'ALTER TABLE ' + @Tablename + ' ALTER COLUMN ' + @Column + ' ' + @oldtype
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print (@query)
 exec (@query)
 print('The datatype of the column ' + @Column + ' from ' + @oldtype + ' to ' + @newtype)
end
go


go
create or alter procedure definedefault (@Tablename varchar(20), @Column varchar(20), @defaultval varchar(20), @rb int = 0)
as
begin
 declare @rbq as varchar(MAX)
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Tablename + ' ADD CONSTRAINT df_' + @Tablename + '_' + @Column + ' DEFAULT ' 
			+ @defaultval +' FOR '+ @Column
 set @rbq = 'ALTER TABLE ' + @Tablename + ' DROP CONSTRAINT df_' + @Tablename + '_' + @Column
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print(@query)
 exec(@query)
 print('The default type of the column ' + @Column + ' is now ' + @defaultval)
end
go

go
create or alter procedure rollbackdefinedefault (@Table varchar(20), @Column varchar(20), @DFV varchar(20) = NULL)
as
begin
 declare @query as varchar(MAX)
 declare @rbq as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table + ' DROP CONSTRAINT df_' + @Table + '_' + @Column
 set @rbq = 'ALTER TABLE ' + @Table + ' ADD CONSTRAINT df_' + @Table + '_' + @Column + ' DEFAULT ' 
			+ @DFV +' FOR '+ @Column
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print (@query)
 exec (@query)
 print('Default constraint dropped from column ' + @Column + ' in table ' + @Table)
end
go



go
create or alter procedure newcolumn (@Tablename varchar(20), @Column varchar(20), @Type varchar(20))
as
begin
 declare @rbq as varchar(MAX)
 declare @query as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Tablename + ' ADD ' + @Column + ' ' + @Type
 set @rbq ='ALTER TABLE ' + @Tablename + ' DROP COLUMN ' + @Column
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print (@query)
 exec (@query)
 print('Column ' + @Column + ' added to table ' + @Tablename)
end
go




go
create or alter procedure newtable (@Tablename varchar(20), @Idcolumn varchar(20), @Idtype varchar(20))
as
begin
 declare @query as varchar(MAX)
 declare @rbq as varchar(MAX)
 set @query = 'CREATE TABLE ' + @Tablename + ' (' + @Idcolumn + ' ' + @Idtype + ' NOT NULL PRIMARY KEY)'
 set @rbq = 'DROP TABLE ' + @Tablename
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print (@query)
 exec (@query)
 print ('Table ' + @Tablename + ' Created')
end
go

go
create or alter procedure rollbacknewtable (@Table varchar(20), @IDC varchar(20) = NULL, @IDT varchar(20) = NULL)
as
begin
 declare @rbq as varchar (MAX)
 declare @query as varchar(MAX)
 set @query = 'DROP TABLE ' + @Table
 set @rbq = 'CREATE TABLE ' + @Table+ ' (' + @IDC + ' ' + @IDT + ' NOT NULL PRIMARY KEY)'
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print (@query)
 exec (@query)
 print ('Table ' + @Table + ' dropped')
end
go



go
create or alter procedure newfk (@Table1 varchar(20), @Table2 varchar(20), @Key1 varchar(20), @Key2 varchar(20))
as
begin
 declare @query as varchar(MAX)
 declare @rbq as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table1 + ' ADD CONSTRAINT FK_' + @Table1 + '_' + @Table2 + ' FOREIGN KEY (' + @Key1 
			+ ') REFERENCES ' + @Table2 + '(' + @Key2 +')'
 set @rbq = 'ALTER TABLE ' + @Table1 + ' DROP CONSTRAINT FK_' + @Table1 + '_' + @Table2
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print (@query)
 exec (@query)
 print ('Foreign key counstraint FK_' + @Table1 + '_' + @Table2 + ' was created between the columns ' + @Key1 + ' and '
		+ @Key2)
end
go


go
create or alter procedure rollbacknewfk (@Table1 varchar(20),@Table2 varchar (20), @Key1 varchar(20) = NULL, @Key2 varchar(20) = NULL)
as
begin
 declare @query as varchar(MAX)
 declare @rbq as varchar(MAX)
 set @query = 'ALTER TABLE ' + @Table1 + ' DROP CONSTRAINT FK_' + @Table1 + '_' + @Table2
 set @rbq = 'ALTER TABLE ' + @Table1 + ' ADD CONSTRAINT FK_' + @Table1 + '_' + @Table2 + ' FOREIGN KEY (' + @Key1 
			+ ') REFERENCES ' + @Table2 + '(' + @Key2 +')'
 declare @level as int
 select @level = cver from Versions
 exec addhist @level,@query,@rbq
 print(@query)
 exec(@query)
 print('Foreign key constraint FK_' + @Table1 + '_' + @Table2 + ' dropped from table ' + @Table1)
end
go


exec newtable 'experiment', 'idd', 'int'
exec newtable 'experiment2', 'iddd', 'int'

exec newcolumn 'experiment', 'random', 'varchar(100)'
exec newcolumn 'experiment', 'randomfloat', 'float'
exec newcolumn 'experiment2', 'randomint', 'int'

--exec modtype 'experiment','random','varchar(20)'
--exec modtype 'experiment','randomfloat','int' 

exec definedefault 'experiment', 'random', "'N/A'"
exec definedefault 'experiment', 'randomint', '0'
--exec definedefault 'AirportStaff' ,'Bonus', '0'

exec newfk 'experiment', 'experiment2', 'randomfloat', 'iddd'

exec dropfk 'experiment','experiment2'

exec dropdefault 'experiment', 'random'
exec dropdefault 'experiment', 'randomint'
--exec dropdefault 'AirportStaff', 'Bonus'

exec undotype 'experiment', 'random', 'varchar(20)'

exec dropcolumn 'experiment', 'random'

exec droptable 'experiment'
exec droptable 'experiment2'

/*exec dropconstraint 'experiment', 'FK_experiment_experiment2'
exec dropconstraint 'AirportStaff', 'df_experiment_randomint'*/

--create table Versions (cver int)

go
create or alter procedure gettype (@Table varchar(20),@Column varchar(20), @result varchar(55) output)
as
begin
 declare @temp1 as varchar(25)
 declare @temp2 as varchar(25)
 SELECT @temp1 = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @Table AND COLUMN_NAME = @Column
 select @temp2 = CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @Table AND COLUMN_NAME = @Column
 if @temp1 = 'varchar'
 begin
  set @result = @temp1 + '(' + @temp2 + ')'
 end
 else
 begin
  set @result = @temp1
 end
end
go



declare @aux as varchar(55)
--select @aux = DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'AirportStaff' AND COLUMN_NAME = 'FirstName'
exec gettype 'AirportStaff', 'FirstName', @aux output

print @aux

go
create or alter procedure addhist (@vers int, @proc varchar(30))
as
begin
 exec nextver
 insert into History values (@vers, @proc)
end
go


go
create or alter procedure makehistory (@parameters int = 0)
as
begin
 create table History (Vers int NOT NULL PRIMARY KEY, Procd varchar(max) NOT NULL, Roll varchar(max) NOT NULL)
 declare @temp as int
 declare @str as varchar(30)
 set @temp = 1
 while @parameters >= @temp
 begin
  set @str = 'Param' + Convert(varchar(10), @temp)
  exec newcolumn History, @str , 'varchar(30)'
  set @temp = @temp + 1
 end
end
go

go 
create or alter procedure getcolumn (@cname varchar(30), @tname varchar(30), @vers int = NULL, @res varchar(30) output)
as
begin
 declare @query as varchar(max)
 set @query = 'SELECT ' + @cname + ' FROM ' + @tname
 if @vers != NULL
 begin
  set @query = @query  + ' WHERE Vers = ' + @vers 
 end
 print(@query)
 exec (@query)
 exec @res = @query
 return
end
go

go 
create or alter procedure jumpup (@target int)
as
begin
 declare @crt as int
 declare @pc as varchar(max)
 declare @query as varchar(max)
 select @crt = cver from Versions
 while @target < @crt
 begin
  select @pc = Roll from History where Vers = @crt
  set @query = @pc
  print(@query)
  exec (@query)
  set @crt = @crt - 1
  update Versions set cver = @crt
 end
 print (@crt)
end 
go

go 
create or alter procedure jumpdown (@target int)
as
begin
 declare @current as int
 declare @proc as varchar(max)
 declare @query as varchar(max)
 select @current = cver from Versions
 while @current < @target
 begin
  set @current = @current + 1
  select @proc = Procd from History where Vers = @current
  set @query = @proc
  print(@query)
  exec (@query)
  update Versions set cver = @current
 end
 print (@current)
end 
go

go
create or alter procedure gotoVer (@ver int)
as
begin
 declare @current as int
 select @current = cver from Versions
 if @ver > @current
 begin
  exec jumpdown @ver
 end
 else
 begin
  exec jumpup @ver
 end
end
go


go
create or alter procedure addhist (@vers int, @proc varchar(max), @roll varchar(max))
as
begin
 exec nextver
 set @vers = @vers + 1
 insert into History values (@vers, @proc, @roll)
end
go

go 
create or alter procedure nextver (@vers int = NULL)
as
begin
 update Versions set cver  = cver + 1
end
go


declare @old as varchar(50)
exec modtype 'Hangars','HangarNumber','int',@old output

declare @aux as varchar(30)
exec getcolumn 'Procd','History', 1, @res = @aux output
print (@aux)

declare @proc varchar(max)
select @proc = Procd from History where Vers = 1
print @proc

---------------------------------------------------------

exec droptable History

select * from History
select * from Versions

gotoVer 5

update Versions set cver = 0
exec makehistory

exec newtable 'experiment', 'idd', 'int'
exec newtable 'experiment2', 'iddd', 'int'

exec newcolumn 'experiment', 'random', 'varchar(100)'
exec newcolumn 'experiment', 'randomfloat', 'float'
exec newcolumn 'experiment2', 'randomint', 'int'

exec modtype 'experiment','random','varchar(20)'
exec modtype 'experiment','random','varchar(200)'
exec modtype 'experiment','randomfloat','int' 

exec definedefault 'experiment', 'random', "'N/A'"
exec definedefault 'experiment2', 'randomint', '0'

exec newfk 'experiment', 'experiment2', 'randomfloat', 'iddd'

--exec dropfk 'experiment','experiment2'
--exec rollbackdefinedefault 'experiment', 'random'
--exec rollbackdefinedefault 'experiment', 'randomint'
--exec dropdefault 'AirportStaff', 'Bonus'

exec undotype 'experiment', 'random', 'varchar(20)'

exec dropcolumn 'experiment', 'random'

exec droptable 'experiment'
exec droptable 'experiment2'
