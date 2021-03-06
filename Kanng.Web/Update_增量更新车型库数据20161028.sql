

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.ModelClassification') and o.name = 'FK_VehicleClassification_ModelClassification')
--alter table dbo.ModelClassification
--   drop constraint FK_VehicleClassification_ModelClassification
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StylePropertyValueTable') and o.name = 'FK_Style_StylePropertyValueTable')
--alter table StylePropertyValueTable
--   drop constraint FK_Style_StylePropertyValueTable
--GO

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('IAutosByTrim') and o.name = 'FK_IAutosByTrim_Style')
--alter table IAutosByTrim
--   drop constraint FK_IAutosByTrim_Style
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.StyleBodyType') and o.name = 'FK_StyleBodyType_ModelClassification')
--alter table dbo.StyleBodyType
--   drop constraint FK_StyleBodyType_ModelClassification
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StyleMapMiddle') and o.name = 'FK_StyleMapMiddle_StyleMap')
--alter table StyleMapMiddle
--   drop constraint FK_StyleMapMiddle_StyleMap
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StyleProperty') and o.name = 'FK_StylePropertyCode_StyleProperty')
--alter table StyleProperty
--   drop constraint FK_StylePropertyCode_StyleProperty
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StyleProperty') and o.name = 'FK_StylePropertyGroup_StyleProperty')
--alter table StyleProperty
--   drop constraint FK_StylePropertyGroup_StyleProperty
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StyleProperty') and o.name = 'FK_StylePropertyPhysicalTable_StyleProperty')
--alter table StyleProperty
--   drop constraint FK_StylePropertyPhysicalTable_StyleProperty
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StyleProperty') and o.name = 'FK_StylePropertyType_StyleProperty')
--alter table StyleProperty
--   drop constraint FK_StylePropertyType_StyleProperty
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StylePropertyDicSchema') and o.name = 'FK_StylePropertyCode_StylePropertyCodeSchema')
--alter table StylePropertyDicSchema
--   drop constraint FK_StylePropertyCode_StylePropertyCodeSchema
--go


----去掉主表外键结束

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Manufacturer') and o.name = 'FK_ProduceType_Manufacturer')
--alter table dbo.Manufacturer
--   drop constraint FK_ProduceType_Manufacturer
--GO

--产品类别 0国产  1合资   2 进口 导入

--MERGE INTO dbo.ProduceType AS T 
--USING VehicleData_Temp.dbo.ProduceType AS S
--ON T.ProduceTypeId = s.ProduceTypeId 
--WHEN MATCHED 
--THEN UPDATE SET t.ProduceTypeName = s.ProduceTypeName,t.Status = s.Status
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT (ProduceTypeId,ProduceTypeName,Status) 
--VALUES(s.ProduceTypeId,s.ProduceTypeName,s.Status)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;
--产品类型结束
GO
--用途类别

--MERGE INTO VehicleData.dbo.VehicleClassification AS T 
--USING VehicleData_Temp.dbo.VehicleClassification AS S
--ON T.VehicleClassificationId = s.VehicleClassificationId 
--WHEN MATCHED 
--THEN UPDATE SET t.VehicleClassificationName=s.VehicleClassificationName
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT (VehicleClassificationId,VehicleClassificationName) 
--VALUES(s.VehicleClassificationId,s.VehicleClassificationName)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;

--用途类别 结束
GO

--导入车系等级

--MERGE INTO VehicleData.dbo.ModelClassification AS T 
--USING VehicleData_Temp.dbo.ModelClassification AS S
--ON T.Id = s.Id 
--WHEN MATCHED 
--THEN UPDATE SET t.Name=s.Name,t.VehicleClassification=s.VehicleClassification,t.ParentId=s.ParentId
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT ([Id], [Name], VehicleClassification, [ParentId]) 
--VALUES(s.id,s.Name,s.VehicleClassification,s.ParentId)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;


--导入车系等级 结束
GO

--车身型式

--MERGE INTO VehicleData.dbo.[StyleBodyType] AS T 
--USING VehicleData_Temp.dbo.[StyleBodyType] AS S
--ON T.Id = s.Id 
--WHEN MATCHED 
--THEN UPDATE SET t.Name=s.Name,t.ModelClassificationId=s.ModelClassificationId
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT ([Id], [Name], [ModelClassificationId]) 
--VALUES(s.id,s.Name,s.[ModelClassificationId])
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;


--车身型式 结束
GO
--车型状态

--MERGE INTO VehicleData.dbo.[Status] AS T 
--USING VehicleData_Temp.dbo.[Status] AS S
--ON T.StatusId = s.StatusId 
--WHEN MATCHED 
--THEN UPDATE SET t.StatusName=s.StatusName,t.Status=s.Status
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT (StatusId, StatusName, Status) 
--VALUES(s.StatusId,s.StatusName,s.Status)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;


--车型状态 结束
GO

--产品状态

--MERGE INTO VehicleData.dbo.ProductionSaleStatus AS T 
--USING VehicleData_Temp.dbo.ProductionSaleStatus AS S
--ON T.ProductionSaleStatusId = s.ProductionSaleStatusId 
--WHEN MATCHED 
--THEN UPDATE SET t.ProductionSaleStatusName=s.ProductionSaleStatusName,t.Status=s.Status
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT (ProductionSaleStatusId, ProductionSaleStatusName, Status) 
--VALUES(s.ProductionSaleStatusId,s.ProductionSaleStatusName,s.Status)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;


--产品状态 结束
GO

--属性类别

--MERGE INTO VehicleData.dbo.StylePropertyType AS T 
--USING VehicleData_Temp.dbo.StylePropertyType AS S
--ON T.StylePropertyTypeId = s.StylePropertyTypeId 
--WHEN MATCHED 
--THEN UPDATE SET t.StylePropertyTypeName=s.StylePropertyTypeName,t.Staus=s.Staus
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT (StylePropertyTypeId, StylePropertyTypeName, Staus) 
--VALUES(s.StylePropertyTypeId,s.StylePropertyTypeName,s.Staus)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;


--属性类别 结束


GO

--需要手工增量更新的表
--用途类别 车身型式 车系等级 生产类别 车型属性字典表 车型属性信息表 车型属性字典架构 产品类别 

--增量更新国家

SET IDENTITY_INSERT dbo.Country ON

MERGE INTO dbo.Country AS T 
USING CarsDataV3.dbo.Country AS S
ON T.id = s.id 
WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME)
THEN UPDATE SET T.Name = s.Name,t.NationalFlag=s.NationalFlag,t.UpdateTime= s.UpdateTime
WHEN NOT MATCHED BY TARGET THEN 
iNSERT (id,Name,NationalFlag,createtime,updatetime) VALUES(S.id,s.Name,s.NationalFlag,s.CreateTime,s.UpdateTime)
--HEN NOT MATCHED BY SOURCE 
--THEN DELETE
OUTPUT $action AS [action],inserted.id AS 插入的id,
Inserted.Name AS 插入的desc,
deleted.id AS 删除的id,
deleted.Name AS 删除的desc;

SET IDENTITY_INSERT dbo.Country OFF
 

MERGE INTO dbo.AreaCity AS T 
USING CarsDataV3.dbo.AreaCity AS S
ON T.CityId = s.CityId 
WHEN MATCHED 
THEN UPDATE SET T.CityAreaId = s.CityAreaId,t.CityName=s.CityName,t.CityFullName= s.CityFullName,t.ParentId=s.ParentId,t.CityLevel=s.CityLevel,t.PinYin=s.PinYin,t.Status=s.Status,t.BigAreaId=s.BigAreaId,t.CitySort=s.CitySort,t.StandardCityName=s.StandardCityName,t.StandardPinYin=s.StandardPinYin
WHEN NOT MATCHED BY TARGET THEN 
iNSERT (CityId,CityAreaId,CityName,CityFullName,ParentId,CityLevel,PinYin,Status,BigAreaId,CitySort,StandardCityName,StandardPinYin) VALUES(s.CityId,s.CityAreaId,s.CityName,s.CityFullName,s.ParentId,s.CityLevel,s.PinYin,s.Status,s.BigAreaId,s.CitySort,s.StandardCityName,s.StandardPinYin)
--HEN NOT MATCHED BY SOURCE 
--THEN DELETE
OUTPUT $action AS [action],inserted.CityId AS 插入的CityId,
Inserted.CityName AS 插入的desc,
deleted.CityId AS 删除的id,
deleted.CityName AS 删除的desc;
GO

--SELECT * FROM dbo.CompanyGroup b WHERE NOT EXISTS (SELECT 1 FROM CarsDataV3.dbo.CompanyGroup  WHERE b.id=Id )

--增量更新集团
SET IDENTITY_INSERT dbo.CompanyGroup ON

MERGE INTO dbo.CompanyGroup AS T 
USING CarsDataV3.dbo.CompanyGroup AS S
ON T.id = s.id 
WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME)
THEN UPDATE SET t.BitautoId=s.Id, T.Name = s.Name,t.ShortName=s.ShortName,t.EnglishName= s.EnglishName,t.OtherName=s.OtherName,t.Logo=s.Logo,t.Introduction=s.Introduction,t.Status=CASE WHEN s.IsRemoved = 1 THEN 2 WHEN s.IsRemoved=0 AND s.IsEnabled = 1 THEN 1 ELSE 0 END,t.UpdateTime=s.UpdateTime
WHEN NOT MATCHED BY TARGET THEN 
iNSERT (id,BitautoId,name,ShortName,EnglishName,OtherName,Logo,Introduction,Status,createtime,updatetime) VALUES(S.id,s.id,s.Name,s.ShortName,s.EnglishName,s.OtherName,s.Logo,s.Introduction,CASE WHEN s.IsRemoved = 1 THEN 2 WHEN s.IsRemoved=0 AND s.IsEnabled = 1 THEN 1 ELSE 0 END,s.CreateTime,s.UpdateTime)
--HEN NOT MATCHED BY SOURCE 
--THEN DELETE
OUTPUT $action AS [action],inserted.id AS 插入的id,
Inserted.Name AS 插入的desc,
deleted.id AS 删除的id,
deleted.Name AS 删除的desc
;
SET IDENTITY_INSERT dbo.CompanyGroup OFF

go

--增量更新品牌

--IF exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Make') and o.name = 'FK_CompanyGroup_Make')
--alter table dbo.Make
--   drop constraint FK_CompanyGroup_Make
--GO

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Make') and o.name = 'FK_Make_Country')
--alter table dbo.Make
--   drop constraint FK_Make_Country
--GO

--SELECT * FROM dbo.Make b WHERE NOT EXISTS (SELECT 1 FROM CarsDataV3.dbo.Make  WHERE b.id=Id )

IF OBJECT_ID(N'tempdb..#tempMake',N'U') IS NOT NULL
DROP TABLE #tempMake

SELECT a.Id,a.Name,a.OtherName,a.EnglishName,CountryId,ISNULL(a.CompanyGroupId,99) AS CompanyGroupId,LogoUrl,a.Introduction,
CASE WHEN IsRemoved = 1 THEN 2 WHEN IsRemoved=0 AND IsEnabled = 1 THEN 1 ELSE 0 END AS [Status],
Spell,a.CreateTime,a.UpdateTime,UsedCarName,UsedCarPhone,UsedCarWebsite,UsedCarLogo,UsedCarIntroduction
,a.Website
into #tempMake
FROM CarsDataV3..Make a 
INNER JOIN dbo.CompanyGroup b ON ISNULL(a.CompanyGroupId,99) = b.Id



--SELECT * FROM dbo.Make a WHERE NOT EXISTS(SELECT 1 FROM #tempMake WHERE id = a.id)

SET IDENTITY_INSERT dbo.Make ON

MERGE INTO dbo.Make AS T 
USING #tempMake AS S
ON T.id = s.id 
WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME)
THEN UPDATE SET t.BitautoId=s.Id, T.Name = s.Name,t.OtherName=s.OtherName,t.EnglishName= s.EnglishName,t.CountryId=s.CountryId,t.CompanyGroupId=s.CompanyGroupId, t.LogoUrl=s.LogoUrl, t.Introduction=s.Introduction,t.Status=s.Status, t.UpdateTime=s.UpdateTime,t.UsedCarName=s.UsedCarName,t.UsedCarPhone=s.UsedCarPhone,t.UsedCarWebsite=s.UsedCarWebsite,t.UsedCarLogo=s.UsedCarLogo,t.UsedCarIntroduction=s.UsedCarIntroduction,t.Website=s.Website
WHEN NOT MATCHED BY TARGET THEN 
iNSERT (id,BitautoId,name,OtherName,EnglishName,CountryId,CompanyGroupId,LogoUrl,Introduction,Status,Spell,createtime,updatetime,UsedCarName,UsedCarPhone,UsedCarWebsite,UsedCarLogo,UsedCarIntroduction,Website) 
VALUES(S.id,s.Id,s.Name,s.OtherName,s.EnglishName,s.CountryId,s.CompanyGroupId,s.LogoUrl,s.Introduction,s.Status,s.Spell,s.CreateTime,s.UpdateTime,s.UsedCarName,s.UsedCarPhone,s.UsedCarWebsite,s.UsedCarLogo,s.UsedCarIntroduction,s.Website)
--HEN NOT MATCHED BY SOURCE 
--THEN DELETE
OUTPUT $action AS [action],inserted.id AS 插入的id,
Inserted.Name AS 插入的desc,
deleted.id AS 删除的id,
deleted.Name AS 删除的desc
;
SET IDENTITY_INSERT dbo.Make OFF

   update [dbo].Make
  set LogoUrl = 'logo/make/m' + CAST(id as nvarchar)+ '100.jpg'
--增量更新厂商



   
--   if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Manufacturer') and o.name = 'FK_Manufacturer_Make')
--alter table dbo.Manufacturer
--   drop constraint FK_Manufacturer_Make
--go

GO

IF OBJECT_ID(N'tempdb..#tempManufacturer',N'U') IS NOT NULL
DROP TABLE #tempManufacturer

SELECT a.Id,a.[MakeId],a.Name,a.OtherName,a.EnglishName,Phone,a.WebSite,a.Introduction,a.Logo,ProductType,
a.Spell,CASE WHEN a.IsRemoved = 1 THEN 2 WHEN a.IsRemoved=0 AND a.IsEnabled = 1 THEN 1 ELSE 0 END AS [Status],
a.CreateTime,a.UpdateTime
INTO #tempManufacturer
FROM CarsDataV3..Manufacturer a
INNER JOIN dbo.Make b ON a.MakeId = b.Id
--DROP TABLE #tempManufacturer

SET IDENTITY_INSERT dbo.Manufacturer ON
MERGE INTO dbo.Manufacturer AS T 
USING #tempManufacturer AS S
ON T.id = s.id 
WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME)
THEN UPDATE SET t.BitautoId=s.Id,t.MakeId=s.MakeId, T.Name = s.Name,t.OtherName=s.OtherName,t.EnglishName= s.EnglishName,t.Phone=s.Phone,t.WebSite=s.WebSite, t.Introduction=s.Introduction,t.Logo=s.Logo, t.Status=s.Status,t.UpdateTime=s.UpdateTime
WHEN NOT MATCHED BY TARGET THEN 
iNSERT (id,BitautoId,MakeId,name,OtherName,EnglishName,Phone,WebSite,Introduction,Logo,ProductType,Spell,Status,createtime,updatetime) 
VALUES(S.id,s.Id,s.MakeId,s.Name,s.OtherName,s.EnglishName,s.Phone,s.WebSite,s.Introduction,s.Logo,s.ProductType,s.Spell,s.Status,s.CreateTime,s.UpdateTime)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;
;


  update [dbo].[Manufacturer]
  set Logo = 'logo/make/m' + CAST(MakeId as nvarchar)+ '100.jpg'

SET IDENTITY_INSERT dbo.Manufacturer OFF
--更新车系信息

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Model') and o.name = 'FK_Model_Manufacturer')
--alter table dbo.Model
--   drop constraint FK_Model_Manufacturer
   
--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Model') and o.name = 'FK_ModelClassification_Model')
--alter table dbo.Model
--   drop constraint FK_ModelClassification_Model
--go

IF OBJECT_ID(N'tempdb..#model_temp',N'U') IS NOT NULL
DROP TABLE #model_temp
SELECT a.Id,a.ManufacturerId,a.Name,a.OtherName,a.EnglishName,a.Introduction,a.ModelClassificationId, 50 AS NewModelClassificationId,a.ModelLevel,77 AS NewModelLevel,
a.Spell,a.AllSpell,a.DisplayName,a.Advantage,a.Defect,
CASE WHEN IsRemoved = 1 THEN 2 WHEN IsRemoved=0 AND IsEnabled = 1 THEN 1 ELSE 0 END AS [Status],
a.CreateTime,a.UpdateTime,a.WebSite
INTO #model_temp
FROM CarsDataV3..Model a
INNER JOIN dbo.Manufacturer b ON a.ManufacturerId = b.Id 


--获取第一级
UPDATE A SET NewModelClassificationId = 
(
	CASE 
	WHEN A.ModelClassificationId=1 THEN 1
	WHEN A.ModelClassificationId=2 THEN 2
	--WHEN A.ModelClassificationId=3 THEN 77
	WHEN A.ModelClassificationId=4 THEN 4
	WHEN A.ModelClassificationId=5 THEN 3
	WHEN A.ModelClassificationId=6 THEN 50
	WHEN A.ModelClassificationId=7 THEN 6
	WHEN A.ModelClassificationId=8 THEN 7
	WHEN A.ModelClassificationId=9 THEN 5
	WHEN A.ModelClassificationId=10 THEN 51
	ELSE
	50
	END	
)
FROM #model_temp A
WHERE A.ModelClassificationId<>3	

--匹配车系等级2级
UPDATE A SET NewModelLevel = 
(
	CASE 
	WHEN A.ModelLevel=1 THEN 8
	WHEN A.ModelLevel=2 THEN 9
	WHEN A.ModelLevel=3 THEN 10
	WHEN A.ModelLevel=4 THEN 11
	WHEN A.ModelLevel=5 THEN 12
	WHEN A.ModelLevel=6 THEN 13
	WHEN A.ModelLevel=7 THEN 14
	WHEN A.ModelLevel=8 THEN 19
	WHEN A.ModelLevel=9 THEN 21
	WHEN A.ModelLevel=10 THEN 77
	WHEN A.ModelLevel=11 THEN 25
	WHEN A.ModelLevel=12 THEN 24	
	WHEN A.ModelLevel=14 THEN 25
	WHEN A.ModelLevel=15 THEN 26
	ELSE
	77
	END	
)
FROM #model_temp A
	
	
	--根据编辑维护的数据更新车系等级
		UPDATE A 
	 SET A.NewModelLevel = b.newModelClassificationId
	FROM #model_temp A
	INNER JOIN  OPENDATASOURCE(
          'SQLOLEDB',
          'Data Source=192.168.0.23;User ID=guzhiadmin;Password=CjpK$34YU2a3'
          ).[BasicData].[dbo].Data_ModelClassification  B on A.id = B.id
		WHERE b.newModelClassificationId IS NOT NULL
		
		--获取车系等级不对的车系
DELETE from OPENDATASOURCE(
          'SQLOLEDB',
          'Data Source=192.168.0.23;User ID=guzhiadmin;Password=CjpK$34YU2a3'
          ).[BasicData].dbo.
Data_ModelClassification_temp

		INSERT INTO 
	OPENDATASOURCE(
			  'SQLOLEDB',
			  'Data Source=192.168.0.23;User ID=guzhiadmin;Password=CjpK$34YU2a3'
			  ).[BasicData].dbo.
	Data_ModelClassification_temp (id,OtherName,Name,ModelClassificationId,ModelLevel,车系等级2,newModelClassificationId1,newModelClassificationId,NewModelLevel,NewModelLevelParentId)
		
	SELECT  a.id,a.OtherName,a.Name,a.ModelClassificationId,a.ModelLevel,a.NewModelClassificationId AS [车系等级2],a.NewModelClassificationId newModelClassificationId1,null AS newModelClassificationId ,NewModelLevel,c.ParentId AS NewModelLevelParentId

	FROM #model_temp a 
	INNER JOIN ModelClassification c ON a.NewModelLevel = c.ID
	WHERE c.ParentId<>a.NewModelClassificationId  AND a.Status=1 
	
	
	--将不对称的信息设为默认值
	UPDATE A SET NewModelLevel = 
	(
	CASE 
	WHEN A.ModelClassificationId=1 THEN 8
	WHEN A.ModelClassificationId=2 THEN 14
	--WHEN A.ModelClassificationId=3 THEN 77
	WHEN A.ModelClassificationId=4 THEN 21
	WHEN A.ModelClassificationId=5 THEN 19
	WHEN A.ModelClassificationId=6 THEN 77
	WHEN A.ModelClassificationId=7 THEN 25
	WHEN A.ModelClassificationId=8 THEN 26
	WHEN A.ModelClassificationId=9 THEN 24
	WHEN A.ModelClassificationId=10 THEN 78
	
	ELSE
	77
	END
	)
	FROM #model_temp A
	INNER JOIN ModelClassification c ON a.NewModelLevel = c.ID

	WHERE c.ParentId<>a.NewModelClassificationId  AND a.Status=1 	
	


SET IDENTITY_INSERT dbo.Model ON
MERGE INTO dbo.Model AS T 
USING #model_temp AS S
ON T.id = s.id 
WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME)
--WHEN MATCHED 
THEN UPDATE SET t.BitautoId=s.id,t.ManufacturerId=s.ManufacturerId, T.Name = s.Name,t.OtherName=s.OtherName,t.EnglishName= s.EnglishName,t.Introduction=s.Introduction,t.ModelClassificationId=s.NewModelLevel, t.Spell=s.Spell,t.AllSpell=s.AllSpell,t.DisplayName=s.DisplayName,t.Advantage=s.Advantage,t.Defect=s.Defect,t.Status=s.Status,t.UpdateTime=s.UpdateTime,t.WebSite=s.WebSite
WHEN NOT MATCHED BY TARGET THEN 
iNSERT (id,BitautoId,ManufacturerId,name,OtherName,EnglishName,Introduction,ModelClassificationId,Spell,AllSpell,DisplayName,Advantage,Defect,Status,CreateTime,UpdateTime,WebSite) VALUES(S.id,s.id,s.ManufacturerId,s.Name,s.OtherName,s.EnglishName,s.Introduction,s.NewModelLevel,s.Spell,s.AllSpell,s.DisplayName,s.Advantage,s.Defect,s.Status,s.CreateTime,s.UpdateTime,s.WebSite)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE;
OUTPUT $action AS [action],inserted.id AS 插入的id,
Inserted.Name AS 插入的desc,
deleted.id AS 删除的id,
deleted.Name AS 删除的desc
;
UPDATE dbo.Model SET ModelImage=(SELECT ImageUrl FROM CarsDataV3.dbo.CarShowImage WHERE ModelId=dbo.Model.Id);
	UPDATE Model SET ModelImage=NULL
	 WHERE  id  IN(3647,
	3554,
	3024)
	
	
SET IDENTITY_INSERT dbo.Model OFF

--更新车系颜色
--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('ModelColor') and o.name = 'FK_Model_ModelColor')
--alter table ModelColor
--   drop constraint FK_Model_ModelColor
--GO

DELETE FROM CarsDataV3.dbo.ModelColor  WHERE NOT EXISTS(SELECT * FROM dbo.Model WHERE id =ModelId )

--SELECT * FROM CarsDataV3.dbo.ModelColor A  WHERE NOT EXISTS(SELECT * FROM dbo.Model WHERE id =A.ModelId )



IF OBJECT_ID(N'tempdb..#temp_ModelColor',N'U') IS NOT NULL
DROP TABLE #temp_ModelColor

SELECT a.Id,a.ModelId,BasicColor,a.Name,Value,a.OrderId,(CASE WHEN a.CreateTime IS null THEN GETDATE() WHEN a.CreateTime<'1753-01-01' THEN GETDATE() ELSE   CAST(a.CreateTime AS DATETIME) END) AS CreateTime,
CASE WHEN a.UpdateTime IS null THEN null WHEN a.UpdateTime<'1753-01-01' THEN NULL ELSE   CAST(a.UpdateTime AS DATETIME) END  AS UpdateTime
INTO #temp_ModelColor
FROM CarsDataV3.dbo.ModelColor a
INNER JOIN dbo.Model b ON a.ModelId = b.Id

--SELECT * FROM dbo.ModelColor A WHERE NOT EXISTS(SELECT * FROM #temp_ModelColor B WHERE B.ModelId =A.ModelId )

SET IDENTITY_INSERT dbo.ModelColor ON

MERGE INTO dbo.ModelColor AS T 
USING #temp_ModelColor AS S
ON T.id = s.id 
WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME) 
THEN UPDATE SET t.ModelId=s.ModelId,t.BasicColor=s.BasicColor,t.Name=s.Name,t.Value=s.Value,t.OrderId=s.OrderId,t.CreateTime = CASE WHEN s.CreateTime IS null THEN GETDATE() WHEN s.CreateTime<'1753-01-01' THEN GETDATE() ELSE   CAST(s.CreateTime AS DATETIME) END,t.UpdateTime = CASE WHEN s.UpdateTime IS null THEN null WHEN s.UpdateTime<'1753-01-01' THEN NULL ELSE   CAST(s.UpdateTime AS DATETIME) END

WHEN NOT MATCHED BY TARGET THEN 
iNSERT (id,ModelId,BasicColor,Name,Value,OrderId,CreateTime,UpdateTime) VALUES(s.id,s.ModelId,s.BasicColor,s.Name,s.Value,s.OrderId,CASE  WHEN s.CreateTime IS null THEN GETDATE() WHEN s.CreateTime<'1753-01-01' THEN GETDATE() ELSE   CAST(s.CreateTime AS DATETIME) END,CASE  WHEN s.UpdateTime IS null THEN null WHEN s.UpdateTime<'1753-01-01' THEN NULL ELSE   CAST(s.UpdateTime AS DATETIME) END)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE
;
SET IDENTITY_INSERT dbo.ModelColor OFF


--更新年款信息
GO

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.ModelYear') and o.name = 'FK_ModelYear_Model')
--alter table dbo.ModelYear
--   drop constraint FK_ModelYear_Model
--GO


--SET IDENTITY_INSERT dbo.ModelYear ON
--MERGE INTO dbo.ModelYear AS T 
--USING BasicData.dbo.CarsYear AS S
--ON T.ModelYearId = s.Id 
--WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME) 
--THEN UPDATE SET t.ModelId=s.ModelId,t.Year=s.Year,t.Status=CASE WHEN IsRemoved = 1 THEN 2 WHEN IsRemoved=0 AND IsEnabled = 1 THEN 1 ELSE 0 END ,t.UpdateTime=s.UpdateTime
--WHEN NOT MATCHED BY TARGET THEN 
--iNSERT (ModelYearId,ModelId,Year,Status,CreateTime,UpdateTime) VALUES(s.Id,s.ModelId,s.Year,CASE WHEN IsRemoved = 1 THEN 2 WHEN IsRemoved=0 AND IsEnabled = 1 THEN 1 ELSE 0 END ,s.CreateTime,s.UpdateTime)
----HEN NOT MATCHED BY SOURCE 
----THEN DELETE
--;

--SET IDENTITY_INSERT dbo.ModelYear OFF

IF OBJECT_ID(N'tempdb..#temp_ModelYear',N'U') IS NOT NULL
DROP TABLE #temp_ModelYear

SELECT Id, a.ModelId,a.Year,CASE WHEN IsRemoved = 1 THEN 2 WHEN IsRemoved=0 AND IsEnabled = 1 THEN 1 ELSE 0 END AS [Status],
a.CreateTime,a.UpdateTime
INTO #temp_ModelYear
FROM  
OPENDATASOURCE(
          'SQLOLEDB',
          'Data Source=192.168.0.23;User ID=guzhiadmin;Password=CjpK$34YU2a3'
          ).BasicData.dbo.CarsYear A
--OPENROWSET('SQLOLEDB', '192.168.0.23'; 'guzhiadmin'; 'CjpK$34YU2a3', BasicData.dbo.CarsYear) A
WHERE NOT EXISTS(SELECT 1 FROM dbo.ModelYear B  WHERE A.Id = B.ModelYearId)



set identity_insert [dbo].ModelYear ON

INSERT INTO [dbo].ModelYear
           (ModelYearId
           ,ModelId
           ,[Year]        
           ,[Status]
           ,[CreateTime]
           ,[UpdateTime])
SELECT a.Id, a.ModelId,a.Year,a.Status,
a.CreateTime,a.UpdateTime
FROM #temp_ModelYear a
INNER JOIN dbo.Model b 
ON a.ModelId = b.Id

set identity_insert [dbo].ModelYear OFF

--更新车型信息

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Style') and o.name = 'FK_Style_Model')
--alter table dbo.Style
--   drop constraint FK_Style_Model
--GO

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Style') and o.name = 'FK_Style_ModelYear')
--alter table dbo.Style
--   drop constraint FK_Style_ModelYear
--GO


--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Style') and o.name = 'FK_ModelClassification_Style')
--alter table dbo.Style
--   drop constraint FK_ModelClassification_Style
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Style') and o.name = 'FK_ProductionSaleStatus_Style')
--alter table dbo.Style
--   drop constraint FK_ProductionSaleStatus_Style
--go

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('dbo.Style') and o.name = 'FK_StyleBodyType_Style')
--alter table dbo.Style
--   drop constraint FK_StyleBodyType_Style
--go

IF OBJECT_ID(N'tempdb..#temp_Style',N'U') IS NOT NULL
DROP TABLE #temp_Style


SELECT Style.Id,Style.ModelId,Generation,Style.Year, IsAdvancedYear, 0 as [ModelYearId],Style.Name,
	NowMsrp,	Style.StyleBodyTypeId,	ProductionSaleStatus,TimeToMarket,	DownTime,		
	CASE WHEN IsRemoved = 1 THEN 2 WHEN IsRemoved=0 AND IsEnabled = 1 THEN 1 ELSE 0 END AS [Status],
    CAST(	Style.CreateTime AS DATETIME) CreateTime, CAST(	Style.UpdateTime AS DATETIME) UpdateTime,
    	ModelClassificationId,Warranty	
	into #temp_Style
	FROM CarsDataV3..Style
	inner JOIN dbo.Model ON Model.Id = Style.ModelId	
	WHERE style.UpdateTime IS NOT NULL AND style.UpdateTime >'1753-01-01'
	
	update #temp_Style
	set #temp_Style.[ModelYearId] = ModelYear.ModelYearId
	from #temp_Style,dbo.ModelYear
	where #temp_Style.ModelId = ModelYear.ModelId and #temp_Style.Year = ModelYear.Year
	DELETE from #temp_Style where [ModelYearId]=0
	
	
	--更新车型的车系等级
	UPDATE A SET StyleBodyTypeId = 
(
	CASE 
		WHEN b.StyleBodyTypeId=1 THEN 1 
		WHEN b.StyleBodyTypeId=2 THEN 2		
		WHEN b.StyleBodyTypeId=4 THEN 3
		WHEN b.StyleBodyTypeId=5 THEN 4 
		WHEN b.StyleBodyTypeId=6 THEN 6 
		WHEN b.StyleBodyTypeId=7 THEN 6
		WHEN b.StyleBodyTypeId=8 THEN 6		
		WHEN b.StyleBodyTypeId=9 THEN 6	
		WHEN b.StyleBodyTypeId=10 THEN 8
		WHEN b.StyleBodyTypeId=11 THEN 8
		WHEN b.StyleBodyTypeId=12 THEN 7
		WHEN b.StyleBodyTypeId=13 THEN 21
		WHEN b.StyleBodyTypeId=14 THEN 21
		WHEN b.StyleBodyTypeId=15 THEN 23
		WHEN b.StyleBodyTypeId=16 THEN 19
		WHEN b.StyleBodyTypeId=17 THEN 12
		WHEN b.StyleBodyTypeId=18 THEN 13
		WHEN b.StyleBodyTypeId=19 THEN 14 
		WHEN b.StyleBodyTypeId=20 THEN 15 
		WHEN b.StyleBodyTypeId=21 THEN 16 
		WHEN b.StyleBodyTypeId=22 THEN 17 
		WHEN b.StyleBodyTypeId=23 THEN 18 
		WHEN b.StyleBodyTypeId=24 THEN 18 
		WHEN b.StyleBodyTypeId=25 THEN 15 
		WHEN b.StyleBodyTypeId=26 THEN 10 
		WHEN b.StyleBodyTypeId=27 THEN 11 
		WHEN b.StyleBodyTypeId=28 THEN 15 
		WHEN b.StyleBodyTypeId=29 THEN 24
		WHEN b.StyleBodyTypeId=30 THEN 22 
		END
)
FROM #temp_Style A 
INNER JOIN CarsDataV3..Style B ON A.Id = b.Id


UPDATE A  SET StyleBodyTypeId =B.StyleBodyTypeId 
FROM #temp_Style A
--INNER JOIN  BasicData.dbo.Data_StyleBodyTypeData  B ON a.id = b.StyleId
INNER JOIN 
OPENDATASOURCE(
          'SQLOLEDB',
          'Data Source=192.168.0.23;User ID=guzhiadmin;Password=CjpK$34YU2a3'
          ).BasicData.dbo.Data_StyleBodyTypeData
--OPENROWSET('SQLOLEDB', '192.168.0.15'; 'sa'; 'Jql29%oPr84b', BasicData.dbo.Data_StyleBodyTypeData)
		 B ON a.id = b.StyleId

	--openrowset('SQLOLEDB', '192.168.0.23'; 'guzhiadmin'; 'CjpK$34YU2a3', BasicData.dbo.Data_StyleBodyTypeData)
	--SELECT a.UpdateTime ,b.UpdateTime FROM #temp_Style a
	--INNER JOIN CarsDataV3.dbo.Style b ON a.id =b.id	
	--SELECT * FROM dbo.Style a WHERE NOT EXISTS( SELECT * from #temp_Style where a.Id = Id)	
	
	SET IDENTITY_INSERT dbo.Style ON
	MERGE INTO dbo.Style AS T 
	USING #temp_Style AS S
	ON T.id = s.id 
	WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME)
	THEN UPDATE SET t.BitautoId=s.Id,t.ModelId=s.ModelId,t.ModelYearId=s.ModelYearId, t.IsAdvancedYear=s.IsAdvancedYear, T.Name = s.Name,T.NowMsrp=s.NowMsrp,T.StyleBodyTypeId=s.StyleBodyTypeId,T.ProductionSaleStatus=s.ProductionSaleStatus,t.TimeToMarket=s.TimeToMarket,t.DownTime=s.DownTime,t.Status=s.Status,t.Warranty=s.Warranty,t.ModelClassificationId=s.ModelClassificationId,t.CreateTime=s.CreateTime,t.UpdateTime=s.UpdateTime
	WHEN NOT MATCHED BY TARGET THEN 
	iNSERT (id,ModelId,Generation,Year,IsAdvancedYear,Name,NowMsrp,StyleBodyTypeId,ProductionSaleStatus,TimeToMarket,DownTime,Status,Warranty,BitautoId,ModelYearId,ModelClassificationId,CreateTime,UpdateTime) 
	VALUES(S.id,s.ModelId,s.Generation,s.Year,s.IsAdvancedYear,s.Name,s.NowMsrp,s.StyleBodyTypeId,s.ProductionSaleStatus,s.TimeToMarket,s.DownTime,s.Status,s.Warranty,s.id,s.ModelYearId,s.ModelClassificationId,s.CreateTime,s.UpdateTime)
	--HEN NOT MATCHED BY SOURCE 
--THEN DELETE
	OUTPUT $action AS [action],inserted.id AS 插入的id,
	Inserted.Name AS 插入的desc,
	deleted.id AS 删除的id,
	deleted.Name AS 删除的desc;
	SET IDENTITY_INSERT dbo.Style OFF

--更新车型信息结束

--车型颜色

--更新车身颜色

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StyleJoinColor') and o.name = 'FK_ModelColor_StyleJoinColor')
--alter table StyleJoinColor
--   drop constraint FK_ModelColor_StyleJoinColor
--GO

--if exists (select 1
--   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
--   where r.fkeyid = object_id('StyleJoinColor') and o.name = 'FK_Style_StyleJoinColor')
--alter table StyleJoinColor
--   drop constraint FK_Style_StyleJoinColor
--go

SET IDENTITY_INSERT dbo.StyleJoinColor ON
IF OBJECT_ID(N'tempdb..#temp_StyleJoinColor',N'U') IS NOT NULL
DROP TABLE #temp_StyleJoinColor

SELECT a.Id,StyleId,ColorId,a.CreateTime,a.UpdateTime
INTO #temp_StyleJoinColor
FROM CarsDataV3.dbo.StyleJoinColor a
INNER JOIN dbo.Style b ON a.StyleId = b.Id
INNER JOIN ModelColor c ON a.ColorId = c.Id

--SELECT * FROM CarsDataV3.dbo.ModelColor WHERE UpdateTime <'1753-01-01' OR UpdateTime IS null
MERGE INTO dbo.StyleJoinColor AS T 
USING #temp_StyleJoinColor AS S
ON T.id = s.id 
WHEN MATCHED AND CAST(s.UpdateTime AS DATETIME) > CAST(t.UpdateTime AS DATETIME)
THEN UPDATE SET t.ColorId=s.ColorId,t.StyleId=s.StyleId,t.CreateTime = CASE WHEN s.CreateTime IS null THEN GETDATE() WHEN s.CreateTime<'1753-01-01' THEN GETDATE() ELSE   CAST(s.CreateTime AS DATETIME) END,t.UpdateTime = CASE WHEN s.UpdateTime IS null THEN null WHEN s.UpdateTime<'1753-01-01' THEN NULL ELSE   CAST(s.UpdateTime AS DATETIME) END

WHEN NOT MATCHED BY TARGET THEN 
iNSERT (id,ColorId,StyleId,CreateTime,UpdateTime) VALUES(s.id,s.ColorId,s.StyleId,CASE  WHEN s.CreateTime IS null THEN GETDATE() WHEN s.CreateTime<'1753-01-01' THEN GETDATE() ELSE   CAST(s.CreateTime AS DATETIME) END,CASE  WHEN s.UpdateTime IS null THEN null WHEN s.UpdateTime<'1753-01-01' THEN NULL ELSE   CAST(s.UpdateTime AS DATETIME) END)
--WHEN NOT MATCHED BY SOURCE 
--THEN DELETE
;

SET IDENTITY_INSERT dbo.StyleJoinColor OFF

--更新是否是跨界车

UPDATE A SET IsCrossover =1
FROM dbo.Style A
INNER JOIN CarsDataV3..Style B ON a.Id = b.Id
WHERE b.StyleBodyTypeId IN(8,9)

--更新易车编号信息
UPDATE CompanyGroup SET BitautoId = Id

UPDATE Make SET BitautoId = Id

UPDATE Manufacturer SET BitautoId = Id

UPDATE Model SET BitautoId = Id

UPDATE Style SET BitautoId = Id

update  dbo.Style
set Style.VehicleClassificationId = 1
where Style.Id in (
select Style.Id from Style 
inner join Model on Model.Id = Style.ModelId
inner join ModelClassification ON Model.ModelClassificationId = ModelClassification.Id
WHERE VehicleClassification=1
)

update dbo.Style
set Style.VehicleClassificationId = 2
where Style.Id in (
select Style.Id from CarsDataV3..Style 
inner join Model on Model.Id = Style.ModelId
inner join ModelClassification ON Model.ModelClassificationId = ModelClassification.Id
WHERE VehicleClassification=2
)




--alter table IAutosByTrim
--   add constraint FK_IAutosByTrim_Style foreign key (StyleId)
--      references dbo.Style (Id)
--GO


--GO
--alter table dbo.Make
--   add constraint FK_Make_Country foreign key (CountryId)
--      references dbo.Country (Id)
--       --增量更新国家结束
--GO  


--alter table dbo.Make
--   add constraint FK_CompanyGroup_Make foreign key (CompanyGroupId)
--      references CompanyGroup (Id)

--go

--alter table dbo.Manufacturer
--   add constraint FK_Manufacturer_Make foreign key (MakeId)
--      references dbo.Make (Id)
--go

--alter table dbo.Manufacturer
--   add constraint FK_ProduceType_Manufacturer foreign key (ProductType)
--      references ProduceType (ProduceTypeId)
--go

--alter table dbo.Model
--   add constraint FK_ModelClassification_Model foreign key (ModelClassificationId)
--      references dbo.ModelClassification (Id)
--go

--alter table dbo.Model
--   add constraint FK_Model_Manufacturer foreign key (ManufacturerId)
--      references dbo.Manufacturer (Id)
--go

--alter table dbo.ModelClassification
--   add constraint FK_VehicleClassification_ModelClassification foreign key (VehicleClassification)
--      references dbo.VehicleClassification (VehicleClassificationId)
--go

--alter table ModelColor
--   add constraint FK_Model_ModelColor foreign key (ModelId)
--      references dbo.Model (Id)
--go

--alter table dbo.ModelYear
--   add constraint FK_ModelYear_Model foreign key (ModelId)
--      references dbo.Model (Id)
--go

--alter table dbo.Style
--   add constraint FK_ModelClassification_Style foreign key (ModelClassificationId)
--      references dbo.ModelClassification (Id)
--go

--alter table dbo.Style
--   add constraint FK_ProductionSaleStatus_Style foreign key (ProductionSaleStatus)
--      references ProductionSaleStatus (ProductionSaleStatusId)
--go

--alter table dbo.Style
--   add constraint FK_StyleBodyType_Style foreign key (StyleBodyTypeId)
--      references dbo.StyleBodyType (Id)
--go

--alter table dbo.Style
--   add constraint FK_Style_Model foreign key (ModelId)
--      references dbo.Model (Id)
--go

--alter table dbo.Style
--   add constraint FK_Style_ModelYear foreign key (ModelYearId)
--      references dbo.ModelYear (ModelYearId)
--go

--alter table dbo.StyleBodyType
--   add constraint FK_StyleBodyType_ModelClassification foreign key (ModelClassificationId)
--      references dbo.ModelClassification (Id)
--go

--alter table StyleJoinColor
--   add constraint FK_ModelColor_StyleJoinColor foreign key (ColorId)
--      references ModelColor (Id)
--go

--alter table StyleJoinColor
--   add constraint FK_Style_StyleJoinColor foreign key (StyleId)
--      references dbo.Style (Id)
--go

--alter table StyleMapMiddle
--   add constraint FK_StyleMapMiddle_StyleMap foreign key (StyleMapId)
--      references StyleMap (Id)
--go

--alter table StyleProperty
--   add constraint FK_StylePropertyCode_StyleProperty foreign key (DicId)
--      references StylePropertyDic (Id)
--go

--alter table StyleProperty
--   add constraint FK_StylePropertyGroup_StyleProperty foreign key (GroupId)
--      references StylePropertyGroup (Id)
--go

--alter table StyleProperty
--   add constraint FK_StylePropertyPhysicalTable_StyleProperty foreign key (StylePropertyPhysicalTableId)
--      references StylePropertyPhysicalTable (Id)
--go

--alter table StyleProperty
--   add constraint FK_StylePropertyType_StyleProperty foreign key (StylePropertyTypeId)
--      references StylePropertyType (StylePropertyTypeId)
--go

--alter table StylePropertyDicSchema
--   add constraint FK_StylePropertyCode_StylePropertyCodeSchema foreign key (DicId)
--      references StylePropertyDic (Id)
--go

--alter table StylePropertyValue
--   add constraint FK_StylePropertyValue_Style foreign key (TrimId)
--      references dbo.Style (Id)
--go

--alter table StylePropertyValueTable
--   add constraint FK_Style_StylePropertyValueTable foreign key (TrimId)
--      references dbo.Style (Id)
--go


