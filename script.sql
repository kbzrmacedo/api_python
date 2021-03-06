USE [master]
GO
/****** Object:  Table [dbo].[atendentes]    Script Date: 27/06/2018 20:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[atendentes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [id_UNIQUE] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 27/06/2018 20:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](64) NOT NULL,
	[empresa] [varchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [id_Clientes_Unique] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[incidente]    Script Date: 27/06/2018 20:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[incidente](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[atendente] [int] NOT NULL,
	[cliente] [int] NOT NULL,
	[descricao] [varchar](512) NULL,
	[status] [varchar](16) NULL,
	[creation_time] [datetime2](0) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [id_Incidente_UNIQUE] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[incidente] ADD  DEFAULT (NULL) FOR [descricao]
GO
ALTER TABLE [dbo].[incidente] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[incidente] ADD  DEFAULT (NULL) FOR [creation_time]
GO
ALTER TABLE [dbo].[incidente]  WITH CHECK ADD  CONSTRAINT [fk_atendente] FOREIGN KEY([atendente])
REFERENCES [dbo].[atendentes] ([id])
GO
ALTER TABLE [dbo].[incidente] CHECK CONSTRAINT [fk_atendente]
GO
ALTER TABLE [dbo].[incidente]  WITH CHECK ADD  CONSTRAINT [fk_cliente] FOREIGN KEY([cliente])
REFERENCES [dbo].[clientes] ([id])
GO
ALTER TABLE [dbo].[incidente] CHECK CONSTRAINT [fk_cliente]
GO
