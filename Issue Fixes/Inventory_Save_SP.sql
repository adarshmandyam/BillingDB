USE [Billing3]
GO

/****** Object:  StoredProcedure [dbo].[spInventory_InventoryEntrySave]    Script Date: 25/10/17 15:40:11 ******/
DROP PROCEDURE [dbo].[spInventory_InventoryEntrySave]
GO

/****** Object:  StoredProcedure [dbo].[spInventory_InventoryEntrySave]    Script Date: 25/10/17 15:40:11 ******/
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

			--Temp table to hold data from tblInventoryItem before it is deleted
			CREATE TABLE #TempInventoryItem(
			[InventoryItemID] [int] NOT NULL,
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
			[IsActive] [bit] NULL,
			[CreatedOn] [datetime] NULL DEFAULT (getdate()),
			[UpdatedOn] [datetime] NULL,
			[CreatedBy] [int] NULL,
			[UpdatedBy] [int] NULL
			)

			--Temp table to hold data from tblInventoryItem before it is deleted
			CREATE TABLE #TempNewInventoryItem(
			[ID] [int] NOT NULL IDENTITY(1,1),
			[InventoryItemID] [int] NOT NULL,
			[InventoryID] [int] NULL,
			[ProductID] [int] NULL,			
			[Quantity] [decimal](18, 2) NULL					
			)

			-- Adarsh: Save to Temp table before deleting
			INSERT INTO #TempInventoryItem
			SELECT * FROM tblInventoryItem WHERE InventoryID = @InventoryID

			--select * from #TempInventoryItem
			
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
			
			/* Adarsh: Insert Or update tblStock.Quantity based on ProductID */
				--select * from #TempInventoryItem 

				-- Check if Data Exists for this Inventory, Only then proceed to update Stock
				IF EXISTS(SELECT * FROM #TempInventoryItem WHERE InventoryID = @InventoryID)
				BEGIN
					--outer loop
					DECLARE @TempProductID INT, 				
					@TempInventoryItemID INT, 
					@TempPreviousQuantityFromInventory DECIMAL(18,2),
					@TempNewQuantityFromInventory DECIMAL(18,2),
					@UpdatedStockInventory DECIMAL(18,2),
					@QuantityDiff DECIMAL(18,2),
					@StockInventory DECIMAL(18,2)

					SET @TempProductID = 0
					SET @TempPreviousQuantityFromInventory = 0
					SET @TempNewQuantityFromInventory = 0
					SET @UpdatedStockInventory = 0
					SET @QuantityDiff = 0
					SET @StockInventory = 0

					DECLARE InventoryItem_cursor CURSOR FOR
					SELECT InventoryItemID, ProductID   
					FROM tblInventoryItem
					WHERE InventoryID = @InventoryID;
				
					OPEN InventoryItem_cursor

					FETCH NEXT FROM InventoryItem_cursor   
					INTO @TempInventoryItemID, @TempProductID  
				
					WHILE @@FETCH_STATUS = 0
					BEGIN
						DECLARE @tblInventoryItemProductID INT,
						@tblInventoryItemID INT,
						@tblPreviousQuantityFromInventory DECIMAL(18,2),
						@tblNewQuantityFromInventory DECIMAL(18,2)

						SET @tblInventoryItemProductID = 0
						SET @tblInventoryItemID = 0
						SET @tblPreviousQuantityFromInventory = 0
						SET @tblNewQuantityFromInventory = 0

						--inner loop
						DECLARE tblInventoryItem_cursor CURSOR FOR
						SELECT InventoryItemID, ProductID
						FROM #TempInventoryItem
						WHERE InventoryID = @InventoryID;	

						OPEN tblInventoryItem_cursor

						FETCH NEXT FROM tblInventoryItem_cursor
						INTO @tblInventoryItemID, @tblInventoryItemProductID

						WHILE @@FETCH_STATUS = 0
						BEGIN						
							IF EXISTS(SELECT * FROM tblInventoryItem WHERE InventoryID = @InventoryID AND InventoryItemID = @TempInventoryItemID AND ProductID = @TempProductID)
							BEGIN
								SELECT @TempPreviousQuantityFromInventory = Quantity FROM tblInventoryItem WHERE InventoryID = @InventoryID AND InventoryItemID = @TempInventoryItemID AND ProductID = @TempProductID
								PRINT 'new inventory ' + convert(varchar,@TempPreviousQuantityFromInventory)
								IF EXISTS(SELECT * FROM #TempInventoryItem WHERE InventoryID = @InventoryID AND InventoryItemID = @tblInventoryItemID AND ProductID = @tblInventoryItemProductID)
								BEGIN
									SELECT @tblPreviousQuantityFromInventory = Quantity FROM #TempInventoryItem WHERE InventoryID = @InventoryID AND InventoryItemID = @tblInventoryItemID AND ProductID = @tblInventoryItemProductID
									Print 'old inventory ' + convert(varchar, @tblPreviousQuantityFromInventory)
									SET @QuantityDiff =  @TempPreviousQuantityFromInventory - @tblPreviousQuantityFromInventory
									PRINT 'diff: ' + convert(varchar, @QuantityDiff)
									IF EXISTS(SELECT * FROM tblStock  stock JOIN tblInventoryItem item ON stock.ProductID = item.ProductID WHERE stock.ProductID = @tblInventoryItemProductID)
									BEGIN
										SELECT @StockInventory = Quantity FROM tblStock WHERE ProductID = @tblInventoryItemProductID
										PRINT 'Stock inventory ' + convert(varchar, @StockInventory)
										SET @UpdatedStockInventory = @StockInventory + @QuantityDiff
										print 'updated qty ' + convert(varchar, @UpdatedStockInventory)
										UPDATE tblStock SET Quantity = @UpdatedStockInventory WHERE ProductID = @tblInventoryItemProductID 
									END
									ELSE
									BEGIN
										print 'into insert '
										--select values from tblInventoryItem
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
										SELECT @tblInventoryItemProductID
												,Make
												,Quantity
												,UnitID
												,SizeID
												,RatePerUnit
												,TaxID
												,Tax
												,TaxAmount											   
												,[Discount]
												,[DiscountAmount]
												,[TotalAmount]
												,[Remark]
												,[IsActive]
												,[CreatedOn]
												,[UpdatedOn]
												,[CreatedBy]
												,[UpdatedBy]
										FROM tblInventoryItem 
										WHERE InventoryID = @InventoryID AND 
										InventoryItemID = @tblInventoryItemID AND
										ProductID = @tblInventoryItemProductID
									END
									--BREAK  -- exit out of the loop
								END
								ELSE
								BEGIN
									IF EXISTS(SELECT * FROM tblStock WHERE ProductID = @TempProductID)
									BEGIN
										IF EXISTS(SELECT * FROM tblInventoryItem WHERE InventoryID = @InventoryID AND InventoryItemID = @TempInventoryItemID AND ProductID = @TempProductID)
										BEGIN
											SELECT @TempPreviousQuantityFromInventory = Quantity FROM tblInventoryItem WHERE InventoryID = @InventoryID AND InventoryItemID = @TempInventoryItemID AND ProductID = @TempProductID
											PRINT 'new inventory ' + convert(varchar,@TempPreviousQuantityFromInventory)								
											SELECT @StockInventory = Quantity FROM tblStock WHERE ProductID = @TempProductID
											PRINT 'Stock inventory ' + convert(varchar, @StockInventory)
											SET @UpdatedStockInventory = @StockInventory + @TempPreviousQuantityFromInventory
											print 'updated qty ' + convert(varchar, @UpdatedStockInventory)
											UPDATE tblStock SET Quantity = @UpdatedStockInventory WHERE ProductID = @TempProductID 
										END
									END	
								END
							END
						
							FETCH NEXT FROM tblInventoryItem_cursor   
							INTO @tblInventoryItemID, @tblInventoryItemProductID
						END

						CLOSE tblInventoryItem_cursor;
						DEALLOCATE tblInventoryItem_cursor;
						--end of inner loop

						FETCH NEXT FROM InventoryItem_cursor   
						INTO @TempInventoryItemID, @TempProductID
					END
				
					CLOSE InventoryItem_cursor;
					DEALLOCATE InventoryItem_cursor;

					DROP TABLE #TempInventoryItem --end of outer loop										
				END
				ELSE
				BEGIN					
					DECLARE @InventoryItemID INT, @InventoryProductID INT, @Counter INT, @QuantityTemp DECIMAL(18,2)
					,@TotalCount INT
					SET @Counter = 1

					INSERT INTO #TempNewInventoryItem([InventoryItemID], [InventoryID], [ProductID], [Quantity])
					SELECT [InventoryItemID], [InventoryID], [ProductID], [Quantity] FROM tblInventoryItem WHERE InventoryID = @InventoryID 	

					select * from #TempNewInventoryItem

					select @TotalCount = Max(ID) from #TempNewInventoryItem
									
					WHILE (@Counter <= @TotalCount)
					BEGIN
						SELECT @InventoryProductID = ProductID, @QuantityTemp = Quantity  FROM #TempNewInventoryItem WHERE ID = @Counter
						IF EXISTS(SELECT * FROM tblStock WHERE ProductID = @InventoryProductID)
						BEGIN
							DECLARE @StockQty DECIMAL(18,2)
							SELECT @StockQty = Quantity FROM tblStock WHERE ProductID = @InventoryProductID
							SET @QuantityTemp = @QuantityTemp + @StockQty
							UPDATE tblStock SET Quantity = @QuantityTemp WHERE ProductID = @InventoryProductID
						END
						SET @Counter = @Counter + 1
					END
				END
			/* Adarsh : Insert Or update tblStock.Quantity based on ProductID */


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


