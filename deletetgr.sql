USE [Billing1]
GO

/****** Object:  Trigger [T_DeleteInventoryItem]    Script Date: 15/10/17 09:52:12 ******/
DROP TRIGGER [dbo].[T_DeleteInventoryItem]
GO

/****** Object:  Trigger [dbo].[T_DeleteInventoryItem]    Script Date: 15/10/17 09:52:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[T_DeleteInventoryItem] ON [Billing1].[dbo].[tblInventoryItem]

  FOR DELETE

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

  --DECLARE @PreviousQuantity DECIMAL(18,2)
  --SELECT @PreviousQuantity=Quantity from deleted


 SELECT @InventoryId=InventoryID from deleted 

 SELECT @QuantityFromINventory = Quantity from deleted
 -- tblInventoryItem.Quantity FROM tblInventoryItem where InventoryID=@InventoryId 

 --SET @QuantityFromINventory=@QuantityFromINventory
 ---@PreviousQuantity


  SELECT @ProductID=tblInventoryItem.ProductID FROM tblInventoryItem where InventoryID=@InventoryId

  -- Insert statements for trigger here

  IF EXISTS(SELECT 1 FROM tblStock WHERE ProductID=@ProductID)
 BEGIN 
	
   UPDATE tblStock SET Quantity=tblStock.Quantity - @QuantityFromINventory From tblInventoryItem where tblStock.ProductID=@ProductID

  END

  




  

END
GO


