# BÀI KIỂM TRA QUÁ TRÌNH MÔN LẬP TRÌNH WEB (ĐỀ SỐ 05)
# Đã hoàn thiện 3 yêu cầu của bài tập 11
**Thông tin sinh viên:**
- Họ tên: Trần Thanh Luôn
- MSSV: 24110280
- Đề thi: Đề Số 05

---

## 1. Công nghệ sử dụng (Tech Stack)
- **Ngôn ngữ:** Java 21
- **Quản lý dự án:** Maven (đóng gói .war)
- **Web Platform:** Jakarta EE 10 (Servlet 6.0, JSP 3.1, JSTL 3.0)
- **Server:** Apache Tomcat 10.1+
- **Kiến trúc:** 3-Tier Architecture (Controller/Servlet -> Service -> DAO) + MVC Pattern
- **ORM / Database:** Hibernate Core 6.4 (JPA) + Microsoft SQL Server
- **UI / Design:** Bootstrap 5, SiteMesh 3.2 (Decorator cho User & Admin)
- **Bảo mật & Utility:** jBCrypt (Mã hóa mật khẩu), Jakarta Mail (Gửi OTP)

---

## 2. Hướng dẫn cài đặt và cấu hình

### Bước 1: Khởi tạo Database
1. Mở Microsoft SQL Server Management Studio (SSMS).
2. Mở file `database.sql` tại thư mục gốc của dự án.
3. Chạy script (F5). Script sẽ tự động tạo database `WebExamDe05`, tạo các bảng cần thiết (`Users`, `Product`, `Orders`, `OrderDetails`, `Cart`, `CartItem`,...) và chèn dữ liệu mẫu (Seed Data) đầy đủ.

### Bước 2: Cấu hình kết nối (Nếu cần)
Mở file `src/main/resources/META-INF/persistence.xml` để thay đổi `javax.persistence.jdbc.user` và `javax.persistence.jdbc.password` nếu tài khoản sa của bạn khác `Thanhluon@25`.

### Bước 3: Build và Deploy
1. Mở terminal/CMD tại thư mục dự án.
2. Chạy lệnh: `mvn clean package` để build project. Đợi đến khi báo `BUILD SUCCESS`.
3. Copy file `target/WebExamDe05.war` vào thư mục `webapps/` của Apache Tomcat 10.1+.
4. Khởi động Tomcat (`bin/startup.bat`).

---

## 3. Danh sách URL Endpoints (Các tính năng đã triển khai)

- **Đăng nhập:** `/login` (Tài khoản User test: `user1` / Pass: `123456`)
- **Đăng xuất:** `/logout`
- **Trang chủ:** `/home` hoặc `/`
- **Giỏ hàng (Cart):**
  - Xem giỏ hàng: `/cart`
  - Thêm sản phẩm: POST `/cart/add`
  - Cập nhật số lượng: POST `/cart/update`
  - Xóa 1 sản phẩm: `/cart/delete?cartItemId=...`
  - Xóa toàn bộ giỏ: `/cart/clear`
- **Thanh toán (Checkout COD):**
  - Mở trang checkout: `/checkout`
  - Xử lý đặt hàng: POST `/checkout/place-order` (Trừ tồn kho, lưu Database)
- **Lịch sử đơn hàng (Order History):**
  - Xem danh sách và lọc trạng thái: `/orders?status=...`
  - Chi tiết đơn hàng: `/orders/detail?orderId=...`
  - Hủy đơn hàng: POST `/orders/cancel` (Chỉ hủy được đơn `NEW`, trả lại tồn kho).

---

## 4. Hướng dẫn Test 3 tính năng (User)

**A. Test Giỏ hàng (Cart):**
1. Đăng nhập với tài khoản `user1` / mật khẩu `123456`.
2. Vào màn hình Sản phẩm, chọn 1 sản phẩm và thêm vào giỏ.
3. Vào màn hình Giỏ hàng: Thử thay đổi số lượng (Ví dụ: Nhập số lượng lớn hơn Tồn kho, hệ thống sẽ tự động gán lại về mức tối đa).
4. Thử xóa từng mặt hàng hoặc nhấn "Xóa toàn bộ giỏ hàng".

**B. Test Đặt hàng & Thanh toán (Checkout COD):**
1. Trong màn hình Giỏ hàng, nhấn "Tiến hành thanh toán".
2. Điền thông tin người nhận (Họ tên, SĐT, Địa chỉ) và xác nhận chọn COD.
3. Bấm "Đặt hàng ngay". Hệ thống sẽ tạo mã đơn hàng, hiển thị trang "Đặt hàng thành công", đồng thời trừ tự động số lượng `stock` trong DB và làm trống giỏ hàng hiện tại.

**C. Test Lịch sử đơn & Filter trạng thái:**
1. Chọn "Lịch sử đơn hàng" từ menu dropdown tài khoản trên header.
2. Bạn sẽ thấy danh sách đơn hàng vừa đặt ở trạng thái `Đơn mới` (NEW).
3. Thử nhấn "Hủy đơn", đơn sẽ chuyển sang trạng thái `Đã hủy` (CANCELLED) và số lượng tồn kho tự động cộng dồn lại vào kho (`Product.stock`).

### * Bảng quy ước 8 Trạng thái Đơn hàng:

| Mã Trạng Thái | Hiển thị trên UI | Mô tả |
| ------------- | ---------------- | ----- |
| `NEW`         | Đơn mới          | Đơn hàng vừa được đặt, User có thể Hủy. |
| `CONFIRMED`   | Đã xác nhận      | Admin/Seller đã xác nhận. |
| `PREPARING`   | Chuẩn bị hàng    | Đang đóng gói. |
| `SHIPPING`    | Vận chuyển       | Bàn giao cho đơn vị vận chuyển. |
| `DELIVERING`  | Giao hàng        | Shipper đang mang tới cho khách. |
| `DELIVERED`   | Đã giao          | Giao thành công. |
| `CANCELLED`   | Đã hủy           | Bị hủy (Bởi khách hoặc Admin), kho đã được hoàn. |
| `RETURNED`    | Hoàn trả         | Đơn giao thất bại và hàng đã hoàn về kho. |

**Câu lệnh SQL test đổi trạng thái thủ công (Chạy trong SSMS):**
```sql
-- Ví dụ: Đổi trạng thái đơn hàng có orderId = 1 sang 'DELIVERING'
UPDATE dbo.Orders SET status = N'DELIVERING' WHERE orderId = 1;

-- Xem lại trạng thái
SELECT orderId, status FROM dbo.Orders;
```
"# BTAP11_WEB" 
