USE [Billing1]
GO

/****** Object:  Trigger [T_InsertNewStock]    Script Date: 15/10/17 09:52:20 ******/
DROP TRIGGER [dbo].[T_InsertNewStock]
GO

/****** Object:  Trigger [dbo].[T_InsertNewStock]    Script Date: 15/10/17 09:52:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[T_InsertNewStock] ON [Billing1].[dbo].[tblInventoryItem]

  AFTER INSERT

AS 

BEGIN

  -- SET NOCOUNT ON added to prevent extra result sets from

  -- interfering with SELECT statements.

  SET NOCOUNT ON;




  DECLARE @InventoryId INT

  --DECLARE @Quantity DECIMAL(18,2)

  DECLARE @QuantityFromINventory DECIMAL(18,2)

  DECLARE @ProductID INT




  DECLARE @UpdatedQuantity  DECIMAL(18,2)




  SELECT @InventoryId=InventoryID from inserted 




  SELECT @QuantityFromINventory =  tblInventoryItem.Quantity FROM tblInventoryItem where InventoryID=@InventoryId




  SELECT @ProductID=tblInventoryItem.ProductID FROM tblInventoryItem where InventoryID=@InventoryId

  -- Insert statements for trigger here

  IF EXISTS(SELECT 1 FROM tblStock WHERE ProductID=@ProductID)
 BEGIN 
	
   UPDATE tblStock SET Quantity=tblStock.Quantity + @QuantityFromINventory From tblInventoryItem where tblStock.ProductID=@ProductID

  END

  ELSE

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

           ,[Remark]

           ,[IsActive]

           ,[CreatedOn]

           ,[UpdatedOn]

           ,[CreatedBy]

           ,[UpdatedBy])

    

	SELECT ProductID,Make,Quantity,UnitId,SizeID,RatePerUnit,TaxID,

	Tax,TaxAmount,Discount,DiscountAmount,TotalAmount,Remark,IsActive,CreatedOn,UpdatedOn,

	CreatedBy,UpdatedBy

	

	

	 FROM tblInventoryItem WHERE tblInventoryItem.InventoryID=@InventoryId

  END




  

END
GO


