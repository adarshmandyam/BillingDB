USE [Billing3]
GO

/****** Object:  StoredProcedure [dbo].[spInvoice_InvoiceEntrySave]    Script Date: 25/10/17 15:40:32 ******/
DROP PROCEDURE [dbo].[spInvoice_InvoiceEntrySave]
GO

/****** Object:  StoredProcedure [dbo].[spInvoice_InvoiceEntrySave]    Script Date: 25/10/17 15:40:32 ******/
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
			
			--Adarsh for handling stock updation
			CREATE TABLE #TempInvoiceItem(
			[InvoiceItemID] [int] NOT NULL,
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
			[IsActive] [bit] NULL,
			[CreatedOn] [datetime] NULL,
			[UpdatedOn] [datetime] NULL,
			[CreatedBy] [int] NULL,
			[UpdatedBy] [int] NULL)

			--Temp table to hold data from tblInvoiceItem before it is deleted
			CREATE TABLE #TempNewInvoiceItem(
			[ID] [int] NOT NULL IDENTITY(1,1),
			[InvoiceItemID] [int] NOT NULL,
			[InvoiceID] [int] NULL,
			[ProductID] [int] NULL,			
			[Quantity] [decimal](18, 2) NULL					
			)
			
			--Adarsh : Insert into #TempInvoiceItem from [tblInvoiceItem]
			INSERT INTO #TempInvoiceItem
			SELECT * FROM [tblInvoiceItem] WHERE InvoiceID = @invoiceID

			select * from #TempInvoiceItem

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

			/* Adarsh: Insert Or update tblStock.Quantity based on ProductID */
				--select * from #TempInventoryItem 

				--Adarsh for Stock updation
				--outer loop
				IF EXISTS(SELECT * FROM #TempInvoiceItem WHERE InvoiceID = @invoiceID)
				BEGIN
					DECLARE @TempProductID INT, 				
					@TempInvoiceItemID INT, 
					@TempPreviousQuantityFromInvoice DECIMAL(18,2),
					@TempNewQuantityFromInvoice DECIMAL(18,2)

					SET @TempProductID  = 0		
					SET @TempInvoiceItemID = 0
					SET @TempPreviousQuantityFromInvoice = 0
					SET @TempNewQuantityFromInvoice = 0

					DECLARE @QuantityDiff DECIMAL(18,2),
					@StockInvoice DECIMAL(18,2),
					@UpdatedStockInvoice DECIMAL(18,2)

					SET @QuantityDiff = 0
					SET @StockInvoice = 0
					SET @UpdatedStockInvoice = 0

					DECLARE InvoiceItem_cursor CURSOR FOR
					SELECT InvoiceItemID, ProductID   
					FROM tblInvoiceItem
					WHERE InvoiceID = @invoiceID;
				
					OPEN InvoiceItem_cursor

					FETCH NEXT FROM InvoiceItem_cursor   
					INTO @TempInvoiceItemID, @TempProductID
				
					WHILE @@FETCH_STATUS = 0
					BEGIN
						DECLARE @tblInvoiceItemProductID INT, 				
						@tblInvoiceItemID INT, 
						@tblPreviousQuantityFromInvoice DECIMAL(18,2),
						@tblNewQuantityFromInvoice DECIMAL(18,2)

						SET @tblInvoiceItemProductID = 0				
						SET @tblInvoiceItemID = 0
						SET @tblPreviousQuantityFromInvoice = 0
						SET @tblNewQuantityFromInvoice = 0

						--inner loop
						DECLARE tblInvoiceItem_cursor CURSOR FOR
						SELECT InvoiceItemID, ProductID
						FROM #TempInvoiceItem
						WHERE InvoiceID = @invoiceID;	

						OPEN tblInvoiceItem_cursor

						FETCH NEXT FROM tblInvoiceItem_cursor
						INTO @tblInvoiceItemID, @tblInvoiceItemProductID

						WHILE @@FETCH_STATUS = 0
						BEGIN						
							IF EXISTS(SELECT * FROM tblInvoiceItem WHERE InvoiceID = @invoiceID AND InvoiceItemID = @TempInvoiceItemID AND ProductID = @TempProductID)
							BEGIN
								SELECT @TempPreviousQuantityFromInvoice = Quantity FROM tblInvoiceItem WHERE InvoiceID = @invoiceID AND InvoiceItemID = @TempInvoiceItemID AND ProductID = @TempProductID
								PRINT 'new invoice ' + convert(varchar,@TempPreviousQuantityFromInvoice)
								PRINT 'new invoice item id ' + convert(varchar, @TempInvoiceItemID)
								IF EXISTS(SELECT * FROM #TempInvoiceItem WHERE InvoiceID = @invoiceID AND InvoiceItemID = @tblInvoiceItemID AND ProductID = @tblInvoiceItemProductID)
								BEGIN
									SELECT @tblPreviousQuantityFromInvoice = Quantity FROM #TempInvoiceItem WHERE InvoiceID = @invoiceID AND InvoiceItemID = @tblInvoiceItemID AND ProductID = @tblInvoiceItemProductID
									Print 'old invoice ' + convert(varchar, @tblPreviousQuantityFromInvoice)
									Print 'old invoice item id ' + convert(varchar,@tblInvoiceItemID)

									SET @QuantityDiff =  @TempPreviousQuantityFromInvoice - @tblPreviousQuantityFromInvoice
									PRINT 'diff: ' + convert(varchar, @QuantityDiff)
									IF EXISTS(SELECT * FROM tblStock stock JOIN tblInvoiceItem item ON stock.ProductID = item.ProductID WHERE stock.ProductID = @tblInvoiceItemProductID)
									BEGIN
										SELECT @StockInvoice = Quantity FROM tblStock WHERE ProductID = @tblInvoiceItemProductID
										PRINT 'stock quantity ' + convert(varchar, @StockInvoice)
										SET @UpdatedStockInvoice = @StockInvoice - @QuantityDiff
										print 'updated qty ' + convert(varchar, @UpdatedStockInvoice)
										UPDATE tblStock SET Quantity = @UpdatedStockInvoice WHERE ProductID = @tblInvoiceItemProductID
									END
									ELSE
									BEGIN
										print 'into insert'
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
											SELECT @tblInvoiceItemProductID
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
											FROM tblInvoiceItem
											WHERE InvoiceID = @invoiceID AND
											InvoiceItemID = @tblInvoiceItemID AND
											ProductID = @tblInvoiceItemProductID
									END
									END
									--BREAK  -- exit out of the inner loop
									ELSE
									BEGIN
									IF EXISTS(SELECT * FROM tblStock WHERE ProductID = @TempProductID)
									BEGIN
										IF EXISTS(SELECT * FROM tblInvoiceItem WHERE InvoiceID = @invoiceID AND InvoiceItemID = @TempInvoiceItemID AND ProductID = @TempProductID)
										BEGIN
											SELECT @TempPreviousQuantityFromInvoice = Quantity FROM tblInvoiceItem WHERE InvoiceID = @invoiceID AND InvoiceItemID = @TempInvoiceItemID AND ProductID = @TempProductID
											PRINT 'new invoice ' + convert(varchar,@TempPreviousQuantityFromInvoice)								
											SELECT @StockInvoice = Quantity FROM tblStock WHERE ProductID = @TempProductID
											PRINT 'Stock invoice ' + convert(varchar, @StockInvoice)
											SET @UpdatedStockInvoice = @UpdatedStockInvoice + @TempPreviousQuantityFromInvoice
											print 'updated qty ' + convert(varchar, @UpdatedStockInvoice)
											UPDATE tblStock SET Quantity = @UpdatedStockInvoice WHERE ProductID = @TempProductID 
										END
									END										
								END
							END
						
							FETCH NEXT FROM tblInvoiceItem_cursor   
							INTO @tblInvoiceItemID, @tblInvoiceItemProductID
						END

						CLOSE tblInvoiceItem_cursor;
						DEALLOCATE tblInvoiceItem_cursor;
						--end of inner loop

						FETCH NEXT FROM InvoiceItem_cursor
						INTO @TempInvoiceItemID, @TempProductID
					END
				
					CLOSE InvoiceItem_cursor;
					DEALLOCATE InvoiceItem_cursor;

					DROP TABLE #TempInvoiceItem
				END
				ELSE
				BEGIN

				PRINT 'Else Condition'
					DECLARE @InvoiceItemID INT, @InvoiceProductID INT, @Counter INT, @QuantityTemp DECIMAL(18,2)
					,@TotalCount INT
					SET @Counter = 1

					INSERT INTO #TempNewInvoiceItem([InvoiceItemID], [InvoiceID], [ProductID], [Quantity])
					SELECT [InvoiceItemID], [InvoiceID], [ProductID], [Quantity] FROM tblInvoiceItem WHERE InvoiceID = @invoiceID 	

					select * from #TempNewInvoiceItem

					select @TotalCount = Max(ID) from #TempNewInvoiceItem

					print  @TotalCount
					print @Counter
									
					WHILE (@Counter <= @TotalCount)
					BEGIN
						SELECT @InvoiceProductID = ProductID, @QuantityTemp = Quantity  FROM #TempNewInvoiceItem WHERE ID = @Counter
						IF EXISTS(SELECT * FROM tblStock WHERE ProductID = @InvoiceProductID)
						BEGIN
						PRINT 'Inside Update'
							DECLARE @StockQty DECIMAL(18,2)
							SELECT @StockQty = Quantity FROM tblStock WHERE ProductID = @InvoiceProductID
							SET @StockQty = @StockQty - @QuantityTemp
							--SET @StockQty = @StockQty - @QuantityTemp
							PRINT @StockQty
							UPDATE tblStock SET Quantity = @StockQty WHERE ProductID = @InvoiceProductID
						END
						SET @Counter = @Counter + 1
					END
				END
				--end of outer loop

			/* Adarsh: Insert Or update tblStock.Quantity based on ProductID */
			
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


