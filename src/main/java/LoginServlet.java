import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null) username = username.trim();
        if (password != null) password = password.trim();

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            response.sendRedirect("index.jsp?error=empty");
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {

            // hash pass
            String hashedPassword = hashMD5(password);

            // query db
            String sql = "SELECT staffID, staffName, role FROM Staff WHERE username = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, hashedPassword);
                
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // login sukses
                        HttpSession session = request.getSession(true);
                        session.setAttribute("userId",   rs.getString("staffID"));
                        session.setAttribute("userName", rs.getString("staffName"));
                        session.setAttribute("role",     String.valueOf(rs.getInt("role"))); // 1 or 2
                        session.setMaxInactiveInterval(60 * 60); // 1 jam
                        
                        response.sendRedirect("sale.jsp");
                        return;
                    }
                }
            }

            // tak jumpa user
            response.sendRedirect("index.jsp?error=invalid");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=db");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    // buat md5
    private String hashMD5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 algorithm not found", e);
        }
    }
}
