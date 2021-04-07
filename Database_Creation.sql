CREATE DATABASE Airport_Management2

USE Airport_Management2

GO

/****** Object:  Table [dbo].[Airports]    Script Date: 4/7/2021 11:18:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Airports](
	[AirportID] [int] NOT NULL,
	[AirportName] [varchar](80) NOT NULL,
	[AirportLocation] [varchar](20) NOT NULL,
	[Nickname] [varchar](20) NULL,
	[Country] [varchar](20) NULL,
 CONSTRAINT [PK_Airports] PRIMARY KEY CLUSTERED 
(
	[AirportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Airports] ADD  CONSTRAINT [df_Nickname]  DEFAULT (NULL) FOR [Nickname]
GO

GO

/****** Object:  Table [dbo].[AirportStaff]    Script Date: 4/7/2021 11:19:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AirportStaff](
	[StaffID] [varchar](20) NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[BirthDate] [date] NULL,
	[Occupation] [varchar](50) NULL,
	[AirportID] [int] NOT NULL,
	[HiringDate] [date] NULL,
	[Salary] [int] NULL,
	[Bonus] [int] NULL,
	[PerformanceRating] [int] NULL,
 CONSTRAINT [PK_AirportStaff] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AirportStaff]  WITH CHECK ADD  CONSTRAINT [FK_AirportStaff_Airports] FOREIGN KEY([AirportID])
REFERENCES [dbo].[Airports] ([AirportID])
GO

ALTER TABLE [dbo].[AirportStaff] CHECK CONSTRAINT [FK_AirportStaff_Airports]
GO

/****** Object:  Table [dbo].[Terminals]    Script Date: 4/7/2021 11:21:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Terminals](
	[TerminalID] [varchar](10) NOT NULL,
	[TerminalNumber] [int] NULL,
	[Airport] [int] NULL,
	[Capacity] [int] NULL,
 CONSTRAINT [PK_Terminals] PRIMARY KEY CLUSTERED 
(
	[TerminalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Terminals]  WITH CHECK ADD  CONSTRAINT [FK_Terminals_Terminals] FOREIGN KEY([Airport])
REFERENCES [dbo].[Airports] ([AirportID])
GO

ALTER TABLE [dbo].[Terminals] CHECK CONSTRAINT [FK_Terminals_Terminals]
GO

/****** Object:  Table [dbo].[Hangars]    Script Date: 4/7/2021 11:22:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Hangars](
	[HangarID] [int] NOT NULL,
	[HangarNumber] [int] NULL,
	[HangarCapacity] [int] NULL,
	[AirportID] [int] NULL,
 CONSTRAINT [PK_Hangars] PRIMARY KEY CLUSTERED 
(
	[HangarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Hangars]  WITH CHECK ADD  CONSTRAINT [FK_Hangars_Airports] FOREIGN KEY([AirportID])
REFERENCES [dbo].[Airports] ([AirportID])
GO

ALTER TABLE [dbo].[Hangars] CHECK CONSTRAINT [FK_Hangars_Airports]
GO

/****** Object:  Table [dbo].[Gates]    Script Date: 4/7/2021 11:36:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Gates](
	[GateID] [varchar](10) NOT NULL,
	[GateNumber] [int] NULL,
	[AccessTerminal] [varchar](10) NULL,
 CONSTRAINT [PK_Gates] PRIMARY KEY CLUSTERED 
(
	[GateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Gates]  WITH CHECK ADD  CONSTRAINT [FK_Terminals_Gates] FOREIGN KEY([AccessTerminal])
REFERENCES [dbo].[Terminals] ([TerminalID])
GO

ALTER TABLE [dbo].[Gates] CHECK CONSTRAINT [FK_Terminals_Gates]
GO

/****** Object:  Table [dbo].[Companies]    Script Date: 4/7/2021 11:42:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Companies](
	[CompanyID] [int] NOT NULL,
	[CompanyName] [varchar](20) NOT NULL,
	[OriginCountry] [varchar](20) NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Airplanes]    Script Date: 4/7/2021 11:37:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Airplanes](
	[AirplaneID] [int] NOT NULL,
	[Model] [varchar](50) NOT NULL,
	[Company] [int] NOT NULL,
	[HangarID] [int] NULL,
 CONSTRAINT [PK_Airplanes] PRIMARY KEY CLUSTERED 
(
	[AirplaneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Airplanes]  WITH CHECK ADD  CONSTRAINT [FK_Airplanes_Airplanes] FOREIGN KEY([Company])
REFERENCES [dbo].[Companies] ([CompanyID])
GO

ALTER TABLE [dbo].[Airplanes] CHECK CONSTRAINT [FK_Airplanes_Airplanes]
GO

ALTER TABLE [dbo].[Airplanes]  WITH CHECK ADD  CONSTRAINT [FK_Airplanes_Hangars] FOREIGN KEY([HangarID])
REFERENCES [dbo].[Hangars] ([HangarID])
GO

ALTER TABLE [dbo].[Airplanes] CHECK CONSTRAINT [FK_Airplanes_Hangars]
GO

/****** Object:  Table [dbo].[Routes]    Script Date: 4/7/2021 11:38:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Routes](
	[RouteID] [int] NOT NULL,
	[Origin] [varchar](20) NOT NULL,
	[Destination] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Flights]    Script Date: 4/7/2021 11:39:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Flights](
	[FlightID] [int] NOT NULL,
	[AirplaneID] [int] NOT NULL,
	[RouteID] [int] NOT NULL,
	[ArrivalTime] [datetime] NULL,
	[DepartureTime] [datetime] NULL,
	[DepartureGate] [varchar](10) NULL,
 CONSTRAINT [PK_Flights_1] PRIMARY KEY CLUSTERED 
(
	[FlightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_Airplanes] FOREIGN KEY([AirplaneID])
REFERENCES [dbo].[Airplanes] ([AirplaneID])
GO

ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_Airplanes]
GO

ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_Gates] FOREIGN KEY([DepartureGate])
REFERENCES [dbo].[Gates] ([GateID])
GO

ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_Gates]
GO

ALTER TABLE [dbo].[Flights]  WITH CHECK ADD  CONSTRAINT [FK_Flights_Routes] FOREIGN KEY([RouteID])
REFERENCES [dbo].[Routes] ([RouteID])
GO

ALTER TABLE [dbo].[Flights] CHECK CONSTRAINT [FK_Flights_Routes]
GO

/****** Object:  Table [dbo].[Passengers]    Script Date: 4/7/2021 11:42:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Passengers](
	[SSN] [int] NOT NULL,
	[FirstName] [varchar](20) NULL,
	[LastName] [varchar](20) NULL,
	[BirthDate] [date] NULL,
 CONSTRAINT [PK_Passengers_1] PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Accounts]    Script Date: 4/7/2021 11:40:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Accounts](
	[Username] [varchar](10) NOT NULL,
	[Password] [varchar](20) NOT NULL,
	[UserSSN] [int] NOT NULL,
	[AffiliatedCompany] [int] NOT NULL,
 CONSTRAINT [PK_Accounts_1] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Accounts] FOREIGN KEY([AffiliatedCompany])
REFERENCES [dbo].[Companies] ([CompanyID])
GO

ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Accounts]
GO

ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Passengers] FOREIGN KEY([UserSSN])
REFERENCES [dbo].[Passengers] ([SSN])
GO

ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Passengers]
GO

/****** Object:  Table [dbo].[Classes]    Script Date: 4/7/2021 11:45:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Classes](
	[ClassID] [varchar](1) NOT NULL,
	[ClassName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Tickets]    Script Date: 4/7/2021 11:43:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tickets](
	[TicketID] [varchar](10) NOT NULL,
	[Flight] [int] NOT NULL,
	[TiedAccount] [varchar](10) NULL,
	[Class] [varchar](1) NOT NULL,
	[AssociatedPassenger] [int] NOT NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Accounts] FOREIGN KEY([TiedAccount])
REFERENCES [dbo].[Accounts] ([Username])
GO

ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Accounts]
GO

ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Classes] FOREIGN KEY([Class])
REFERENCES [dbo].[Classes] ([ClassID])
GO

ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Classes]
GO

ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Flights] FOREIGN KEY([Flight])
REFERENCES [dbo].[Flights] ([FlightID])
GO

ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Flights]
GO

ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Passengers] FOREIGN KEY([AssociatedPassenger])
REFERENCES [dbo].[Passengers] ([SSN])
GO

ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Passengers]
GO

/****** Object:  Table [dbo].[FlightStaff]    Script Date: 4/7/2021 11:47:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FlightStaff](
	[FlightStaffID] [varchar](20) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Occupation] [varchar](20) NOT NULL,
	[HiringCompany] [int] NOT NULL,
	[HiringDate] [date] NOT NULL,
	[Salary] [int] NOT NULL,
	[Bonus] [int] NULL,
	[PerformanceRating] [int] NULL,
 CONSTRAINT [PK__FlightSt__0D8653CF3D80EC3C] PRIMARY KEY CLUSTERED 
(
	[FlightStaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FlightStaff]  WITH CHECK ADD  CONSTRAINT [FK_FlightStaff_Companies] FOREIGN KEY([HiringCompany])
REFERENCES [dbo].[Companies] ([CompanyID])
GO

ALTER TABLE [dbo].[FlightStaff] CHECK CONSTRAINT [FK_FlightStaff_Companies]
GO

/****** Object:  Table [dbo].[FlightStaffSchedule]    Script Date: 4/7/2021 11:48:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FlightStaffSchedule](
	[EmployeeID] [varchar](20) NOT NULL,
	[FlightID] [int] NOT NULL,
	[StartingTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[FlightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FlightStaffSchedule]  WITH CHECK ADD  CONSTRAINT [FK__FlightSta__Fligh__55F4C372] FOREIGN KEY([FlightID])
REFERENCES [dbo].[Flights] ([FlightID])
GO

ALTER TABLE [dbo].[FlightStaffSchedule] CHECK CONSTRAINT [FK__FlightSta__Fligh__55F4C372]
GO

ALTER TABLE [dbo].[FlightStaffSchedule]  WITH CHECK ADD  CONSTRAINT [FK_FlightStaffSchedule_FlightStaff] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[FlightStaff] ([FlightStaffID])
GO

ALTER TABLE [dbo].[FlightStaffSchedule] CHECK CONSTRAINT [FK_FlightStaffSchedule_FlightStaff]
GO






