USE [Billing1]
GO
/****** Object:  StoredProcedure [dbo].[Delete_DeliveryNote]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_DeliveryNote]
	-- Add the parameters for the stored procedure here
	   @DeliveryNoteID int,	   
	   @UpdatedBy int
	   
AS
BEGIN

			
		
			UPDATE [dbo].[tblDeliveryNote]
			SET IsActive =0	,
			[UpdatedOn] = getdate(),
			[UpdatedBy] = @UpdatedBy			   
			WHERE DeliveryNoteID = @DeliveryNoteID			
		
		
		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Inventory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_Inventory]
	-- Add the parameters for the stored procedure here
	   @InventoryID int,	   
	   @UpdatedBy int
	   
AS
BEGIN

			
		
			UPDATE [dbo].[tblInventory]
			SET IsActive =0	,
			[UpdatedOn] = getdate(),
			[UpdatedBy] = @UpdatedBy			   
			WHERE InventoryID = @InventoryID			
		
		
		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Invoice]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_Invoice]
	-- Add the parameters for the stored procedure here
	   @Invoice int,	   
	   @UpdatedBy int
	   
AS
BEGIN

			
		
			UPDATE [dbo].[tblInvoice]
			SET IsActive =0	,
			[UpdatedOn] = getdate(),
			[UpdatedBy] = @UpdatedBy			   
			WHERE InvoiceID = @Invoice
			
		
		
		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Product]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Product]
	-- Add the parameters for the stored procedure here
	   @ProductID int,
	   @UpdatedOn Datetime,
	   @UpdatedBy int,
	   @Check varchar(10)output
	   
AS
BEGIN
SET @Check ='0'
    -- Insert statements for procedure here
     if((@ProductID IS NOT NULL) OR ( @ProductID != 0 ))	
	BEGIN	
	 -- Update statements for procedure here	 
			
		
			UPDATE [dbo].[tblProduct]
			SET IsActive =0	,
			[UpdatedOn] = @UpdatedOn,
			[UpdatedBy] = @UpdatedBy			   
			WHERE [ProductID] = @ProductID
			SET @check='1'
		
		
	END	
	else
		BEGIN
			SET @check='0'
		END		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_ProductCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_ProductCategory]
	-- Add the parameters for the stored procedure here
	   @ProductCategoryID int,
	   @UpdatedOn Datetime,
	   @UpdatedBy int,
	   @Check varchar(10)output
AS
BEGIN
	SET @Check ='0'
    -- Insert statements for procedure here
    if((@ProductCategoryID IS NOT NULL) OR ( @ProductCategoryID != 0 ))	
	BEGIN	
	 -- Update statements for procedure here
	 Declare @tblProductAvailable int
	 SET @tblProductAvailable = (SELECT COUNT(ProductCategoryId) FROM tblProduct  WHERE [ProductCategoryID] =  @ProductCategoryID)
	 Declare @tblSubProductAvailable int
	 SET @tblSubProductAvailable = (SELECT COUNT(ProductCategoryId) FROM tblProductSubCategory  WHERE [ProductCategoryID] = @ProductCategoryID)	
      if(@tblSubProductAvailable = 0 AND @tblProductAvailable = 0 )
		BEGIN 	
		
			UPDATE [dbo].[tblProductCategory]
			SET IsActive =0	,
			[UpdatedOn] = @UpdatedOn,
			[UpdatedBy] = @UpdatedBy			   
			WHERE [ProductCategoryID] = @ProductCategoryID
			SET @check='1'
		END	
		else
		BEGIN
			SET @check='0'
		END	
	END		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_ProductSubCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_ProductSubCategory]
	-- Add the parameters for the stored procedure here
	   @ProductSubCategoryID int,	   
	   @UpdatedOn Datetime,
	   @UpdatedBy int,
	   @Check varchar(10)output
	   
AS
BEGIN
	SET @Check ='0'
    -- Insert statements for procedure here
    if((@ProductSubCategoryID IS NOT NULL) OR ( @ProductSubCategoryID != 0 ))	
	BEGIN
	 -- Update statements for procedure here
	 Declare @tblProductAvailable int
	 SET @tblProductAvailable = (SELECT COUNT([ProductSubCategoryID]) FROM tblProduct  WHERE [ProductSubCategoryID] =  @ProductSubCategoryID)
	 
	 if(@tblProductAvailable = 0 )
	 BEGIN	       
		UPDATE [dbo].[tblProductSubCategory]
		SET IsActive =0,				   
			[UpdatedOn] = @UpdatedOn,
			[UpdatedBy] = @UpdatedBy	
		WHERE [ProductSubCategoryID]= @ProductSubCategoryID		
		SET @check='1'
	END
	else
		
		BEGIN
			SET @check='0'
		END	
	
	
	END		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Quotation]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_Quotation]
	-- Add the parameters for the stored procedure here
	   @QuotationID int,	   
	   @UpdatedBy int
	   
AS
BEGIN

			
		
			UPDATE [dbo].[tblQuotation]
			SET IsActive =0	,
			[UpdatedOn] = getdate(),
			[UpdatedBy] = @UpdatedBy			   
			WHERE QuotationID = @QuotationID			
		
		
		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Size]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_Size]
	-- Add the parameters for the stored procedure here
	   @SizeID int,
	
	   @UpdatedBy int,
	   @Check varchar(10)output
AS
BEGIN
	SET @Check ='0'
    -- Insert statements for procedure here
    if((@SizeID IS NOT NULL) OR ( @SizeID != 0 ))	
	BEGIN	
   IF (NOT EXISTS(SELECT 1  FROM tblProduct  WHERE SizeID =  @SizeID) AND NOT EXISTS(SELECT 1  FROM tblInventoryItem  WHERE SizeID =  @SizeID))
     BEGIN 			
		
			UPDATE [dbo].[tblSize]
			SET IsActive =0	,
			[UpdatedOn] = getdate(),
			[UpdatedBy] = @UpdatedBy			   
			WHERE [SizeID] = @SizeID
			SET @check='1'
		END	
		else
		BEGIN
			SET @check='0'
		END	
	END		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Tax]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_Tax]
	-- Add the parameters for the stored procedure here
	   @TaxID int,	 
	   @UpdatedBy int,
	   @Check varchar(10)output
AS
BEGIN
	SET @Check ='0'
    -- Insert statements for procedure here
    if((@TaxID IS NOT NULL) OR ( @TaxID != 0 ))	
	BEGIN	
	 -- Update statements for procedure here
	 Declare @tblProductAvailable int
	 SET @tblProductAvailable = (SELECT COUNT(ProductCategoryId) FROM tblProduct  WHERE TaxID =  @TaxID)
	 Declare @tblInventoryItemAvailable int
	 SET @tblInventoryItemAvailable = (SELECT COUNT(InventoryItemID) FROM tblInventoryItem  WHERE TaxID = @TaxID)	
      if(@tblInventoryItemAvailable = 0 AND @tblProductAvailable = 0 )
		BEGIN 	
		
			UPDATE [dbo].[tblTax]
			SET IsActive =0	,
			[UpdatedOn] = getdate(),
			[UpdatedBy] = @UpdatedBy			   
			WHERE [TaxID] = @TaxID
			SET @check='1'
		END	
		else
		BEGIN
			SET @check='0'
		END	
	END		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_tblStock]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_tblStock]
	-- Add the parameters for the stored procedure here
	   @StockID int,
	   @UpdatedOn Datetime,
	   @UpdatedBy int,
	   @Check varchar(10)output
	   
AS
BEGIN
SET @Check ='0'
    -- Insert statements for procedure here
     if((@StockID IS NOT NULL) OR ( @StockID != 0 ))	
	BEGIN	
	 -- Update statements for procedure here	 
			
		
			UPDATE [dbo].[tblStock]
			SET IsActive =0	,
			[UpdatedOn] = @UpdatedOn,
			[UpdatedBy] = @UpdatedBy			   
			WHERE [StockID] = @StockID
			SET @check='1'
		
		
	END	
	else
		BEGIN
			SET @check='0'
		END		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Unit]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_Unit]
	-- Add the parameters for the stored procedure here
	   @UnitID int,
	
	   @UpdatedBy int,
	   @Check varchar(10)output
AS
BEGIN
	SET @Check ='0'
    -- Insert statements for procedure here
    if((@UnitID IS NOT NULL) OR ( @UnitID != 0 ))	
	BEGIN	
	 -- Update statements for procedure here
	 Declare @tblProductAvailable int
	 Declare @tblSizeAvailable int
	 SET @tblProductAvailable = (SELECT COUNT(UnitID) FROM tblProduct  WHERE UnitID =  @UnitID)	
	 SET  @tblSizeAvailable=(SELECT COUNT(UnitID) FROM tblSize  WHERE UnitID =  @UnitID)	
      if(@tblProductAvailable = 0 OR @tblSizeAvailable=0)
		BEGIN 	
		
			UPDATE [dbo].[tblUnit]
			SET IsActive =0	,
			[UpdatedOn] = getdate(),
			[UpdatedBy] = @UpdatedBy			   
			WHERE UnitID = @UnitID
			SET @check='1'
		END	
		else
		BEGIN
			SET @check='0'
		END	
	END		
END


GO
/****** Object:  StoredProcedure [dbo].[Get_Product]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Product]
--@ProductID  int =null 	                 
AS
BEGIN

SELECT
	   [ProductID]	  	
	  ,[ProductName] 
	
	  
  FROM [dbo].[tblProduct] AS Prod	
  WHERE Prod.IsActive = 1
 -- AND ProductID= @ProductID
		
END


GO
/****** Object:  StoredProcedure [dbo].[Get_UserDetails]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_UserDetails]
@UserName  varchar(50),
@Password varchar(50)
	                 
AS
BEGIN

SELECT *   
	  
  FROM [dbo].[User] 
WHERE UserName=@UserName
AND
 Password=@Password
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_DeliveryMode]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_DeliveryMode]
--@ProductCategoryID  int              
AS
BEGIN

SELECT [DeliveryModeID]
      ,[DeliveryMode]       
  FROM [dbo].[tblDeliveryMode]
  
  WHERE IsActive = 1 
  --AND [ProductCategoryID]= @ProductCategoryID
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_DeliveryNote]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_DeliveryNote]
@DeliveryNoteID  int = null                
AS
BEGIN

SELECT [DeliveryNoteID]
      ,[InvoiceID]
      ,[CustomerName]
      ,D.[DeliveryModeID]   
      ,DM.[DeliveryMode]      
      ,[DeliveryDate]
      ,[EstimatedDeliveryDate]
      ,[Remarks]
      ,D.[IsActive]
      ,[CreatedOn]
      ,[UpdatedOn]
      ,[CreatedBy]
      ,[UpdatedBy]
      ,D.[DeliveryModeID]
      ,DM.[DeliveryMode]
      
      
  FROM [dbo].[tblDeliveryNote] D
  INNER JOIN  [dbo].[tblDeliveryMode] DM ON D.DeliveryModeID = DM.DeliveryModeID
  WHERE  D.IsActive = 1 and
  (@DeliveryNoteID is null or DeliveryNoteID=@DeliveryNoteID)  
  
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_DeliveryNoteItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_DeliveryNoteItem]
@DeliveryNoteID  int	= NULL,
@DeliveryNoteItemID int = NULL
                
AS
BEGIN

SELECT 
  [DeliveryNoteItemID]
		  ,[DeliveryNoteID]
      ,invoiceItem.[ProductID]
      ,invoiceItem.[Make]
      ,[Quantity]
      ,invoiceItem.[UnitID]
      ,invoiceItem.[SizeID]
      ,invoiceItem.[RatePerUnit]
      ,invoiceItem.[TaxID]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[TotalAmount]
      ,invoiceItem.[Remark]
      ,invoiceItem.[IsActive]
      ,invoiceItem.[CreatedOn]
      ,invoiceItem.[UpdatedOn]
      ,invoiceItem.[CreatedBy]
      ,invoiceItem.[UpdatedBy]
	  ,Size.SizeName as Size
	  ,Tax.TaxPercentage
	  ,Tax.TaxName
	  ,Prod.Discount
	  ,Prod.ProductName	AS ProductDesc  
  FROM [dbo].[tblDeliveryNoteItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

    WHERE  (@DeliveryNoteID IS NULL OR DeliveryNoteID=@DeliveryNoteID) AND  (@DeliveryNoteItemID IS NULL OR DeliveryNoteItemID=@DeliveryNoteItemID) AND invoiceItem.IsActive = 1   

END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Inventory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAll_Inventory]
@InventoryID  int = null                
AS
BEGIN


SELECT InventoryID,
 [InvoiceNo],
							  [BillingAddress],
							  [ShippingAddress],
							  [GSTIN]
      ,[CompanyName]
      ,[ContactPersonName]
      ,[ContactNumber]
      ,[Email]
      ,[Website]
      ,I.[PaymentModeID]
      ,PM.[PaymentMode]
      , CASE I.IsPaid WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE 'No' END AS [IsPaid] 
      , CASE I.IsOnCredit WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE 'No' END AS [IsOnCredit]
      ,[IsOnCredit]
      ,[InventoryDate]
      ,[ItemsReceivedOn]
      ,[PaymentDate]
      ,[TotalTaxAmount]  
      ,[TotalAmount]         
      ,[Remarks]
      ,I.[IsActive]
      ,[CreatedOn]
      ,[UpdatedOn]
      ,[CreatedBy]
      ,[UpdatedBy]
  FROM [dbo].[tblInventory] I
  INNER JOIN  [dbo].[tblPaymentMode] PM ON I.PaymentModeID = PM.PaymentModeID
  WHERE  I.IsActive = 1 and
  (@InventoryID is null or
 InventoryID=@InventoryID)  
  
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_InventoryItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_InventoryItem]
@InventoryID  int	= NULL,
@InventoryItemID int = NULL
                
AS
BEGIN

SELECT [InventoryItemID]
      ,[InventoryID]
     ,invoiceItem.[ProductID]
      ,invoiceItem.[Make]
      ,[Quantity]
      ,invoiceItem.[UnitID]
      ,invoiceItem.[SizeID]
      ,invoiceItem.[RatePerUnit]
      ,invoiceItem.[TaxID]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[TotalAmount]
      ,invoiceItem.[Remark]
      ,invoiceItem.[IsActive]
      ,invoiceItem.[CreatedOn]
      ,invoiceItem.[UpdatedOn]
      ,invoiceItem.[CreatedBy]
      ,invoiceItem.[UpdatedBy]
	  ,Size.SizeName as Size
	  ,Tax.TaxPercentage
	  ,Tax.TaxName
	  ,Prod.Discount
	  ,Prod.ProductName	AS ProductDesc  
	    ,HSN_SAC
  FROM [dbo].[tblInventoryItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InventoryID IS NULL OR @InventoryID=InventoryID) AND  (@InventoryItemID IS NULL OR InventoryItemID=@InventoryItemID)   
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_InventoryItem_Report]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAll_InventoryItem_Report] 
@InventoryID  int	= NULL,
@InventoryItemID int = NULL
                
AS
BEGIN

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp

CREATE TABLE #Temp
(
    Product  Varchar(250), 
    HSN_SAC Varchar(100), 
    Quantity  Varchar(100), 
	Rate  Varchar(100), 
	Discount  Varchar(100), 
	CGST  Varchar(100), 
	SGST  Varchar(100), 
	TotalAmount  Varchar(100)
)

insert into #Temp

   SELECT
      Prod.ProductName	AS Product 
	  ,CONVERT(Varchar(255), HSN_SAC)  AS  HSN_SAC
      ,CONVERT(Varchar(255), Quantity)  AS[Quantity]
      
      , CONVERT(Varchar(255), invoiceItem.[RatePerUnit])  AS Rate  
	   ,  CONVERT(Varchar(255),  invoiceItem.DiscountAmount) as Discount
      , CONVERT(Varchar(255),  convert(decimal(10, 2),  (TaxAmount/2)))  AS CGST
	  , CONVERT(Varchar(255),  convert(decimal(10, 2),  (TaxAmount/2)))  AS SGST
      ,  CONVERT(Varchar(255),  [TotalAmount]) as TotalAmount   

	 
 FROM [dbo].[tblInventoryItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InventoryID IS NULL OR @InventoryID=InventoryID) AND  
  (@InventoryItemID IS NULL OR InventoryItemID=@InventoryItemID)  
   
  insert into #Temp

     select
    null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null	AS CGST
	  , null	AS SGST
      , null	AS [TotalAmount]

  insert into #Temp

    SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , NULL  AS CGST
	  , 'CGST'	AS SGST
      , CONVERT(Varchar(255), SUM( convert(decimal(10, 2),  (TaxAmount/2))))	AS [TotalAmount]

	 
 FROM [dbo].[tblInventoryItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InventoryID IS NULL OR @InventoryID=InventoryID) AND  
  (@InventoryItemID IS NULL OR InventoryItemID=@InventoryItemID)   

   insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'SGST'  AS SGST
      , CONVERT(Varchar(255), SUM( convert(decimal(10, 2),  (TaxAmount/2))))	AS [TotalAmount]

	 
 FROM [dbo].[tblInventoryItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InventoryID IS NULL OR @InventoryID=InventoryID) AND  
  (@InventoryItemID IS NULL OR InventoryItemID=@InventoryItemID)   

  insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'Total Tax'  AS SGST
      , CONVERT(Varchar(255), SUM( convert(decimal(10, 2),  (TaxAmount))))	AS [TotalAmount]

	 
 FROM [dbo].[tblInventoryItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InventoryID IS NULL OR @InventoryID=InventoryID) AND  
  (@InventoryItemID IS NULL OR InventoryItemID=@InventoryItemID)   

   insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'Total Excl GST'	AS SGST
      ,  CONVERT(Varchar(255),  (SUM(TotalAmount)-SUM(TaxAmount))) as TotalAmount   

	 
  FROM [dbo].[tblInventoryItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InventoryID IS NULL OR @InventoryID=InventoryID) AND  
  (@InventoryItemID IS NULL OR InventoryItemID=@InventoryItemID)   


    insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'Total Amount'	AS SGST
      ,  CONVERT(Varchar(255),  SUM(TotalAmount)) as TotalAmount   

	 
 FROM [dbo].[tblInventoryItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InventoryID IS NULL OR @InventoryID=InventoryID) AND  
  (@InventoryItemID IS NULL OR InventoryItemID=@InventoryItemID)  

    select * from #Temp

END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Invoice]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_Invoice]
@InvoiceID  int	 =null                
AS
BEGIN

SELECT [InvoiceID]
      ,[CustomerName]
      ,[ContactNumber]
      ,[Email]
      ,[Website]      
      ,[PaymentModeID]
      ,Case when [IsPaid]=1 then 'Yes' else 'No' end [IsPaid]
      , case when [IsOnCredit] =1 then 'Yes'else 'No'  end [IsOnCredit]
      ,[InvoiceDate]
      ,[PaymentExpectedBy]
      ,[Remarks]
      ,[IsActive]
      ,[CreatedOn]
      ,[UpdatedOn]
      ,[CreatedBy]
      ,[UpdatedBy]	  
	   ,[InvoiceNo]
      ,[BillingAddress]
      ,[ShippingAddress]
      ,[InvoiceType]
      ,[GSTIN]
  FROM [dbo].[tblInvoice]
  WHERE  (@InvoiceID is null or @InvoiceID=InvoiceID) and IsActive = 1   
  
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_InvoiceItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_InvoiceItem]
@InvoiceID  int	= NULL,
@InvoiceItemID int = NULL
                
AS
BEGIN

SELECT [InvoiceItemID]
      ,[InvoiceID]
      ,invoiceItem.[ProductID]
      ,invoiceItem.[Make]
      ,[Quantity]
      ,invoiceItem.[UnitID]
      ,invoiceItem.[SizeID]
      ,invoiceItem.[RatePerUnit]
      ,invoiceItem.[TaxID]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[TotalAmount]
      ,invoiceItem.[Remark]
      ,invoiceItem.[IsActive]
      ,invoiceItem.[CreatedOn]
      ,invoiceItem.[UpdatedOn]
      ,invoiceItem.[CreatedBy]
      ,invoiceItem.[UpdatedBy]
	  ,Size.SizeName as Size
	  ,Tax.TaxPercentage
	  ,Tax.TaxName
	  ,Prod.Discount
	  ,Prod.ProductName	AS ProductDesc  
	  ,HSN_SAC
	  ,(TaxAmount/2) AS CGST
	  ,(TaxAmount/2) AS SGST
  FROM [dbo].[tblInvoiceItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]


  WHERE  (@InvoiceID IS NULL OR InvoiceID=@InvoiceID) AND  (@InvoiceItemID IS NULL OR InvoiceItemID=@InvoiceItemID) AND invoiceItem.IsActive = 1    
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_InvoiceItem_Report]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAll_InvoiceItem_Report] 
@InvoiceID  int	= NULL,
@InvoiceItemID int = NULL
                
AS
BEGIN

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp

CREATE TABLE #Temp
(
    Product  Varchar(250), 
    HSN_SAC Varchar(100), 
    Quantity  Varchar(100), 
	Rate  Varchar(100), 
	Discount  Varchar(100), 
	CGST  Varchar(100), 
	SGST  Varchar(100), 
	TotalAmount  Varchar(100)
)

insert into #Temp

   SELECT
      Prod.ProductName	AS Product 
	  ,CONVERT(Varchar(255), HSN_SAC)  AS  HSN_SAC
      ,CONVERT(Varchar(255), Quantity)  AS[Quantity]
      
      , CONVERT(Varchar(255), invoiceItem.[RatePerUnit])  AS Rate  
	   ,  CONVERT(Varchar(255),  invoiceItem.DiscountAmount) as Discount
      , CONVERT(Varchar(255),  convert(decimal(10, 2),  (TaxAmount/2)))  AS CGST
	  , CONVERT(Varchar(255),  convert(decimal(10, 2),  (TaxAmount/2)))  AS SGST
      ,  CONVERT(Varchar(255),  [TotalAmount]) as TotalAmount   

	 
    FROM [dbo].[tblInvoiceItem] invoiceItem
    INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

   WHERE  (@InvoiceID IS NULL OR InvoiceID=@InvoiceID) AND  (@InvoiceItemID IS NULL OR InvoiceItemID=@InvoiceItemID) AND invoiceItem.IsActive = 1    
   
  insert into #Temp

     select
    null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null	AS CGST
	  , null	AS SGST
      , null	AS [TotalAmount]

  insert into #Temp

    SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , NULL  AS CGST
	  , 'CGST'	AS SGST
      , CONVERT(Varchar(255), SUM( convert(decimal(10, 2),  (TaxAmount/2))))	AS [TotalAmount]

	 
    FROM [dbo].[tblInvoiceItem] invoiceItem
    INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

   WHERE  (@InvoiceID IS NULL OR InvoiceID=@InvoiceID) AND  (@InvoiceItemID IS NULL OR InvoiceItemID=@InvoiceItemID) AND invoiceItem.IsActive = 1    

   insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'SGST'  AS SGST
      , CONVERT(Varchar(255), SUM( convert(decimal(10, 2),  (TaxAmount/2))))	AS [TotalAmount]

	 
    FROM [dbo].[tblInvoiceItem] invoiceItem
    INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

   WHERE  (@InvoiceID IS NULL OR InvoiceID=@InvoiceID) AND  (@InvoiceItemID IS NULL OR InvoiceItemID=@InvoiceItemID) AND invoiceItem.IsActive = 1    

    insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'Total Tax'  AS SGST
      , CONVERT(Varchar(255), SUM( convert(decimal(10, 2),  (TaxAmount))))	AS [TotalAmount]

	 
    FROM [dbo].[tblInvoiceItem] invoiceItem
    INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

   WHERE  (@InvoiceID IS NULL OR InvoiceID=@InvoiceID) AND  (@InvoiceItemID IS NULL OR InvoiceItemID=@InvoiceItemID) AND invoiceItem.IsActive = 1    

   insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'Total Excl GST'	AS SGST
      ,  CONVERT(Varchar(255),  (SUM(TotalAmount)-SUM(TaxAmount))) as TotalAmount   

	 
    FROM [dbo].[tblInvoiceItem] invoiceItem
    INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

   WHERE  (@InvoiceID IS NULL OR InvoiceID=@InvoiceID) AND  (@InvoiceItemID IS NULL OR InvoiceItemID=@InvoiceItemID) AND invoiceItem.IsActive = 1    


    insert into #Temp

     SELECT
      null	AS Product 
	  , null	AS HSN_SAC
      , null	AS [Quantity]
      
      , null	AS Rate
	   , null	AS Discount
      , null AS CGST
	  , 'Total Amount'	AS SGST
      ,  CONVERT(Varchar(255),  SUM(TotalAmount)) as TotalAmount   

	 
    FROM [dbo].[tblInvoiceItem] invoiceItem
    INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

   WHERE  (@InvoiceID IS NULL OR InvoiceID=@InvoiceID) AND  (@InvoiceItemID IS NULL OR InvoiceItemID=@InvoiceItemID) AND invoiceItem.IsActive = 1    

    select * from #Temp

END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_PaymentMode]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_PaymentMode]
--@ProductCategoryID  int              
AS
BEGIN

SELECT [PaymentModeID]
      ,[PaymentMode]       
  FROM [dbo].[tblPaymentMode]
  
  WHERE IsActive = 1 
  --AND [ProductCategoryID]= @ProductCategoryID
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_PaymentModeItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_PaymentModeItem]
@PaymentModeID  int	= NULL,
@PaymentModeItemID int = NULL
                
AS
BEGIN

	SELECT [PaymentModeItemID]
		  ,[PaymentModeID]
		  ,[ProductID]
		  ,[Make]
		  ,[Quantity]
		  ,[Unit]
		  ,[SizeID]
		  ,[RatePerUnit]
		  ,[TaxID]
		  ,[TaxAmount]
		  ,[DiscountAmount]
		  ,[TotalAmount]
		  ,[Remark]
		  ,[IsActive]
		  ,[CreatedOn]
		  ,[UpdatedOn]
		  ,[CreatedBy]
		  ,[UpdatedBy]
	  FROM [dbo].[tblPaymentModeItem]
  WHERE  (@PaymentModeID IS NULL OR PaymentModeID=@PaymentModeID) AND  (@PaymentModeItemID IS NULL OR PaymentModeItemID=@PaymentModeItemID) AND IsActive = 1    
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Product]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_Product]
@ProductID  int =null 	                 
AS
BEGIN

SELECT
	   Prod.[ProductID]	  
	  ,Prod.[ProductCategoryID]
	  ,Prod.[ProductSubCategoryID]	  
	  ,Prod.[TaxID]
	  ,Prod.[SizeID]  	  
	  ,[ProductName] 
	  ,[ProductDescription]
	  
	  ,Cat.[CategoryName]
	  ,SubCat.[SubCategoryName]  
	  ,Tax.TaxName  
	  ,Tax.TaxPercentage    
      ,Size.[SizeName] 
	  
	  ,[Make]	        
      ,tUnit.Name AS [Unit] 
      ,[RatePerUnit]
      ,[Discount]
      ,[Remark] 
	  ,Prod.[UnitID]  
	  ,HSN_SAC
	  
  FROM [dbo].[tblProduct] AS Prod
	Left JOIN [dbo].[tblProductSubCategory] AS SubCat
	ON SubCat.ProductSubCategoryID = Prod.ProductSubCategoryID
	INNER JOIN [dbo].[tblProductCategory] AS Cat
	ON Prod.[ProductCategoryID]=Cat.[ProductCategoryID]
	INNER JOIN [dbo].[tblSize] AS Size
	ON Prod.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON Prod.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblUnit] AS tUnit
	ON Prod.[UnitID]=tUnit.[UnitID]	
  WHERE Prod.IsActive = 1
   AND(@ProductID IS NULL OR Prod.ProductID= @ProductID)	
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_ProductCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_ProductCategory]
--@ProductCategoryID  int              
AS
BEGIN

SELECT [ProductCategoryID]
      ,[CategoryName]
      ,[Description] 
	  ,HSN_SAC     
  FROM [dbo].[tblProductCategory]
  WHERE IsActive = 1 
  --AND [ProductCategoryID]= @ProductCategoryID
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_ProductSubCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_ProductSubCategory]
@ProductSubCategoryID  int  = null  , 
@ProductCategoryID    INT =null       
AS
BEGIN

SELECT [ProductSubCategoryID]
      ,[SubCategoryName]      
      ,[Description]      
  FROM [dbo].[tblProductSubCategory]
  WHERE IsActive = 1 
  AND ( @ProductSubCategoryID is null or ProductSubCategoryID=@ProductSubCategoryID)
  AND ( @ProductCategoryID is null or ProductCategoryID=@ProductCategoryID)
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_ProductSubCategoryWithProductCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_ProductSubCategoryWithProductCategory]
@ProductSubCategoryID int = null              
AS
BEGIN
	SELECT SubCat.[ProductSubCategoryID],SubCat.[ProductCategoryID],Cat.[CategoryName],
	SubCat.[SubCategoryName],SubCat.[Description],HSN_SAC

	FROM 
	[dbo].[tblProductSubCategory] AS SubCat
	INNER JOIN [dbo].[tblProductCategory] AS Cat
	ON SubCat.[ProductCategoryID]=Cat.[ProductCategoryID]
	WHERE SubCat.IsActive = 1
 -- AND SubCat.ProductSubCategoryID=@ProductSubCategoryID	  
  AND (@ProductSubCategoryID IS NULL OR SubCat.ProductSubCategoryID=@ProductSubCategoryID)


--And (@ProductId is null or ProductId=@ProductId )
                 		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Quotation]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAll_Quotation]
@QuotationID  int = null                
AS
BEGIN

SELECT [QuotationID]
      ,[CustomerName]
      ,[QuotationDate]
      ,[PurchaseExpectedBy]
      ,[Remarks]
      ,I.[IsActive]
      , I.[PaymentModeID]
      ,PM.[PaymentMode]
      ,[CreatedOn]
      ,[UpdatedOn]
      ,[CreatedBy]
      ,[UpdatedBy]
      
      
  FROM [dbo].[tblQuotation] I
  INNER JOIN  [dbo].[tblPaymentMode] PM ON I.PaymentModeID = PM.PaymentModeID
  WHERE  I.IsActive = 1 and
  (@QuotationID is null or QuotationID=@QuotationID)  
  
END



GO
/****** Object:  StoredProcedure [dbo].[GetAll_QuotationItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_QuotationItem]
@QuotationID  int	= NULL,
@QuotationItemID int = NULL
                
AS
BEGIN

	SELECT [QuotationItemID]
		  ,[QuotationID]
	    ,invoiceItem.[ProductID]
      ,invoiceItem.[Make]
      ,[Quantity]
      ,invoiceItem.[UnitID]
      ,invoiceItem.[SizeID]
      ,invoiceItem.[RatePerUnit]
      ,invoiceItem.[TaxID]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[TotalAmount]
      ,invoiceItem.[Remark]
      ,invoiceItem.[IsActive]
      ,invoiceItem.[CreatedOn]
      ,invoiceItem.[UpdatedOn]
      ,invoiceItem.[CreatedBy]
      ,invoiceItem.[UpdatedBy]
	  ,Size.SizeName as Size
	  ,Tax.TaxPercentage
	  ,Tax.TaxName
	  ,Prod.Discount
	  ,Prod.ProductName	AS ProductDesc  
  FROM [dbo].[tblQuotationItem] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]
  WHERE  (@QuotationID IS NULL OR QuotationID=@QuotationID) AND  (@QuotationItemID IS NULL OR QuotationItemID=@QuotationItemID) AND invoiceItem.IsActive = 1    
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Size]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_Size]
@SizeID  int  = null  ,  
@UnitID int = null         
AS
BEGIN

SELECT [SizeID]
      ,[SizeName]      
      ,[SizeDescription] 
	  ,tblSize.UnitID
	  , uni.Name   AS UnitName
  FROM [dbo].[tblSize]
  inner join [dbo].[tblUnit]  uni on  uni.UnitID=tblSize.UnitID
  WHERE tblSize.IsActive = 1
   AND(@SizeID IS NULL OR SizeID= @SizeID)	
   AND(@UnitID IS NULL OR tblSize.UnitID= @UnitID)	
   
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Stock]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetAll_Stock]
@StockID  int	= NULL
                
AS
BEGIN

SELECT 
       StockID
      ,invoiceItem.[ProductID]
      ,invoiceItem.[Make]
      ,[Quantity]
      ,invoiceItem.[UnitID]
      ,invoiceItem.[SizeID]
      ,invoiceItem.[RatePerUnit]
      ,invoiceItem.[TaxID]
      ,[TaxAmount]
      ,[DiscountAmount]
      ,[TotalAmount]
      ,invoiceItem.[Remark]
      ,invoiceItem.[IsActive]
      ,invoiceItem.[CreatedOn]
      ,invoiceItem.[UpdatedOn]
      ,invoiceItem.[CreatedBy]
      ,invoiceItem.[UpdatedBy]
	  ,Size.SizeName as Size
	  ,Tax.TaxPercentage
	  ,Tax.TaxName
	  ,Prod.Discount
	  ,Prod.ProductName	AS ProductDesc  
	   ,Prod.ProductName	
	   ,unit.Name AS Unit
  FROM [dbo].[tblStock] invoiceItem
  INNER JOIN [dbo].[tblSize] AS Size
	ON invoiceItem.[SizeID]=Size.[SizeID]	
	INNER JOIN [dbo].[tblTax] AS Tax
	ON invoiceItem.[TaxID]=Tax.[TaxID]	
	INNER JOIN [dbo].[tblProduct] AS Prod
	ON invoiceItem.[ProductID]=Prod.[ProductID]

	INNER JOIN [dbo].[tblUnit] AS unit
	ON invoiceItem.[UnitID]=unit.[UnitID]
    WHERE  (@StockID IS NULL OR StockID=@StockID) AND invoiceItem.IsActive = 1   

END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Tax]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll_Tax]
@TaxID  int  = null             
AS
BEGIN

SELECT *    
  FROM [dbo].[tblTax]
  WHERE IsActive = 1
   AND(@TaxID IS NULL OR TaxID= @TaxID)		
END


GO
/****** Object:  StoredProcedure [dbo].[GetAll_Unit]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetAll_Unit]
@UnitID  int  = null             
AS
BEGIN

SELECT [UnitID]
      ,[Name]      
      ,[Description]      
  FROM [dbo].[tblUnit]
  WHERE IsActive = 1
   AND(@UnitID IS NULL OR UnitID= @UnitID)	
		
END


GO
/****** Object:  StoredProcedure [dbo].[GetMax_Inventory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMax_Inventory]
              
AS
BEGIN
SELECT MAX([InventoryID]) As InvoiceID     
  FROM [dbo].[tblInventory] 
END


GO
/****** Object:  StoredProcedure [dbo].[GetMax_Invoice]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMax_Invoice]
              
AS
BEGIN
SELECT MAX([InvoiceID]) As InvoiceID     
  FROM [dbo].[tblInvoice] 
END


GO
/****** Object:  StoredProcedure [dbo].[InsertUpdate_Product]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUpdate_Product]
	-- Add the parameters for the stored procedure here
	   @ProductID int,	
	   @ProductCategoryID int,
       @ProductSubCategoryID int=null,
       @ProductName nvarchar(100),
       @ProductDescription nvarchar(500),
       @Make nvarchar(100),
       @Unit nvarchar(50),
       @TaxID int,
       @SizeID int,
       @RatePerUnit decimal(18,0),
       @Discount nvarchar(50),
       @Remark nvarchar(200),     
       @UpdatedOn DATETIME, 
       @CreatedBy int, 
       @UpdatedBy int ,
	   @UnitID int                 
AS
BEGIN

    -- Insert statements for procedure here    
    if((@ProductID IS NULL) OR ( @ProductID = 0 ))
	BEGIN
		INSERT INTO [dbo].[tblProduct]
			([ProductCategoryID]
           ,[ProductSubCategoryID]
           ,[ProductName]
           ,[ProductDescription]
           ,[Make]
           ,[Unit]
           ,[TaxID]
           ,[SizeID]
           ,[RatePerUnit]
           ,[Discount]
           ,[Remark]                      
           ,[UpdatedOn]
           ,[CreatedBy]
           ,[UpdatedBy]
		   ,UnitID)
		 VALUES
			   (
				  @ProductCategoryID ,
				  @ProductSubCategoryID ,
				  @ProductName ,
				  @ProductDescription ,
				  @Make,
				  @Unit,
				  @TaxID,
				  @SizeID,
				  @RatePerUnit,
				  @Discount,
				  @Remark, 
				  @UpdatedOn,
				  @CreatedBy,
				  @UpdatedBy,
				  @UnitID)
		
	END
	else 
	BEGIN
	 -- Update statements for procedure here
	UPDATE [dbo].[tblProduct]
	SET  						
	   [ProductCategoryID] = @ProductCategoryID
      ,[ProductSubCategoryID] = @ProductSubCategoryID
      ,[ProductName] = @ProductName
      ,[ProductDescription] = @ProductDescription
      ,[Make] = @Make
      ,[Unit] = @Unit
      ,[TaxID] = @TaxID
      ,[SizeID] = @SizeID
      ,[RatePerUnit] = @RatePerUnit
      ,[Discount] = @Discount
      ,[Remark] = @Remark
	  ,[UpdatedOn] = @UpdatedOn
	  ,[CreatedBy] = @CreatedBy
	  ,[UpdatedBy] = @UpdatedBy	  
	  ,UnitID	  =@UnitID 
	WHERE [ProductID] = @ProductID

		
	END
		
END


GO
/****** Object:  StoredProcedure [dbo].[InsertUpdate_ProductCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUpdate_ProductCategory]
	-- Add the parameters for the stored procedure here
	   @ProductCategoryID int,
	   @CategoryName nvarchar(100), 
       @Description nvarchar(500),    
	   @HSN_SAC int=null,   
       @UpdatedOn DATETIME, 
       @CreatedBy int, 
       @UpdatedBy int                   
AS
BEGIN

    -- Insert statements for procedure here
    if((@ProductCategoryID IS NULL) OR ( @ProductCategoryID = 0 ))
	BEGIN
		INSERT INTO [dbo].[tblProductCategory]
			   ([CategoryName]
			   ,[Description]			  			   
			   ,[UpdatedOn]
			   ,[CreatedBy]
			   ,[UpdatedBy]
			   ,HSN_SAC)
		 VALUES
			   (@CategoryName,
			   @Description,			   
			   @UpdatedOn,
			   @CreatedBy,
			   @UpdatedBy,
			   @HSN_SAC)
		
	END
	else 
	BEGIN
	 -- Update statements for procedure here
	UPDATE [dbo].[tblProductCategory]
	SET [CategoryName] = @CategoryName
		,[Description] = @Description			   		
		,[UpdatedOn] = @UpdatedOn
		,[CreatedBy] = @CreatedBy
		,[UpdatedBy] = @UpdatedBy	
		,HSN_SAC=@HSN_SAC	
			   
	WHERE [ProductCategoryID] = @ProductCategoryID

		
	END
		
END


GO
/****** Object:  StoredProcedure [dbo].[InsertUpdate_ProductSubCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUpdate_ProductSubCategory]
	-- Add the parameters for the stored procedure here
	   @ProductSubCategoryID int,
	   @ProductCategoryID int,
	   @SubCategoryName nvarchar(100), 
       @Description nvarchar(500),         
       @UpdatedOn DATETIME, 
       @CreatedBy int, 
       @UpdatedBy int   
AS
BEGIN

    -- Insert statements for procedure here
    if((@ProductSubCategoryID IS NULL) OR ( @ProductSubCategoryID = 0 ))
	BEGIN
		INSERT INTO [dbo].[tblProductSubCategory]
			([ProductCategoryID]
           ,[SubCategoryName]
           ,[Description]           
           ,[UpdatedOn]
           ,[CreatedBy]
           ,[UpdatedBy])
		 VALUES
			   (
				  
				   @ProductCategoryID,
				   @SubCategoryName, 				   
				   @Description,				  
				   @UpdatedOn,
				   @CreatedBy,
				   @UpdatedBy)
		
	END
	else 
	BEGIN
	 -- Update statements for procedure here
	UPDATE [dbo].[tblProductSubCategory]
	SET  
						
		[ProductCategoryID] = @ProductCategoryID
        ,[SubCategoryName]	= @SubCategoryName 
		,[Description] = @Description
		,[UpdatedOn] = @UpdatedOn
		,[CreatedBy] = @CreatedBy
		,[UpdatedBy] = @UpdatedBy
		
			   
	WHERE [ProductSubCategoryID] = @ProductSubCategoryID

		
	END
		
END


GO
/****** Object:  StoredProcedure [dbo].[InsertUpdate_Size]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertUpdate_Size]
	-- Add the parameters for the stored procedure here
	   @SizeID int,
	   @SizeName nvarchar(100), 	  
       @SizeDescription nvarchar(500),  	
       @CreatedBy int,
	   @UnitID int
                      
AS
BEGIN

    -- Insert statements for procedure here
    if((@SizeID IS NULL) OR ( @SizeID = 0 ))
	BEGIN
		INSERT INTO [dbo].[tblSize]
			   (SizeName
			   ,SizeDescription	  
			   ,[CreatedBy]
			   ,UnitID
			  )
		 VALUES
			   (@SizeName,
			   @SizeDescription,  
			   @CreatedBy
			   ,@UnitID)
		
	END
	else 
	BEGIN
	 -- Update statements for procedure here
	
		
		 IF (NOT EXISTS(SELECT 1  FROM tblProduct  WHERE SizeID =  @SizeID))
   		
		    UPDATE [dbo].[tblSize]
			SET SizeName = @SizeName
				,SizeDescription = @SizeDescription	   		
		
				,[UpdatedBy] = @CreatedBy	
				,UpdatedOn=getdate()	
				,UnitID=@UnitID	   
			WHERE SizeID = @SizeID

	END
		
END


GO
/****** Object:  StoredProcedure [dbo].[InsertUpdate_Tax]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertUpdate_Tax]
	-- Add the parameters for the stored procedure here
	   @TaxID int,
	   @TaxName nvarchar(100), 
	   @TaxPercentage decimal(18,2),
       @Description nvarchar(500),  
	   @EffectiveFrom Datetime,    
       @CreatedBy int
                      
AS
BEGIN

    -- Insert statements for procedure here
    if((@TaxID IS NULL) OR ( @TaxID = 0 ))
	BEGIN
		INSERT INTO [dbo].[tblTax]
			   (TaxName
			   ,TaxPercentage			  			   
			   ,EffectiveFrom
			   ,Description
			   ,[CreatedBy]
			  )
		 VALUES
			   (@TaxName,
			   @TaxPercentage,			   
			   @EffectiveFrom,
			   @Description,
			   @CreatedBy)
		
	END
	else 
	BEGIN
	 -- Update statements for procedure here
	UPDATE [dbo].[tblTax]
	SET TaxName = @TaxName
		,TaxPercentage = @TaxPercentage			   		
		,EffectiveFrom = @EffectiveFrom
		,Description = @Description
		,[UpdatedBy] = @CreatedBy	
		,UpdatedOn=getdate()	
			   
	WHERE TaxID = @TaxID

		
	END
		
END


GO
/****** Object:  StoredProcedure [dbo].[InsertUpdate_Unit]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[InsertUpdate_Unit]
	-- Add the parameters for the stored procedure here
	   @UnitID int,
	   @Name nvarchar(100), 	  
       @Description nvarchar(500),  	
       @CreatedBy int
                      
AS
BEGIN

    -- Insert statements for procedure here
    if((@UnitID IS NULL) OR ( @UnitID = 0 ))
	BEGIN
		INSERT INTO [dbo].[tblUnit]
			   (Name
			   ,Description	  
			   ,[CreatedBy]
			  )
		 VALUES
			   (@Name,
			   @Description,  
			   @CreatedBy)
		
	END
	else 
	BEGIN
	 -- Update statements for procedure here
	UPDATE [dbo].[tblUnit]
	SET Name = @Name
		,Description = @Description	   		
		
		,[UpdatedBy] = @CreatedBy	
		,UpdatedOn=getdate()	
			   
	WHERE UnitID = @UnitID

		
	END
		
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetMonthlyInventoryReprot]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetMonthlyInventoryReprot]
(
@FromDate datetime,
@Todate datetime
)
AS
BEGIN
  
SELECT [CompanyName]
      ,[InventoryDate]
      ,[ContactNumber]
      ,[Email]
      ,[Website]      
      ,Case when [IsPaid]=1 then 'Yes' else 'No' end [IsPaid]
      , case when [IsOnCredit] =1 then 'Yes'else 'No'  end [IsOnCredit]
     
	  
	    ,(select sum(TaxAmount) from [dbo].[tblInventoryItem] tt where tt.InventoryID= inv.InventoryID) as 
	  TaxAmount 
	    ,(select sum(DiscountAmount) from [dbo].[tblInventoryItem] tt where tt.InventoryID= inv.InventoryID) as 
	  DiscountAmount 

	   ,(select sum(TotalAmount) from [dbo].[tblInventoryItem] tt where tt.InventoryID= inv.InventoryID) as 
	  TotalAmount 
	  
	  FROM [dbo].[tblInventory] inv
	    


	  WHERE  InventoryDate >= @FromDate AND
        InventoryDate   <= @Todate
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetMonthlyInvoiceReprot]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetMonthlyInvoiceReprot]
(
@FromDate datetime,
@Todate datetime
)
AS
BEGIN
SELECT [InvoiceID]
      ,[CustomerName]
      ,[ContactNumber]
      ,[Email]
      ,[Website]
       ,[PaymentMode]
      ,Case when [IsPaid]=1 then 'Yes' else 'No' end [IsPaid]
      , case when [IsOnCredit] =1 then 'Yes'else 'No'  end [IsOnCredit]
      ,[InvoiceDate]
      ,[PaymentExpectedBy]
      ,[Remarks]
	  
	    ,(select sum(TaxAmount) from [dbo].[tblInvoiceItem] tt where tt.InvoiceID= inv.InvoiceID) as 
	  TaxAmount 
	    ,(select sum(DiscountAmount) from [dbo].[tblInvoiceItem] tt where tt.InvoiceID= inv.InvoiceID) as 
	  DiscountAmount 

	   ,(select sum(TotalAmount) from [dbo].[tblInvoiceItem] tt where tt.InvoiceID= inv.InvoiceID) as 
	  TotalAmount 
	  
	  FROM [dbo].[tblInvoice] inv
	    inner join [dbo].[tblPaymentMode] Pay on pay.PaymentModeID=inv.PaymentModeID


	  WHERE  InvoiceDate >= @FromDate AND
        InvoiceDate   <= @Todate
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetMonthlytblDeliveryNoteReport]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetMonthlytblDeliveryNoteReport]
(
@FromDate datetime,
@Todate datetime
)
AS
BEGIN
 
SELECT [InvoiceID]
      ,[CustomerName]
      ,[DeliveryMode]
      ,[DeliveryDate]
      ,[EstimatedDeliveryDate]
     
	  
	    ,(select sum(TaxAmount) from [dbo].[tblDeliveryNoteItem] tt where tt.DeliveryNoteID= inv.DeliveryNoteID) as 
	  TaxAmount 
	    ,(select sum(DiscountAmount) from [dbo].[tblDeliveryNoteItem] tt where tt.DeliveryNoteID= inv.DeliveryNoteID) as 
	  DiscountAmount 

	   ,(select sum(TotalAmount) from [dbo].[tblDeliveryNoteItem] tt where tt.DeliveryNoteID= inv.DeliveryNoteID) as 
	  TotalAmount 
	  
	  FROM [dbo].[tblDeliveryNote] inv
	    inner join tblDeliveryMode dm on inv.DeliveryModeID=dm.DeliveryModeID


	  WHERE  DeliveryDate >= @FromDate AND
        DeliveryDate   <= @Todate
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetMonthlytblQuotationReport]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetMonthlytblQuotationReport]
(
@FromDate datetime,
@Todate datetime
)
AS
BEGIN
 
SELECT 
      [CustomerName]
      ,[QuotationDate]
      ,[PurchaseExpectedBy]
     
	  ,PaymentMode
     
	  
	    ,(select sum(TaxAmount) from [dbo].[tblQuotationItem] tt where tt.QuotationID= inv.QuotationID) as 
	  TaxAmount 
	    ,(select sum(DiscountAmount) from [dbo].[tblQuotationItem] tt where tt.QuotationID= inv.QuotationID) as 
	  DiscountAmount 

	   ,(select sum(TotalAmount) from [dbo].[tblQuotationItem] tt where tt.QuotationID= inv.QuotationID) as 
	  TotalAmount 
	  
	  FROM [dbo].[tblQuotation] inv
	    inner join tblPaymentMode dm on inv.PaymentModeID=dm.PaymentModeID


	  WHERE  QuotationDate >= @FromDate AND
        QuotationDate   <= @Todate
END

GO
/****** Object:  StoredProcedure [dbo].[spDeliveryNote_DeliveryNoteEntrySave]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************************
     Name                       = spDeliveryNote_DeliveryNoteEntrySave
     Author                     = Ashish
     Purpose                  	= DeliveryNote details and items to Save.
	 Modification History    
*****************************************************************************************************/
CREATE PROC [dbo].[spDeliveryNote_DeliveryNoteEntrySave]
	@DeliveryNoteXML XML,
	@DeliveryNoteItemXML XML,
	@modifiedBy INT,
	@DeliveryNoteID int
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		BEGIN TRAN			
			
			--Claim Header
			IF(@DeliveryNoteID > 0)
				BEGIN
				
				--Update DeliveryNote details
					UPDATE [tblDeliveryNote]
					SET 
						
					[CustomerName]=x.d.value('CustomerName[1]','NVARCHAR(200)'), 
					[DeliveryModeID]=x.d.value('DeliveryModeID[1]','INT'), 
					[InvoiceID]=x.d.value('InvoiceID[1]','INT'), 
					[DeliveryDate]=x.d.value('DeliveryDate[1]','DATETIME'),
					[EstimatedDeliveryDate]=x.d.value('EstimatedDeliveryDate[1]','DATETIME'),
					[Remarks]=x.d.value('Remarks[1]','NVARCHAR(500)'),					
					[UpdatedBy]=@modifiedBy,[UpdatedOn]=GETDATE()						
					FROM @DeliveryNoteXML.nodes('/DocumentElement/DeliveryNote') x(d)
					WHERE DeliveryNoteID = @DeliveryNoteID				
				END
			ELSE
				BEGIN
				   --Insert In DeliveryNote details
					INSERT INTO [dbo].[tblDeliveryNote](
					   [InvoiceID]
					  ,[CustomerName]
					  ,[DeliveryModeID]
					  ,[DeliveryDate]
					  ,[EstimatedDeliveryDate]
					  ,[Remarks]					  
					  ,[CreatedBy]
					  ,[UpdatedOn])
					SELECT	x.d.value('InvoiceID[1]','INT'), 
							x.d.value('CustomerName[1]','NVARCHAR(100)'), 
							x.d.value('DeliveryModeID[1]','INT'), 
							x.d.value('DeliveryDate[1]','DATETIME'),
							x.d.value('EstimatedDeliveryDate[1]','DATETIME'),
							x.d.value('Remarks[1]','NVARCHAR(500)'),					
							@modifiedBy,
							GETDATE()	
					
					FROM @DeliveryNoteXML.nodes('/DocumentElement/DeliveryNote') x(d)
					SET @DeliveryNoteID = SCOPE_IDENTITY();					
				END
			
			--delete using Inner join on ID where delete flag is 1 for tht DeliveryNoteID
			--DELETE cd FROM [tblDeliveryNoteItem] cd INNER JOIN @DeliveryNoteItemXML.nodes('/DocumentElement/DeliveryNoteDetails') x(d) ON
			--		cd.DeliveryNoteItemID = x.d.value('DeliveryNoteItemID[1]','INT')
			--WHERE cd.DeliveryNoteID = @DeliveryNoteID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=1
				DELETE  FROM [tblDeliveryNoteItem] WHERE DeliveryNoteID = @DeliveryNoteID
			--update using Inner join on ID where delete flag is 0 for tht DeliveryNoteID
			--UPDATE [tblDeliveryNoteItem]
			
			--SET 
			--	DeliveryNoteID = x.d.value('DeliveryNoteID[1]','INT'), 
			--	ProductID = x.d.value('ProductID[1]','INT'), 		
			--	Make =	x.d.value('Make[1]','NVARCHAR(100)'), 
			--	Quantity =	x.d.value('Quantity[1]','DECIMAL(18,0)'),
			--	Unit =	x.d.value('Unit[1]','INT'), 
			--	SizeID	=	x.d.value('SizeID[1]','INT'), 
			--	RatePerUnit	=	x.d.value('RatePerUnit[1]','DECIMAL(18,0)'), 
			--	TaxID =	x.d.value('TaxID[1]','INT'), 
			--	TaxAmount =	x.d.value('TaxAmount[1]','DECIMAL(18,0)'), 
			--	DiscountAmount	= x.d.value('DiscountAmount[1]','DECIMAL(18,0)'), 
			--	TotalAmount	=	x.d.value('TotalAmount[1]','DECIMAL(18,0)'), 
			--	Remark	=	x.d.value('Remark[1]','NVARCHAR(500)'), 
			--	CreatedBy =	 @modifiedBy,	
			--	UpdatedOn = GETDATE()						
			--FROM tblDeliveryNoteItem cd INNER JOIN @DeliveryNoteItemXML.nodes('/DocumentElement/DeliveryNoteDetails') x(d) ON
			--		cd.DeliveryNoteItemID= x.d.value('DeliveryNoteItemID[1]','INT')
			--WHERE cd.DeliveryNoteID = @DeliveryNoteID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0
			
			--Insert where ID is null and delete flag is 0 for tht DeliveryNoteID
			INSERT INTO [tblDeliveryNoteItem]
				    ( [DeliveryNoteID]
					  ,[ProductID]
					  ,[Make]
					  ,[Quantity]
					  ,[UnitID]
					  ,[SizeID]
					  ,[RatePerUnit]
					  ,[TaxID]
					  ,[TaxAmount]
					  ,[DiscountAmount]
					  ,[TotalAmount]
					  ,[Remark]	
					  ,Discount
					  ,Tax				  
					  ,[CreatedBy]							  
				   )
			SELECT @DeliveryNoteID,
			   x.d.value('ProductID[1]','INT'), 
			x.d.value('Make[1]','NVARCHAR(100)'), 
				x.d.value('Quantity[1]','DECIMAL(18,2)'),
				x.d.value('UnitID[1]','INT'), 
				x.d.value('SizeId[1]','INT'), 
				x.d.value('RatePerUnit[1]','DECIMAL(18,2)'), 
				x.d.value('TaxID[1]','INT'), 
				x.d.value('TaxAmount[1]','DECIMAL(18,2)'), 
				x.d.value('DiscountAmount[1]','DECIMAL(18,2)'), 
				x.d.value('TotalAmount[1]','DECIMAL(18,2)'), 
				x.d.value('Remark[1]','NVARCHAR(100)'), 
				x.d.value('Discount[1]','DECIMAL(18,2)'),
				x.d.value('TaxPercentage[1]','DECIMAL(18,2)'),
				@modifiedBy
			FROM @DeliveryNoteItemXML.nodes('/DocumentElement/DeliveryNoteDetails') x(d)
			--WHERE x.d.value('DeliveryNoteItemID[1]','INT')=0 AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0		
			
		COMMIT TRAN			
		SELECT @DeliveryNoteID;
		
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN	
		DECLARE @ErrorMessage NVARCHAR(4000);
		SELECT @ErrorMessage = ERROR_MESSAGE();
		RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[spInventory_InventoryEntrySave]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************
     Name                       = spInventory_InventoryEntrySave
     Author                     = Santosh
     Purpose                  	= Inventory details and items to Save.
	 Modification History    
*****************************************************************************************************/
CREATE PROC [dbo].[spInventory_InventoryEntrySave]
	@InventoryXML XML,
	@InventoryItemXML XML,
	@modifiedBy INT,
	@InventoryID int
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		BEGIN TRAN			
			
			--Claim Header
			IF(@InventoryID > 0)
				BEGIN
				
				--Update Inventory details
					UPDATE [tblInventory]
					SET 
					[CompanyName]=x.d.value('CompanyName[1]','NVARCHAR(200)'), 
					[ContactPersonName]=x.d.value('ContactPersonName[1]','NVARCHAR(100)'), 
					[ContactNumber]=x.d.value('ContactNumber[1]','NVARCHAR(100)'), 
					[Email]= x.d.value('Email[1]','NVARCHAR(200)'), 
					[Website]=x.d.value('Website[1]','NVARCHAR(200)'), 	
					[PaymentModeID]=x.d.value('PaymentModeID[1]','INT'), 
					[IsPaid]=x.d.value('IsPaid[1]','INT'), 
					[IsOnCredit]=x.d.value('IsOnCredit[1]','INT'), 
					[InventoryDate]=x.d.value('InventoryDate[1]','DATETIME'),
					[ItemsReceivedOn]=x.d.value('ItemsReceivedOn[1]','DATETIME'),
					[PaymentDate]=x.d.value('PaymentDate[1]','DATETIME'),
					[TotalAmount] = x.d.value('TotalAmount[1]','DECIMAL'),
					[TotalTaxAmount] = x.d.value('TotalTaxAmount[1]','DECIMAL'),					
					[Remarks]=x.d.value('Remarks[1]','NVARCHAR(500)'),
					 [InvoiceNo]=x.d.value('InvoiceNo[1]','NVARCHAR(MAX)'), 
					  [BillingAddress]=x.d.value('BillingAddress[1]','NVARCHAR(MAX)'), 
					  [ShippingAddress]=x.d.value('ShippingAddress[1]','NVARCHAR(MAX)'), 					
					  [GSTIN]=x.d.value('GSTIN[1]','NVARCHAR(MAX)'), 
					[UpdatedBy]=@modifiedBy,[UpdatedOn]=GETDATE()						
					FROM @InventoryXML.nodes('/DocumentElement/Inventory') x(d)
					WHERE InventoryID = @InventoryID				
				END
			ELSE
				BEGIN
				   --Insert In Inventory details
					INSERT INTO [dbo].[tblInventory](
								[CompanyName],
								[ContactPersonName],
								[ContactNumber],
								[Email],
								[Website],
								[PaymentModeID],
								[IsPaid],
								[IsOnCredit],
								[InventoryDate],
								[ItemsReceivedOn],
								[PaymentDate],
								[TotalAmount],
								[TotalTaxAmount],
								[Remarks],
								 [InvoiceNo],
							  [BillingAddress],
							  [ShippingAddress],
							  [GSTIN],
								[CreatedBy],
								[UpdatedOn])
					SELECT	x.d.value('CompanyName[1]','NVARCHAR(200)'), 
							x.d.value('ContactPersonName[1]','NVARCHAR(100)'), 
							x.d.value('ContactNumber[1]','NVARCHAR(100)'), 
							x.d.value('Email[1]','NVARCHAR(200)'), 
							x.d.value('Website[1]','NVARCHAR(200)'), 	
							x.d.value('PaymentModeID[1]','INT'), 
							x.d.value('IsPaid[1]','INT'), 
							x.d.value('IsOnCredit[1]','INT'), 
							x.d.value('InventoryDate[1]','DATETIME'),
							x.d.value('ItemsReceivedOn[1]','DATETIME'),
							x.d.value('PaymentDate[1]','DATETIME'),
							x.d.value('TotalAmount[1]','DECIMAL'),
							x.d.value('TotalTaxAmount[1]','DECIMAL'),					
							x.d.value('Remarks[1]','NVARCHAR(500)'),
							 x.d.value('InvoiceNo[1]','NVARCHAR(MAX)'), 
					  x.d.value('BillingAddress[1]','NVARCHAR(MAX)'), 
					  x.d.value('ShippingAddress[1]','NVARCHAR(MAX)'), 					
					 x.d.value('GSTIN[1]','NVARCHAR(MAX)'), 
					@modifiedBy,GETDATE()	
					
					FROM @InventoryXML.nodes('/DocumentElement/Inventory') x(d)
					SET @InventoryID = SCOPE_IDENTITY();					
				END
			
			--delete using Inner join on ID where delete flag is 1 for tht InventoryID
			--DELETE cd FROM [tblInventoryItem] cd INNER JOIN @InventoryItemXML.nodes('/DocumentElement/InventoryDetails') x(d) ON
			--		cd.InventoryItemID = x.d.value('InventoryItemID[1]','INT')
			--WHERE cd.InventoryID = @InventoryID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=1
			
			DELETE  FROM [tblInventoryItem] WHERE InventoryID = @InventoryID
			--update using Inner join on ID where delete flag is 0 for tht InventoryID
			--UPDATE [tblInventoryItem]
			
			--SET 
			--	InventoryID = x.d.value('InventoryID[1]','INT'), 
			--	ProductID = x.d.value('ProductID[1]','INT'), 		
			--	Make =	x.d.value('Make[1]','NVARCHAR(100)'), 
			--	Quantity =	x.d.value('Quantity[1]','DECIMAL(18,0)'),
			--	Unit =	x.d.value('Unit[1]','INT'), 
			--	SizeID	=	x.d.value('SizeID[1]','INT'), 
			--	RatePerUnit	=	x.d.value('RatePerUnit[1]','DECIMAL(18,0)'), 
			--	TaxID =	x.d.value('TaxID[1]','INT'), 
			--	TaxAmount =	x.d.value('TaxAmount[1]','DECIMAL(18,0)'), 
			--	DiscountAmount	= x.d.value('DiscountAmount[1]','DECIMAL(18,0)'), 
			--	TotalAmount	=	x.d.value('TotalAmount[1]','DECIMAL(18,0)'), 
			--	Remark	=	x.d.value('Remark[1]','NVARCHAR(500)'), 
			--	CreatedBy =	 @modifiedBy,	
			--	UpdatedOn = GETDATE()						
			--FROM tblInventoryItem cd INNER JOIN @InventoryItemXML.nodes('/DocumentElement/InventoryDetails') x(d) ON
			--		cd.InventoryItemID= x.d.value('InventoryItemID[1]','INT')
			--WHERE cd.InventoryID = @InventoryID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0
			
			--Insert where ID is null and delete flag is 0 for tht InventoryID
			INSERT INTO [tblInventoryItem]
				    ( [InventoryID]
					  ,[ProductID]
						  ,[Make]
					  ,[Quantity]
					  ,[UnitID]
					  ,[SizeID]
					  ,[RatePerUnit]
					  ,[TaxID]
					  ,[TaxAmount]
					  ,[DiscountAmount]
					  ,[TotalAmount]
					  ,[Remark]	
					  ,Discount
					  ,Tax		
					    ,HSN_SAC		  
					  ,[CreatedBy]		  
				   )
			SELECT @InventoryID,
			    x.d.value('ProductID[1]','INT'), 
			x.d.value('Make[1]','NVARCHAR(100)'), 
				x.d.value('Quantity[1]','DECIMAL(18,2)'),
				x.d.value('UnitID[1]','INT'), 
				x.d.value('SizeId[1]','INT'), 
				x.d.value('RatePerUnit[1]','DECIMAL(18,2)'), 
				x.d.value('TaxID[1]','INT'), 				
				x.d.value('TaxAmount[1]','DECIMAL(18,2)'), 
				x.d.value('DiscountAmount[1]','DECIMAL(18,2)'), 
				x.d.value('TotalAmount[1]','DECIMAL(18,2)'), 
				x.d.value('Remark[1]','NVARCHAR(100)'), 
				x.d.value('Discount[1]','DECIMAL(18,2)'),
				x.d.value('TaxPercentage[1]','DECIMAL(18,2)'),
					x.d.value('HSN_SAC[1]','INT'), 
				@modifiedBy
			FROM @InventoryItemXML.nodes('/DocumentElement/InventoryDetails') x(d)
			--WHERE x.d.value('InventoryItemID[1]','INT')=0 AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0		
			
		COMMIT TRAN			
		SELECT @InventoryID;
		
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN	
		DECLARE @ErrorMessage NVARCHAR(4000);
		SELECT @ErrorMessage = ERROR_MESSAGE();
		RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[spInvoice_InvoiceEntrySave]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************************
     Name                       = spInvoice_InvoiceEntrySave
     Author                     = Santosh
     Purpose                  	= Invoice details and items to Save.
	 Modification History    
*****************************************************************************************************/
CREATE PROC [dbo].[spInvoice_InvoiceEntrySave]
	@invoiceXML XML,
	@invoiceItemXML XML,
	@modifiedBy INT,
	@invoiceID int
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		BEGIN TRAN			
			
			--Claim Header
			IF(@invoiceID>0)
				BEGIN
				
				--Update invoice details
					UPDATE [tblInvoice]
					SET 
					[CustomerName]=x.d.value('CustomerName[1]','NVARCHAR(200)'), 
					[ContactNumber]=x.d.value('ContactNumber[1]','NVARCHAR(100)'), 
					[Email]= x.d.value('Email[1]','NVARCHAR(200)'), 
					[Website]=x.d.value('Website[1]','NVARCHAR(200)'), 	
					[PaymentModeID]=x.d.value('PaymentModeID[1]','INT'), 
					[IsPaid]=x.d.value('IsPaid[1]','INT'), 
					[IsOnCredit]=x.d.value('IsOnCredit[1]','INT'), 
					[InvoiceDate]=x.d.value('InvoiceDate[1]','DATETIME'),
					[PaymentExpectedBy]=x.d.value('PaymentExpectedBy[1]','DATETIME'),
					[Remarks]=x.d.value('Remarks[1]','NVARCHAR(500)'),

					  [InvoiceNo]=x.d.value('InvoiceNo[1]','NVARCHAR(MAX)'), 
					  [BillingAddress]=x.d.value('BillingAddress[1]','NVARCHAR(MAX)'), 
					  [ShippingAddress]=x.d.value('ShippingAddress[1]','NVARCHAR(MAX)'), 
					  [InvoiceType]=x.d.value('InvoiceType[1]','INT'), 
					  [GSTIN]=x.d.value('GSTIN[1]','NVARCHAR(200)'), 
					[UpdatedBy]=@modifiedBy,[UpdatedOn]=GETDATE()						
					FROM @invoiceXML.nodes('/DocumentElement/Invoice') x(d)
					WHERE InvoiceID = @invoiceID				
				END
			ELSE
				BEGIN
				   --Insert In invoice details
					INSERT INTO [tblInvoice] ([CustomerName], [ContactNumber], [Email], [Website], 
							[PaymentModeID], [IsPaid], [IsOnCredit], [InvoiceDate],[PaymentExpectedBy],[Remarks], [InvoiceNo]
      ,[BillingAddress]
      ,[ShippingAddress]
      ,[InvoiceType]
      ,[GSTIN],[CreatedBy])
					SELECT	x.d.value('CustomerName[1]','NVARCHAR(200)'), x.d.value('ContactNumber[1]','NVARCHAR(100)'), x.d.value('Email[1]','NVARCHAR(200)'),
							x.d.value('Website[1]','NVARCHAR(200)'),x.d.value('PaymentModeID[1]','INT'),x.d.value('IsPaid[1]','INT'),x.d.value('IsOnCredit[1]','INT'),
							x.d.value('InvoiceDate[1]','DATETIME'),x.d.value('PaymentExpectedBy[1]','DATETIME'),
							x.d.value('Remarks[1]','NVARCHAR(500)'),
							  x.d.value('InvoiceNo[1]','NVARCHAR(MAX)'), 
					 x.d.value('BillingAddress[1]','NVARCHAR(MAX)'), 
					 x.d.value('ShippingAddress[1]','NVARCHAR(MAX)'), 
					  x.d.value('InvoiceType[1]','INT'), 
					  x.d.value('GSTIN[1]','NVARCHAR(200)')
							, @modifiedBy
					FROM @invoiceXML.nodes('/DocumentElement/Invoice') x(d)
					SET @invoiceID = SCOPE_IDENTITY();					
				END
			
			--delete using Inner join on ID where delete flag is 1 for tht InvoiceID
			--DELETE cd FROM [tblInvoiceItem] cd INNER JOIN @invoiceItemXML.nodes('/DocumentElement/InvoiceDetails') x(d) ON
			--		cd.InvoiceItemID = x.d.value('InvoiceItemID[1]','INT')
			--WHERE cd.InvoiceID = @invoiceID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=1
			DELETE  FROM [tblInvoiceItem] WHERE InvoiceID = @invoiceID
			--update using Inner join on ID where delete flag is 0 for tht InvoiceID
			--UPDATE [tblInvoiceItem]
			--SET InvoiceID		=	x.d.value('InvoiceID[1]','INT'), 
			--	ProductID				=	x.d.value('ProductID[1]','INT'), 
			--	Make			=	x.d.value('Make[1]','NVARCHAR(100)'), 
			--	Quantity		=	x.d.value('Quantity[1]','DECIMAL(18,0)'),
			--	Unit			=	x.d.value('Unit[1]','INT'), 
			--	SizeID	=	x.d.value('SizeId[1]','INT'), 
			--	RatePerUnit		=	x.d.value('RatePerUnit[1]','DECIMAL(18,0)'), 
			--	TaxID	=	x.d.value('TaxID[1]','INT'), 
			--	TaxAmount		=	x.d.value('TaxAmount[1]','DECIMAL(18,0)'), 
			--	DiscountAmount		= x.d.value('DiscountAmount[1]','DECIMAL(18,0)'), 
			--	TotalAmount	=	x.d.value('TotalAmount[1]','DECIMAL(18,0)'), 
			--	Remark			=	x.d.value('Remark[1]','NVARCHAR(100)'), 
			--	CreatedBy=	 @modifiedBy,	
			--	UpdatedOn=GETDATE()						
			--FROM tblInvoiceItem cd INNER JOIN @invoiceItemXML.nodes('/DocumentElement/InvoiceDetails') x(d) ON
			--		cd.InvoiceItemID= x.d.value('InvoiceItemID[1]','INT')
			--WHERE cd.InvoiceID = @invoiceID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0
			
			--Insert where ID is null and delete flag is 0 for tht InvoiceID
			INSERT INTO [tblInvoiceItem]
				    ([InvoiceID]
					  ,[ProductID]
					  ,[Make]
					  ,[Quantity]
					  ,[UnitID]
					  ,[SizeID]
					  ,[RatePerUnit]
					  ,[TaxID]
					  ,[TaxAmount]
					  ,[DiscountAmount]
					  ,[TotalAmount]
					  ,[Remark]	
					  ,Discount
					  ,Tax	
					  ,HSN_SAC			  
					  ,[CreatedBy]					  
				   )
			SELECT @invoiceID,x.d.value('ProductID[1]','INT'), 
				x.d.value('Make[1]','NVARCHAR(100)'), 
				x.d.value('Quantity[1]','DECIMAL(18,2)'),
				x.d.value('UnitID[1]','INT'), 
				x.d.value('SizeId[1]','INT'), 
				x.d.value('RatePerUnit[1]','DECIMAL(18,2)'), 
				x.d.value('TaxID[1]','INT'), 
				x.d.value('TaxAmount[1]','DECIMAL(18,2)'), 
				x.d.value('DiscountAmount[1]','DECIMAL(18,2)'), 
				x.d.value('TotalAmount[1]','DECIMAL(18,2)'), 
				x.d.value('Remark[1]','NVARCHAR(100)'), 
				x.d.value('Discount[1]','DECIMAL(18,2)'),
				x.d.value('TaxPercentage[1]','DECIMAL(18,2)'),
				x.d.value('HSN_SAC[1]','INT'),
				
				@modifiedBy
			FROM @invoiceItemXML.nodes('/DocumentElement/InvoiceDetails') x(d)
			--WHERE x.d.value('InvoiceItemID[1]','INT')=0 AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0		
			
		COMMIT TRAN			
		SELECT @invoiceID;
		
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN	
		DECLARE @ErrorMessage NVARCHAR(4000);
		SELECT @ErrorMessage = ERROR_MESSAGE();
		RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[spQuotation_QuotationEntrySave]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************************
     Name                       = spQuotation_QuotationEntrySave
     Author                     = Ashish
     Purpose                  	= Quotation details and items to Save.
	 Modification History    
*****************************************************************************************************/
CREATE PROC [dbo].[spQuotation_QuotationEntrySave]
	@QuotationXML XML,
	@QuotationItemXML XML,
	@modifiedBy INT,
	@QuotationID int
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON
		BEGIN TRAN			
			
			--Claim Header
			IF(@QuotationID > 0)
				BEGIN
				
				--Update Quotation details
					UPDATE [tblQuotation]
					SET 
						
					[CustomerName]=x.d.value('CustomerName[1]','NVARCHAR(200)'), 
					[PaymentModeID]=x.d.value('PaymentModeID[1]','INT'), 					
					[QuotationDate]=x.d.value('QuotationDate[1]','DATETIME'),
					[PurchaseExpectedBy]=x.d.value('PurchaseExpectedBy[1]','DATETIME'),
					[Remarks]=x.d.value('Remarks[1]','NVARCHAR(500)'),					
					[UpdatedBy]=@modifiedBy,[UpdatedOn]=GETDATE()						
					FROM @QuotationXML.nodes('/DocumentElement/Quotation') x(d)
					WHERE QuotationID = @QuotationID				
				END
			ELSE
				BEGIN
				   --Insert In Quotation details
					INSERT INTO [dbo].[tblQuotation](					  
					  [CustomerName]
					  ,[PaymentModeID]
					  ,[QuotationDate]
					  ,[PurchaseExpectedBy]
					  ,[Remarks]					  
					  ,[CreatedBy]
					  ,[UpdatedOn])
					SELECT	x.d.value('CustomerName[1]','NVARCHAR(100)'), 
							x.d.value('PaymentModeID[1]','INT'), 
							x.d.value('QuotationDate[1]','DATETIME'),
							x.d.value('PurchaseExpectedBy[1]','DATETIME'),
							x.d.value('Remarks[1]','NVARCHAR(500)'),					
							@modifiedBy,
							GETDATE()	
					
					FROM @QuotationXML.nodes('/DocumentElement/Quotation') x(d)
					SET @QuotationID = SCOPE_IDENTITY();					
				END
			
			--delete using Inner join on ID where delete flag is 1 for tht QuotationID
			--DELETE cd FROM [tblQuotationItem] cd INNER JOIN @QuotationItemXML.nodes('/DocumentElement/QuotationDetails') x(d) ON
			--		cd.QuotationItemID = x.d.value('QuotationItemID[1]','INT')
			--WHERE cd.QuotationID = @QuotationID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=1

			DELETE  FROM [tblQuotationItem] WHERE QuotationID = @QuotationID
			
			--update using Inner join on ID where delete flag is 0 for tht QuotationID
			--UPDATE [tblQuotationItem]
			
			--SET 
			--	QuotationID = x.d.value('QuotationID[1]','INT'), 
			--	ProductID = x.d.value('ProductID[1]','INT'), 		
			--	Make =	x.d.value('Make[1]','NVARCHAR(100)'), 
			--	Quantity =	x.d.value('Quantity[1]','DECIMAL(18,0)'),
			--	Unit =	x.d.value('Unit[1]','INT'), 
			--	--SizeID	=	x.d.value('SizeID[1]','INT'), 
			--	RatePerUnit	=	x.d.value('RatePerUnit[1]','DECIMAL(18,0)'), 
			--	TaxID =	x.d.value('TaxID[1]','INT'), 
			--	TaxAmount =	x.d.value('TaxAmount[1]','DECIMAL(18,0)'), 
			--	DiscountAmount	= x.d.value('DiscountAmount[1]','DECIMAL(18,0)'), 
			--	TotalAmount	=	x.d.value('TotalAmount[1]','DECIMAL(18,0)'), 
			--	Remark	=	x.d.value('Remark[1]','NVARCHAR(500)'), 
			--	CreatedBy =	 @modifiedBy,	
			--	UpdatedOn = GETDATE()						
			--FROM tblQuotationItem cd INNER JOIN @QuotationItemXML.nodes('/DocumentElement/QuotationDetails') x(d) ON
			--		cd.QuotationItemID= x.d.value('QuotationItemID[1]','INT')
			--WHERE cd.QuotationID = @QuotationID AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0
			
			--Insert where ID is null and delete flag is 0 for tht QuotationID
			INSERT INTO [tblQuotationItem]
				    ( [QuotationID]
					  ,[ProductID]
					  ,[Make]
					  ,[Quantity]
					  ,[UnitID]
					  ,[SizeID]
					  ,[RatePerUnit]
					  ,[TaxID]
					  ,[TaxAmount]
					  ,[DiscountAmount]
					  ,[TotalAmount]
					  ,[Remark]	
					  ,Discount
					  ,Tax				  
					  ,[CreatedBy]					  
				   )
			SELECT @QuotationID,x.d.value('ProductID[1]','INT'), 
				x.d.value('Make[1]','NVARCHAR(100)'), 
				x.d.value('Quantity[1]','DECIMAL(18,2)'),
				x.d.value('UnitID[1]','INT'), 
				x.d.value('SizeId[1]','INT'), 
				x.d.value('RatePerUnit[1]','DECIMAL(18,2)'), 
				x.d.value('TaxID[1]','INT'), 
				x.d.value('TaxAmount[1]','DECIMAL(18,2)'), 
				x.d.value('DiscountAmount[1]','DECIMAL(18,2)'), 
				x.d.value('TotalAmount[1]','DECIMAL(18,2)'), 
				x.d.value('Remark[1]','NVARCHAR(100)'), 
				x.d.value('Discount[1]','DECIMAL(18,2)'),
				x.d.value('TaxPercentage[1]','DECIMAL(18,2)'),
				@modifiedBy
			FROM @QuotationItemXML.nodes('/DocumentElement/QuotationDetails') x(d)
			WHERE x.d.value('QuotationItemID[1]','INT')=0 AND ISNULL(x.d.value('Delete[1]','BIT'),0)=0		
			
		COMMIT TRAN			
		SELECT @QuotationID;
		
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN	
		DECLARE @ErrorMessage NVARCHAR(4000);
		SELECT @ErrorMessage = ERROR_MESSAGE();
		RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[spStock_StockEntrySave]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spStock_StockEntrySave]
	-- Add the parameters for the stored procedure here
	   @StockID int =null
      ,@ProductID int 
      ,@Make nvarchar(100)
      ,@Quantity decimal(18,2)
      ,@UnitID int 
      ,@SizeID int 
      ,@RatePerUnit decimal(18,2)
      ,@TaxID int
      ,@Tax decimal(18,2)
      ,@TaxAmount decimal(18,2)
      ,@Discount decimal(18,2)
      ,@DiscountAmount decimal(18,2)
      ,@TotalAmount decimal(18,2)
      ,@Remark  nvarchar(100)
      , @CreatedBy int
                      
AS
BEGIN

    -- Insert statements for procedure here    
    if((@StockID IS NULL) OR ( @StockID = 0 ))
	BEGIN
		INSERT INTO [dbo].[tblStock]
			([ProductID]
      ,[Make]
      ,[Quantity]
      ,[UnitID]
      ,[SizeID]
      ,[RatePerUnit]
      ,[TaxID]
      ,[Tax]
      ,[TaxAmount]
      ,[Discount]
      ,[DiscountAmount]
      ,[TotalAmount]
      ,[Remark],CreatedBy)
		 VALUES
			   (
	   @ProductID  
      ,@Make
      ,@Quantity
      ,@UnitID  
      ,@SizeID  
      ,@RatePerUnit 
      ,@TaxID 
      ,@Tax 
      ,@TaxAmount 
      ,@Discount
      ,@DiscountAmount
      ,@TotalAmount 
      ,@Remark  
      , @CreatedBy )
		
	END
	else 
	BEGIN
	 -- Update statements for procedure here
	UPDATE [dbo].[tblStock]
	SET  						
	 [ProductID]=@ProductID,
      [Make]=@Make,
      [Quantity]=@Quantity,
      [UnitID]=@UnitID,
      [SizeID]=@SizeID,
      [RatePerUnit]=@RatePerUnit,
      [TaxID]=@TaxID,
      [Tax]=@Tax,
      [TaxAmount]=@TaxAmount,
      [Discount]=@Discount,
      [DiscountAmount]=@DiscountAmount,
      [TotalAmount]=@TotalAmount,
      [Remark]=@Remark,
	  UpdatedBy=@CreatedBy,
	  UpdatedOn=getdate()

	WHERE [StockID] = @StockID

		
	END
		
END


GO
/****** Object:  Table [dbo].[tblDeliveryMode]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDeliveryMode](
	[DeliveryModeID] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryMode] [nvarchar](50) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblDeliveryMode_IsActive]  DEFAULT ((1)),
 CONSTRAINT [PK_tblDeliveryMode] PRIMARY KEY CLUSTERED 
(
	[DeliveryModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDeliveryNote]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDeliveryNote](
	[DeliveryNoteID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NULL,
	[CustomerName] [nvarchar](200) NULL,
	[DeliveryModeID] [int] NULL,
	[DeliveryDate] [datetime] NULL,
	[EstimatedDeliveryDate] [datetime] NULL,
	[Remarks] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblDeliveryNote] PRIMARY KEY CLUSTERED 
(
	[DeliveryNoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDeliveryNoteItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDeliveryNoteItem](
	[DeliveryNoteItemID] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryNoteID] [int] NULL,
	[ProductID] [int] NULL,
	[Make] [nvarchar](100) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitID] [int] NULL,
	[SizeID] [int] NULL,
	[RatePerUnit] [decimal](18, 2) NULL,
	[TaxID] [int] NULL,
	[Tax] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Remark] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblDeliveryNoteItem] PRIMARY KEY CLUSTERED 
(
	[DeliveryNoteItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInventory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventory](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [nvarchar](max) NULL,
	[BillingAddress] [nvarchar](max) NULL,
	[ShippingAddress] [nvarchar](max) NULL,
	[GSTIN] [nvarchar](max) NULL,
	[CompanyName] [nvarchar](200) NULL,
	[ContactPersonName] [nvarchar](100) NULL,
	[ContactNumber] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Website] [nvarchar](100) NULL,
	[PaymentModeID] [int] NOT NULL,
	[IsPaid] [int] NULL,
	[IsOnCredit] [int] NULL,
	[InventoryDate] [datetime] NULL,
	[ItemsReceivedOn] [datetime] NULL,
	[TotalAmount] [decimal](18, 0) NULL,
	[TotalTaxAmount] [decimal](18, 0) NULL,
	[PaymentDate] [datetime] NULL,
	[Remarks] [nvarchar](500) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblInventory_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblInventory_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblInventory] PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInventoryItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventoryItem](
	[InventoryItemID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryID] [int] NULL,
	[ProductID] [int] NULL,
	[Make] [nvarchar](100) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitID] [int] NULL,
	[SizeID] [int] NULL,
	[RatePerUnit] [decimal](18, 2) NULL,
	[TaxID] [int] NULL,
	[Tax] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Remark] [nvarchar](100) NULL,
	[HSN_SAC] [int] NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblInventoryItem_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblInventoryItem_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblInventoryItem] PRIMARY KEY CLUSTERED 
(
	[InventoryItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInvoice]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInvoice](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [nvarchar](max) NULL,
	[BillingAddress] [nvarchar](max) NULL,
	[ShippingAddress] [nvarchar](max) NULL,
	[InvoiceType] [int] NULL,
	[GSTIN] [nvarchar](200) NULL,
	[CustomerName] [nvarchar](200) NULL,
	[ContactNumber] [nvarchar](100) NULL,
	[Email] [nvarchar](200) NULL,
	[Website] [nvarchar](200) NULL,
	[PaymentModeID] [int] NULL,
	[IsPaid] [int] NULL,
	[IsOnCredit] [int] NULL,
	[InvoiceDate] [datetime] NULL,
	[PaymentExpectedBy] [datetime] NULL,
	[Remarks] [nvarchar](500) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblInvoice_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblInvoice_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblInvoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInvoiceItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInvoiceItem](
	[InvoiceItemID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NULL,
	[ProductID] [int] NULL,
	[Make] [nvarchar](100) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitID] [int] NULL,
	[SizeID] [int] NULL,
	[RatePerUnit] [decimal](18, 2) NULL,
	[TaxID] [int] NULL,
	[Tax] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Remark] [nvarchar](100) NULL,
	[HSN_SAC] [int] NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblInvoiceItem_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblInvoiceItem_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblInvoiceItem] PRIMARY KEY CLUSTERED 
(
	[InvoiceItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMeasurementUnit]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMeasurementUnit](
	[UnitID] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[IsActive] [nvarchar](10) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblMeasurementUnit] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPaymentMode]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPaymentMode](
	[PaymentModeID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentMode] [nvarchar](50) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblPaymentMode_IsActive]  DEFAULT ((1)),
 CONSTRAINT [PK_tblPaymentMode] PRIMARY KEY CLUSTERED 
(
	[PaymentModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryID] [int] NULL,
	[ProductSubCategoryID] [int] NULL,
	[ProductName] [nvarchar](100) NULL,
	[ProductDescription] [nvarchar](500) NULL,
	[Make] [nvarchar](100) NULL,
	[Unit] [nvarchar](50) NULL,
	[TaxID] [int] NULL,
	[SizeID] [int] NULL,
	[RatePerUnit] [decimal](18, 0) NULL,
	[Discount] [nvarchar](50) NULL,
	[Remark] [nvarchar](200) NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_tblProduct_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblProduct_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[UnitID] [int] NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProductCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductCategory](
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[HSN_SAC] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblProductCategory_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblProductCategory_IsActive]  DEFAULT ((1)),
 CONSTRAINT [PK_tblProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProductSubCategory]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductSubCategory](
	[ProductSubCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[SubCategoryName] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblProductSubCategory_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblProductSubCategory_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblProductSubCategory] PRIMARY KEY CLUSTERED 
(
	[ProductSubCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblQuotation]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblQuotation](
	[QuotationID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](200) NULL,
	[PaymentModeID] [int] NULL,
	[QuotationDate] [datetime] NULL,
	[PurchaseExpectedBy] [datetime] NULL,
	[Remarks] [nvarchar](500) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblQuotation_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblQuotation_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL CONSTRAINT [DF_tblQuotation_CreatedBy]  DEFAULT ((1)),
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblQuotation] PRIMARY KEY CLUSTERED 
(
	[QuotationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblQuotationItem]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblQuotationItem](
	[QuotationItemID] [int] IDENTITY(1,1) NOT NULL,
	[QuotationID] [int] NULL,
	[ProductID] [int] NULL,
	[Make] [nvarchar](100) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitID] [int] NULL,
	[SizeID] [int] NULL,
	[RatePerUnit] [decimal](18, 2) NULL,
	[TaxID] [int] NULL,
	[Tax] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Remark] [nvarchar](100) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblQuotationItem_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblQuotationItem_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblQuotationItem] PRIMARY KEY CLUSTERED 
(
	[QuotationItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSize]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSize](
	[SizeID] [int] IDENTITY(1,1) NOT NULL,
	[SizeName] [nvarchar](100) NULL,
	[SizeDescription] [nvarchar](200) NULL,
	[UnitID] [int] NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_tblSize_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblSize_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblSize] PRIMARY KEY CLUSTERED 
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblStock]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStock](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Make] [nvarchar](100) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitID] [int] NULL,
	[SizeID] [int] NULL,
	[RatePerUnit] [decimal](18, 2) NULL,
	[TaxID] [int] NULL,
	[Tax] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Remark] [nvarchar](100) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblStock_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblStock_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblStock] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTax]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTax](
	[TaxID] [int] IDENTITY(1,1) NOT NULL,
	[TaxName] [nvarchar](100) NULL,
	[TaxPercentage] [decimal](18, 2) NULL,
	[EffectiveFrom] [datetime] NULL,
	[Description] [nvarchar](500) NULL,
	[IsActive] [bit] NULL CONSTRAINT [DF_tblTax_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblTax_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblTax] PRIMARY KEY CLUSTERED 
(
	[TaxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUnit]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUnit](
	[UnitID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](200) NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_tblUnit_IsActive]  DEFAULT ((1)),
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_tblUnit_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_tblUnit] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 9/17/2017 11:39:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getdate()),
	[IsActive] [bit] NULL CONSTRAINT [DF_User_IsActive]  DEFAULT ((1)),
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tblDeliveryNote] ADD  CONSTRAINT [DF_tblDeliveryNote_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tblDeliveryNote] ADD  CONSTRAINT [DF_tblDeliveryNote_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem] ADD  CONSTRAINT [DF_tblDeliveryNoteItem_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem] ADD  CONSTRAINT [DF_tblDeliveryNoteItem_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tblDeliveryNote]  WITH CHECK ADD  CONSTRAINT [FK_tblDeliveryNote_tblDeliveryMode] FOREIGN KEY([DeliveryModeID])
REFERENCES [dbo].[tblDeliveryMode] ([DeliveryModeID])
GO
ALTER TABLE [dbo].[tblDeliveryNote] CHECK CONSTRAINT [FK_tblDeliveryNote_tblDeliveryMode]
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem]  WITH CHECK ADD  CONSTRAINT [FK_tblDeliveryNoteItem_tblDeliveryNote] FOREIGN KEY([DeliveryNoteID])
REFERENCES [dbo].[tblDeliveryNote] ([DeliveryNoteID])
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem] CHECK CONSTRAINT [FK_tblDeliveryNoteItem_tblDeliveryNote]
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem]  WITH CHECK ADD  CONSTRAINT [FK_tblDeliveryNoteItem_tblProduct] FOREIGN KEY([ProductID])
REFERENCES [dbo].[tblProduct] ([ProductID])
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem] CHECK CONSTRAINT [FK_tblDeliveryNoteItem_tblProduct]
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem]  WITH CHECK ADD  CONSTRAINT [FK_tblDeliveryNoteItem_tblSize] FOREIGN KEY([SizeID])
REFERENCES [dbo].[tblSize] ([SizeID])
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem] CHECK CONSTRAINT [FK_tblDeliveryNoteItem_tblSize]
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem]  WITH CHECK ADD  CONSTRAINT [FK_tblDeliveryNoteItem_tblTax] FOREIGN KEY([TaxID])
REFERENCES [dbo].[tblTax] ([TaxID])
GO
ALTER TABLE [dbo].[tblDeliveryNoteItem] CHECK CONSTRAINT [FK_tblDeliveryNoteItem_tblTax]
GO
ALTER TABLE [dbo].[tblInventory]  WITH CHECK ADD  CONSTRAINT [FK_tblInventory_tblPaymentMode] FOREIGN KEY([PaymentModeID])
REFERENCES [dbo].[tblPaymentMode] ([PaymentModeID])
GO
ALTER TABLE [dbo].[tblInventory] CHECK CONSTRAINT [FK_tblInventory_tblPaymentMode]
GO
ALTER TABLE [dbo].[tblInventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryItem_tblInventory] FOREIGN KEY([InventoryID])
REFERENCES [dbo].[tblInventory] ([InventoryID])
GO
ALTER TABLE [dbo].[tblInventoryItem] CHECK CONSTRAINT [FK_tblInventoryItem_tblInventory]
GO
ALTER TABLE [dbo].[tblInventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryItem_tblProduct] FOREIGN KEY([ProductID])
REFERENCES [dbo].[tblProduct] ([ProductID])
GO
ALTER TABLE [dbo].[tblInventoryItem] CHECK CONSTRAINT [FK_tblInventoryItem_tblProduct]
GO
ALTER TABLE [dbo].[tblInventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryItem_tblSize] FOREIGN KEY([SizeID])
REFERENCES [dbo].[tblSize] ([SizeID])
GO
ALTER TABLE [dbo].[tblInventoryItem] CHECK CONSTRAINT [FK_tblInventoryItem_tblSize]
GO
ALTER TABLE [dbo].[tblInventoryItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryItem_tblTax] FOREIGN KEY([TaxID])
REFERENCES [dbo].[tblTax] ([TaxID])
GO
ALTER TABLE [dbo].[tblInventoryItem] CHECK CONSTRAINT [FK_tblInventoryItem_tblTax]
GO
ALTER TABLE [dbo].[tblInvoice]  WITH CHECK ADD  CONSTRAINT [FK_tblInvoice_tblPaymentMode] FOREIGN KEY([PaymentModeID])
REFERENCES [dbo].[tblPaymentMode] ([PaymentModeID])
GO
ALTER TABLE [dbo].[tblInvoice] CHECK CONSTRAINT [FK_tblInvoice_tblPaymentMode]
GO
ALTER TABLE [dbo].[tblInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInvoiceItem_tblInvoice] FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[tblInvoice] ([InvoiceID])
GO
ALTER TABLE [dbo].[tblInvoiceItem] CHECK CONSTRAINT [FK_tblInvoiceItem_tblInvoice]
GO
ALTER TABLE [dbo].[tblInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInvoiceItem_tblProduct] FOREIGN KEY([ProductID])
REFERENCES [dbo].[tblProduct] ([ProductID])
GO
ALTER TABLE [dbo].[tblInvoiceItem] CHECK CONSTRAINT [FK_tblInvoiceItem_tblProduct]
GO
ALTER TABLE [dbo].[tblInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInvoiceItem_tblSize] FOREIGN KEY([SizeID])
REFERENCES [dbo].[tblSize] ([SizeID])
GO
ALTER TABLE [dbo].[tblInvoiceItem] CHECK CONSTRAINT [FK_tblInvoiceItem_tblSize]
GO
ALTER TABLE [dbo].[tblInvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_tblInvoiceItem_tblTax] FOREIGN KEY([TaxID])
REFERENCES [dbo].[tblTax] ([TaxID])
GO
ALTER TABLE [dbo].[tblInvoiceItem] CHECK CONSTRAINT [FK_tblInvoiceItem_tblTax]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblProduct] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[tblProductCategory] ([ProductCategoryID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblProduct]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblProductCategory] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[tblProductCategory] ([ProductCategoryID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblProductCategory]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblProductSubCategory] FOREIGN KEY([ProductSubCategoryID])
REFERENCES [dbo].[tblProductSubCategory] ([ProductSubCategoryID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblProductSubCategory]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblSize] FOREIGN KEY([SizeID])
REFERENCES [dbo].[tblSize] ([SizeID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblSize]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblTax] FOREIGN KEY([TaxID])
REFERENCES [dbo].[tblTax] ([TaxID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblTax]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblUnit] FOREIGN KEY([UnitID])
REFERENCES [dbo].[tblUnit] ([UnitID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblUnit]
GO
ALTER TABLE [dbo].[tblProductSubCategory]  WITH CHECK ADD  CONSTRAINT [FK_tblProductSubCategory_tblProductCategory] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[tblProductCategory] ([ProductCategoryID])
GO
ALTER TABLE [dbo].[tblProductSubCategory] CHECK CONSTRAINT [FK_tblProductSubCategory_tblProductCategory]
GO
ALTER TABLE [dbo].[tblQuotation]  WITH CHECK ADD  CONSTRAINT [FK_tblQuotation_tblPaymentMode] FOREIGN KEY([PaymentModeID])
REFERENCES [dbo].[tblPaymentMode] ([PaymentModeID])
GO
ALTER TABLE [dbo].[tblQuotation] CHECK CONSTRAINT [FK_tblQuotation_tblPaymentMode]
GO
ALTER TABLE [dbo].[tblQuotationItem]  WITH CHECK ADD  CONSTRAINT [FK_tblQuotationItem_tblProduct] FOREIGN KEY([ProductID])
REFERENCES [dbo].[tblProduct] ([ProductID])
GO
ALTER TABLE [dbo].[tblQuotationItem] CHECK CONSTRAINT [FK_tblQuotationItem_tblProduct]
GO
ALTER TABLE [dbo].[tblQuotationItem]  WITH CHECK ADD  CONSTRAINT [FK_tblQuotationItem_tblQuotation] FOREIGN KEY([QuotationID])
REFERENCES [dbo].[tblQuotation] ([QuotationID])
GO
ALTER TABLE [dbo].[tblQuotationItem] CHECK CONSTRAINT [FK_tblQuotationItem_tblQuotation]
GO
ALTER TABLE [dbo].[tblQuotationItem]  WITH CHECK ADD  CONSTRAINT [FK_tblQuotationItem_tblSize] FOREIGN KEY([SizeID])
REFERENCES [dbo].[tblSize] ([SizeID])
GO
ALTER TABLE [dbo].[tblQuotationItem] CHECK CONSTRAINT [FK_tblQuotationItem_tblSize]
GO
ALTER TABLE [dbo].[tblQuotationItem]  WITH CHECK ADD  CONSTRAINT [FK_tblQuotationItem_tblTax] FOREIGN KEY([TaxID])
REFERENCES [dbo].[tblTax] ([TaxID])
GO
ALTER TABLE [dbo].[tblQuotationItem] CHECK CONSTRAINT [FK_tblQuotationItem_tblTax]
GO
ALTER TABLE [dbo].[tblSize]  WITH CHECK ADD  CONSTRAINT [FK_tblSize_tblUnit] FOREIGN KEY([UnitID])
REFERENCES [dbo].[tblUnit] ([UnitID])
GO
ALTER TABLE [dbo].[tblSize] CHECK CONSTRAINT [FK_tblSize_tblUnit]
GO
ALTER TABLE [dbo].[tblStock]  WITH CHECK ADD  CONSTRAINT [FK_tblStock_tblProduct] FOREIGN KEY([ProductID])
REFERENCES [dbo].[tblProduct] ([ProductID])
GO
ALTER TABLE [dbo].[tblStock] CHECK CONSTRAINT [FK_tblStock_tblProduct]
GO
ALTER TABLE [dbo].[tblStock]  WITH CHECK ADD  CONSTRAINT [FK_tblStock_tblSize] FOREIGN KEY([SizeID])
REFERENCES [dbo].[tblSize] ([SizeID])
GO
ALTER TABLE [dbo].[tblStock] CHECK CONSTRAINT [FK_tblStock_tblSize]
GO
ALTER TABLE [dbo].[tblStock]  WITH CHECK ADD  CONSTRAINT [FK_tblStock_tblTax] FOREIGN KEY([TaxID])
REFERENCES [dbo].[tblTax] ([TaxID])
GO
ALTER TABLE [dbo].[tblStock] CHECK CONSTRAINT [FK_tblStock_tblTax]
GO
