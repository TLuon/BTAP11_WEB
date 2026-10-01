-- =====================================================================
-- ĐỀ THI QUÁ TRÌNH MÔN LẬP TRÌNH WEB (ĐỀ SỐ 05)
-- Họ và tên sinh viên: Trần Thanh Luôn
-- MSSV: 24110280
-- Mã đề: Đề Số 05
-- Database Script cho MS SQL Server
-- =====================================================================

-- ---------------------------------------------------------------------
-- Câu 1: Tạo Database & Sử dụng
-- ---------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'WebExamDe05')
BEGIN
    CREATE DATABASE WebExamDe05;
END
GO

USE WebExamDe05;
GO

-- ---------------------------------------------------------------------
-- Câu 2: Xóa bảng cũ nếu đã tồn tại (để re-run sạch)
-- ---------------------------------------------------------------------
IF OBJECT_ID(N'dbo.OrderDetails', N'U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID(N'dbo.Orders', N'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID(N'dbo.CartItem', N'U') IS NOT NULL DROP TABLE dbo.CartItem;
IF OBJECT_ID(N'dbo.Cart', N'U') IS NOT NULL DROP TABLE dbo.Cart;
IF OBJECT_ID(N'dbo.Product', N'U') IS NOT NULL DROP TABLE dbo.Product;
IF OBJECT_ID(N'dbo.Category', N'U') IS NOT NULL DROP TABLE dbo.Category;
IF OBJECT_ID(N'dbo.Users', N'U') IS NOT NULL DROP TABLE dbo.Users;
IF OBJECT_ID(N'dbo.Seller', N'U') IS NOT NULL DROP TABLE dbo.Seller;
IF OBJECT_ID(N'dbo.UserRoles', N'U') IS NOT NULL DROP TABLE dbo.UserRoles;
GO

-- ---------------------------------------------------------------------
-- Câu 3: Dựng các bảng theo sơ đồ ERD đề bài
-- ---------------------------------------------------------------------

-- Bảng 1: UserRoles
CREATE TABLE dbo.UserRoles (
    roleId INT IDENTITY(1,1) NOT NULL,
    roleName NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_UserRoles PRIMARY KEY (roleId)
);
GO

-- Bảng 2: Seller
CREATE TABLE dbo.Seller (
    sellerId INT IDENTITY(1,1) NOT NULL,
    sellername NVARCHAR(100) NOT NULL,
    images NVARCHAR(500) NULL,
    status INT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Seller PRIMARY KEY (sellerId)
);
GO

-- Bảng 3: Users
CREATE TABLE dbo.Users (
    userId INT IDENTITY(1,1) NOT NULL,
    username NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    fullname NVARCHAR(100) NOT NULL,
    password NVARCHAR(255) NOT NULL,
    images NVARCHAR(500) NULL,
    phone NVARCHAR(20) NULL,
    status INT NOT NULL DEFAULT 0, -- 0: Chờ xác thực OTP, 1: Hoạt động
    code NVARCHAR(10) NULL, -- Mã OTP xác thực
    roleId INT NOT NULL,
    sellerId INT NULL,
    CONSTRAINT PK_Users PRIMARY KEY (userId),
    CONSTRAINT FK_Users_UserRoles FOREIGN KEY (roleId) REFERENCES dbo.UserRoles(roleId),
    CONSTRAINT FK_Users_Seller FOREIGN KEY (sellerId) REFERENCES dbo.Seller(sellerId)
);
GO

-- Bảng 4: Category
CREATE TABLE dbo.Category (
    categoryId INT IDENTITY(1,1) NOT NULL,
    categoryName NVARCHAR(100) NOT NULL,
    images NVARCHAR(500) NULL,
    status INT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Category PRIMARY KEY (categoryId)
);
GO

-- Bảng 5: Product
CREATE TABLE dbo.Product (
    productId INT IDENTITY(1,1) NOT NULL,
    productName NVARCHAR(200) NOT NULL,
    productCode BIGINT NOT NULL,
    categoryId INT NOT NULL,
    description NVARCHAR(MAX) NULL,
    price FLOAT NOT NULL,
    amount INT NOT NULL DEFAULT 0,
    stock INT NOT NULL DEFAULT 0,
    images NVARCHAR(500) NULL,
    wishlist INT NOT NULL DEFAULT 0,
    status INT NOT NULL DEFAULT 1,
    createDate DATE NOT NULL DEFAULT GETDATE(),
    sellerId INT NOT NULL,
    CONSTRAINT PK_Product PRIMARY KEY (productId),
    CONSTRAINT FK_Product_Category FOREIGN KEY (categoryId) REFERENCES dbo.Category(categoryId),
    CONSTRAINT FK_Product_Seller FOREIGN KEY (sellerId) REFERENCES dbo.Seller(sellerId)
);
GO

-- Bảng 6: Cart
CREATE TABLE dbo.Cart (
    cartId NVARCHAR(50) NOT NULL,
    userId INT NOT NULL,
    buyDate DATETIME NOT NULL DEFAULT GETDATE(),
    status INT NOT NULL DEFAULT 1,
    CONSTRAINT PK_Cart PRIMARY KEY (cartId),
    CONSTRAINT FK_Cart_Users FOREIGN KEY (userId) REFERENCES dbo.Users(userId)
);
GO

-- Bảng 7: CartItem
CREATE TABLE dbo.CartItem (
    cartItemId NVARCHAR(50) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unitPrice FLOAT NOT NULL DEFAULT 0,
    productId INT NOT NULL,
    cartId NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_CartItem PRIMARY KEY (cartItemId),
    CONSTRAINT FK_CartItem_Product FOREIGN KEY (productId) REFERENCES dbo.Product(productId),
    CONSTRAINT FK_CartItem_Cart FOREIGN KEY (cartId) REFERENCES dbo.Cart(cartId)
);
GO

-- ---------------------------------------------------------------------
-- Câu 4: Seed Data (Dữ liệu mẫu demo)
-- Mật khẩu mẫu cho tất cả user bên dưới là '123456'
-- Đã hash qua BCrypt: $2a$10$e88aV4m2rV4d1N9b.H/52O2Z5s1Ym2U1u3h8q.h0Y7r.W6k
-- ---------------------------------------------------------------------

-- Insert Roles
INSERT INTO dbo.UserRoles (roleName) VALUES (N'Admin');
INSERT INTO dbo.UserRoles (roleName) VALUES (N'User');
INSERT INTO dbo.UserRoles (roleName) VALUES (N'Seller');
GO

-- Insert Sellers
INSERT INTO dbo.Seller (sellername, images, status) 
VALUES (N'Cửa hàng Công Nghệ Luôn Tech (STORE01)', N'https://picsum.photos/id/1/300/200', 1);

INSERT INTO dbo.Seller (sellername, images, status) 
VALUES (N'Thời Trang & Phong Cách Luôn Style (STORE02)', N'https://picsum.photos/id/2/300/200', 1);

INSERT INTO dbo.Seller (sellername, images, status) 
VALUES (N'Nhà Sách & Thiết Bị Tri Thức (STORE03)', N'https://picsum.photos/id/3/300/200', 1);
GO

-- Insert Users (Password default = '123456' hashed with BCrypt)
-- Admin: username = admin
-- User: username = user1
-- Seller: username = seller1
INSERT INTO dbo.Users (username, email, fullname, password, images, phone, status, code, roleId, sellerId)
VALUES 
(N'admin', N'admin@tranthanhluon.com', N'Trần Thanh Luôn (Admin)', N'$2a$10$zHG9LwHUGlFj52h5UZUqPevUXIq7QJK.0OGdbTtQJFYfb8Dr0eTqa', N'https://picsum.photos/id/1005/150/150', N'0901234567', 1, NULL, 1, NULL),
(N'user1', N'user1@tranthanhluon.com', N'Nguyễn Văn A (Khách Hàng)', N'$2a$10$zHG9LwHUGlFj52h5UZUqPevUXIq7QJK.0OGdbTtQJFYfb8Dr0eTqa', N'https://picsum.photos/id/1011/150/150', N'0912345678', 1, NULL, 2, NULL),
(N'seller1', N'seller1@tranthanhluon.com', N'Chủ Cửa Hàng Tech (Seller 1)', N'$2a$10$zHG9LwHUGlFj52h5UZUqPevUXIq7QJK.0OGdbTtQJFYfb8Dr0eTqa', N'https://picsum.photos/id/1025/150/150', N'0923456789', 1, NULL, 3, 1);
GO

-- Insert Category
INSERT INTO dbo.Category (categoryName, images, status) VALUES 
(N'Điện Thoại & Máy Tính Bảng', N'https://picsum.photos/id/160/300/200', 1),
(N'Laptop & Phụ Kiện', N'https://picsum.photos/id/180/300/200', 1),
(N'Thời Trang Nam & Nữ', N'https://picsum.photos/id/1062/300/200', 1),
(N'Sách & Văn Phòng Phẩm', N'https://picsum.photos/id/24/300/200', 1),
(N'Gia Dụng & Đời Sống', N'https://picsum.photos/id/42/300/200', 1);
GO

-- Insert Products (15 sản phẩm phân bổ đều cho 3 Seller và 5 Category)
INSERT INTO dbo.Product (productName, productCode, categoryId, description, price, amount, stock, images, wishlist, status, createDate, sellerId)
VALUES 
-- Seller 1 (Luôn Tech - STORE01)
(N'iPhone 15 Pro Max 256GB Natural Titanium', 1000000001, 1, N'Smartphone cao cấp nhất thế giới với khung vỏ titan siêu nhẹ và chip A17 Pro đỉnh cao.', 29990000, 15, 100, N'https://picsum.photos/id/160/500/400', 10, 1, GETDATE(), 1),
(N'Samsung Galaxy S24 Ultra 5G 512GB', 1000000002, 1, N'Quyền năng AI trong tầm tay với camera 200MP và bút S-Pen tích hợp tiện lợi.', 27490000, 20, 85, N'https://picsum.photos/id/201/500/400', 8, 1, GETDATE(), 1),
(N'MacBook Pro 14 inch M3 Pro 18GB 512GB', 1000000003, 2, N'Laptop đồ họa siêu việt dành cho lập trình viên và creator chuyên nghiệp.', 48990000, 10, 50, N'https://picsum.photos/id/180/500/400', 25, 1, GETDATE(), 1),
(N'Dell XPS 13 Plus 9320 Intel Core i7', 1000000004, 2, N'Thiết kế tương lai vô cực với thanh điều khiển cảm ứng cực kỳ tinh tế.', 36500000, 8, 30, N'https://picsum.photos/id/119/500/400', 12, 1, GETDATE(), 1),
(N'Tai nghe Bluetooth Sony WH-1000XM5', 1000000005, 2, N'Tai nghe chống ồn đỉnh cao cho âm thanh trung thực và đàm thoại rõ nét.', 7490000, 45, 120, N'https://picsum.photos/id/367/500/400', 18, 1, GETDATE(), 1),

-- Seller 2 (Luôn Style - STORE02)
(N'Áo Sơ Mi Nam Tay Dài Premium Cotton', 2000000001, 3, N'Chất liệu cotton 100% thoáng mát, form dáng Slimfit sang trọng lịch lãm.', 450000, 100, 500, N'https://picsum.photos/id/1025/500/400', 5, 1, GETDATE(), 2),
(N'Áo Khoác Blazer Nữ Form Rộng Hàn Quốc', 2000000002, 3, N'Phong cách thời trang công sở hiện đại, chất vải dầy dặn lên form chuẩn.', 680000, 80, 250, N'https://picsum.photos/id/338/500/400', 14, 1, GETDATE(), 2),
(N'Giày Sneaker Nam Thể Thao Đa Năng', 2000000003, 3, N'Đế cao su đàn hồi êm ái, kiểu dáng trẻ trung phù hợp đi học đi chơi.', 1250000, 60, 200, N'https://picsum.photos/id/103/500/400', 22, 1, GETDATE(), 2),
(N'Túi Xách Nữ Da Thật Cao Cấp Luôn Luxury', 2000000004, 3, N'Chất liệu da bò thật mềm mịn, đường may thủ công tỉ mỉ tôn lên vẻ quý phái.', 2150000, 30, 90, N'https://picsum.photos/id/823/500/400', 30, 1, GETDATE(), 2),
(N'Mắt Kính Chống Tia UV Style Pilot', 2000000005, 3, N'Kính mát phi công thời trang bảo vệ mắt tối đa trước ánh nắng mặt trời.', 390000, 150, 400, N'https://picsum.photos/id/64/500/400', 9, 1, GETDATE(), 2),

-- Seller 3 (Tri Thức & Đời Sống - STORE03)
(N'Sách Lập Trình Web Với Java Servlet & JSP', 3000000001, 4, N'Giáo trình thực hành xây dựng ứng dụng web chuẩn enterprise từ cơ bản đến nâng cao.', 210000, 200, 1000, N'https://picsum.photos/id/24/500/400', 50, 1, GETDATE(), 3),
(N'Sách Đắc Nhân Tâm - Dale Carnegie', 3000000002, 4, N'Cuốn sách nghệ thuật ứng xử và thu phục lòng người hay nhất mọi thời đại.', 115000, 300, 1500, N'https://picsum.photos/id/366/500/400', 88, 1, GETDATE(), 3),
(N'Bộ Bút Ký Tên Kim Loại Mạ Vàng 18K', 3000000003, 4, N'Bút ký doanh nhân cao cấp nét mực trơn mịn kèm hộp quà tặng sang trọng.', 490000, 50, 150, N'https://picsum.photos/id/445/500/400', 15, 1, GETDATE(), 3),
(N'Nồi Chiên Không Dầu Smart Cook 6.5L', 3000000004, 5, N'Công nghệ chiên chân không giảm 85% mỡ thừa, bảng điều khiển cảm ứng thông minh.', 1890000, 40, 120, N'https://picsum.photos/id/42/500/400', 35, 1, GETDATE(), 3),
(N'Máy Lọc Không Khí Hepa Home Clean Pro', 3000000005, 5, N'Màng lọc HEPA 13 loại bỏ 99.97% bụi mịn PM2.5 và vi khuẩn trong không khí.', 3200000, 25, 70, N'https://picsum.photos/id/225/500/400', 20, 1, GETDATE(), 3);
GO

-- Bảng 8: Orders
CREATE TABLE dbo.Orders (
    orderId INT IDENTITY(1,1) NOT NULL,
    userId INT NOT NULL,
    orderDate DATETIME NOT NULL DEFAULT GETDATE(),
    status NVARCHAR(50) NOT NULL DEFAULT N'NEW',
    fullName NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    address NVARCHAR(500) NOT NULL,
    note NVARCHAR(500) NULL,
    paymentMethod NVARCHAR(50) NOT NULL DEFAULT N'COD',
    totalAmount FLOAT NOT NULL DEFAULT 0,
    CONSTRAINT PK_Orders PRIMARY KEY (orderId),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (userId) REFERENCES dbo.Users(userId)
);
GO

-- Bảng 9: OrderDetails
CREATE TABLE dbo.OrderDetails (
    orderDetailId INT IDENTITY(1,1) NOT NULL,
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unitPrice FLOAT NOT NULL DEFAULT 0,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (orderDetailId),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (orderId) REFERENCES dbo.Orders(orderId),
    CONSTRAINT FK_OrderDetails_Product FOREIGN KEY (productId) REFERENCES dbo.Product(productId)
);
GO

-- Insert sample orders
INSERT INTO dbo.Orders (userId, orderDate, status, fullName, phone, address, note, totalAmount) VALUES
(2, GETDATE()-5, N'DELIVERED', N'Nguyễn Văn A', N'0912345678', N'123 Đường Số 1, Quận 1, TP.HCM', N'Giao giờ hành chính', 36500000),
(2, GETDATE()-1, N'PREPARING', N'Nguyễn Văn A', N'0912345678', N'123 Đường Số 1, Quận 1, TP.HCM', N'', 450000),
(2, GETDATE(), N'NEW', N'Nguyễn Văn A', N'0912345678', N'123 Đường Số 1, Quận 1, TP.HCM', N'Gọi trước khi giao', 7490000),
(2, GETDATE()-2, N'CANCELLED', N'Nguyễn Văn A', N'0912345678', N'123 Đường Số 1, Quận 1, TP.HCM', N'', 210000);
GO

INSERT INTO dbo.OrderDetails (orderId, productId, quantity, unitPrice) VALUES
(1, 4, 1, 36500000),
(2, 6, 1, 450000),
(3, 5, 1, 7490000),
(4, 11, 1, 210000);
GO

PRINT N'=== TẠO DATABASE VÀ DỮ LIỆU MẪU ĐỀ SỐ 05 THÀNH CÔNG! ===';
GO
