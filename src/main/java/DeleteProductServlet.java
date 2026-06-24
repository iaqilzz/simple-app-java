import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String prodIdStr = request.getParameter("prodID");

        if (prodIdStr == null || prodIdStr.trim().isEmpty()) {
            redirectWithError(response, "Invalid Product ID.");
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {
            long prodId = Long.parseLong(prodIdStr);

            String sql = "DELETE FROM Product WHERE prodID = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setLong(1, prodId);
                int rows = ps.executeUpdate();
                
                if (rows > 0) {
                    response.sendRedirect("product.jsp?status=success");
                } else {
                    redirectWithError(response, "Product not found or already deleted.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectWithError(response, "Database error: " + e.getMessage());
        }
    }

    private void redirectWithError(HttpServletResponse response, String message) throws IOException {
        String encodedMsg = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
        response.sendRedirect("product.jsp?status=error&message=" + encodedMsg);
    }
}
