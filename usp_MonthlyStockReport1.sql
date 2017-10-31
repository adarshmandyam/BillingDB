USE [Billing1]
GO

/****** Object:  StoredProcedure [dbo].[usp_MonthlyStockReport]    Script Date: 11/10/17 22:15:28 ******/
DROP PROCEDURE [dbo].[usp_MonthlyStockReport]
GO

/****** Object:  StoredProcedure [dbo].[usp_MonthlyStockReport]    Script Date: 11/10/17 22:15:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_MonthlyStockReport]

@FromDate datetime,

@Todate datetime,

@ProductID INT,

@Make NVARCHAR(100)

AS

BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from

	-- interfering with SELECT statements.

	SET NOCOUNT ON;







DECLARE @Sql NVARCHAR(MAX)

DECLARE @WhereSql NVARCHAR(MAX)

--[StockID] ,a.[ProductID] ,a.[UnitID] ,a.[SizeID],a.[TaxID],a.[IsActive]
	  --,a.[CreatedOn]
	  --,a.[UpdatedOn]
	  --,a.[CreatedBy]
	  --,a.[UpdatedBy]


SET @Sql =' SELECT
	  b.ProductName
      ,a.[Make]
      ,a.[Quantity]
      ,c.SizeName
      ,a.[RatePerUnit]	  
	  ,d.TaxName
	  ,a.[Tax]
	  ,a.[TaxAmount]
	  ,a.[Discount]
	  ,a.[DiscountAmount]
	  ,a.[TotalAmount]
	  ,a.[Remark]	  
  FROM [dbo].[tblStock] a
  JOIN [dbo].[tblProduct] b ON a.ProductID = b.ProductID
  JOIN [dbo].[tblSize] c ON a.SizeID = c.SizeID
  JOIN [dbo].[tblTax] d ON a.TaxID = d.TaxID '

  --WHERE a.CreatedOn >= @FromDate AND

 -- a.UpdatedOn <= @Todate'




 --SET @WhereSql='WHERE 1=1 '


IF(@FromDate IS NOT NULL AND @FromDate <> '')

 BEGIN 

  SET @WhereSql= ' WHERE a.CreatedOn >= ''' + CONVERT(VARCHAR,@FromDate,101)+ ''''

 END 

 IF(@Todate IS NOT NULL AND @Todate <>'')
 BEGIN
  SET @WhereSql =@WhereSql+ 'AND (a.UpdatedOn <=''' + CONVERT(VARCHAR,@ToDate,101) +'''' + 'OR a.UpdatedOn IS NULL) '
 END 

  IF(@Make IS NOT NULL AND @Make <>'')

	BEGIN 

	 SET @WhereSql =@WhereSql + ' AND b.Make =' + '''' + @Make + ''''

	END




	IF(@ProductID IS NOT NULL AND @ProductID>0)

	BEGIN 

	 SET @WhereSql=@WhereSql + ' AND b.ProductID =' + CONVERT(NVARCHAR(10),@ProductID)

	END
	
	PRINT @Sql
	PRINT 'Demarcation'
	PRINT @WhereSql
	DECLARE @FinalSql NVARCHAR(MAX)
	SET @FinalSql= @Sql + @WhereSql
	PRINT @FinalSql
	EXEC SP_EXECUTESQL @FinalSql
END
GO


