select * from tblInventory
select * from tblInventoryItem 
select * from tblStock
select * from tblProduct
select * from tblInvoice
select * from tblInvoiceItem
select * from tblStock


--1	unilever	985.00
--2	unilever1	304.00
--3	Mens Shampoo	61.00

--1	unilever	983.00
--2	unilever1	304.00
--3	Mens Shampoo	61.00

--1	unilever	982.00
--2	unilever1	304.00
--3	Mens Shampoo	60.00

--1	unilever	979.00
--2	unilever1	304.00
--3	Mens Shampoo	59.00

select * from tblStock a
join tblInvoiceItem b on b.ProductID = a.ProductID 
where a.ProductID = 3 and b.InvoiceItemID = 15