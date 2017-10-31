USE [Billing1]
GO

/****** Object:  StoredProcedure [dbo].[usp_MonthlyStockReport]    Script Date: 10/10/17 18:29:53 ******/
DROP PROCEDURE [dbo].[usp_MonthlyStockReport]
GO

/****** Object:  StoredProcedure [dbo].[usp_MonthlyStockReport]    Script Date: 10/10/17 18:29:53 ******/
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


DECLARE @Sql NVARCHAR(300)
DECLARE @WhereSql NVARCHAR(200)

SET @Sql ='SELECT [StockID]
      ,a.[ProductID]
	  ,b.ProductName
      ,a.[Make]
      ,a.[Quantity]
      ,a.[UnitID]
      ,a.[SizeID]
	  ,c.SizeName
      ,a.[RatePerUnit]
      ,a.[TaxID]
	  ,d.TaxName
      ,a.[Tax]
      ,a.[TaxAmount]
      ,a.[Discount]
      ,a.[DiscountAmount]
      ,a.[TotalAmount]
      ,a.[Remark]
      ,a.[IsActive]
      ,a.[CreatedOn]
      ,a.[UpdatedOn]
      ,a.[CreatedBy]
      ,a.[UpdatedBy]  
  FROM [dbo].[tblStock] a 
  JOIN [dbo].[tblProduct] b ON a.ProductID = b.ProductID
  JOIN [dbo].[tblSize] c ON a.SizeID = c.SizeID
  JOIN [dbo].[tblTax] d ON a.TaxID = d.TaxID
  WHERE a.CreatedOn >= @FromDate AND
  a.UpdatedOn <= @Todate'

  SET @WhereSql='1=1'

 
 IF(@FromDate IS NOT NULL AND @FromDate <> '')
 BEGIN 
  SET @WhereSql= @WhereSql + 'AND tblStock.CreatedDate>=' + @FromDate
 END 

 IF(@Todate IS NOT NULL AND @Todate <>'')
 BEGIN 
  SET @WhereSql =@WhereSql+ 'AND tblStock.UpdatedOn <=' + @ToDate
 END 
  IF(@Make IS NOT NULL AND @Make <>'')
	BEGIN 
	 SET @WhereSql =@WhereSql + 'AND tblProduct.Make LIKE %' +@Make +'%'
	END

	IF(@ProductID IS NOT NULL AND @ProductID>0)
	BEGIN 
	 SET @WhereSql=@WhereSql + 'AND tblProduct.ProductID =' +@ProductID
	END

	SET @Sql= @Sql + @WhereSql
	PRINT @Sql
	EXEC SP_EXECUTESQL @Sql

END

GO


