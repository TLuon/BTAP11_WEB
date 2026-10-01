package com.tranthanhluon.webexam.controller;

import com.tranthanhluon.webexam.entity.User_24110280;
import com.tranthanhluon.webexam.service.UserServiceImpl_24110280;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AuthController_24110280", urlPatterns = {"/login", "/register", "/verify-otp", "/logout"})
public class AuthController_24110280 extends HttpServlet {

    private final UserServiceImpl_24110280 userService = new UserServiceImpl_24110280();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/register":
                req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                break;
            case "/verify-otp":
                req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(req, resp);
                break;
            case "/logout":
                HttpSession session = req.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                resp.sendRedirect(req.getContextPath() + "/login?message=logged_out");
                break;
            case "/login":
            default:
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/login".equals(path)) {
            handleLogin(req, resp);
        } else if ("/register".equals(path)) {
            handleRegister(req, resp);
        } else if ("/verify-otp".equals(path)) {
            handleVerifyOtp(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User_24110280 user = userService.login(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullname", user.getFullname());
            session.setAttribute("roleId", user.getRole() != null ? user.getRole().getRoleId() : 2);
            session.setAttribute("roleName", user.getRole() != null ? user.getRole().getRoleName() : "User");
            session.setAttribute("sellerId", user.getSeller() != null ? user.getSeller().getSellerId() : null);

            if (user.getRole() != null && user.getRole().getRoleId() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/category");
            } else if (user.getSeller() != null) {
                resp.sendRedirect(req.getContextPath() + "/seller/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/products");
            }
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng, hoặc tài khoản chưa kích hoạt OTP!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        String result = userService.registerUser(username, email, fullname, password, phone);

        if ("SUCCESS".equals(result)) {
            User_24110280 createdUser = userService.findByUsername(username);
            String otpCode = (createdUser != null) ? createdUser.getCode() : "";
            req.setAttribute("pendingUsername", username);
            req.setAttribute("demoOtp", otpCode);
            req.setAttribute("successMessage", "Mã OTP đã khởi tạo cho email " + email + ". (Mã OTP xác thực: " + otpCode + ")");
            req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", result);
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        }
    }

    private void handleVerifyOtp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String otpCode = req.getParameter("otpCode");

        String result = userService.verifyOtp(username, otpCode);

        if ("SUCCESS".equals(result)) {
            req.setAttribute("successMessage", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", result);
            req.setAttribute("pendingUsername", username);
            req.getRequestDispatcher("/WEB-INF/views/auth/verify-otp.jsp").forward(req, resp);
        }
    }
}
