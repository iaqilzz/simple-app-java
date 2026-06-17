


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Retrieve
        String productName = request.getParameter("productName");
        String priceStr = request.getParameter("productPrice");
        String categoryName = request.getParameter("productCategory");
        String productType = request.getParameter("productType");

        double price = 0.0;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            redirectWithError(response, "Invalid price format.");
            return;
        }

        Connection conn = null;
        PreparedStatement psProduct = null;
        PreparedStatement psSubtype = null;
        ResultSet rs = null;

        try {
            conn = DBConfig.getConnection();
            // Start transaction
            conn.setAutoCommit(false);

            String sqlProduct = "INSERT INTO Product (prodName, price, categoryName) VALUES (?, ?, ?)";
            
            // We need to return the generated keys to get the new prodID
            String[] returnId = { "PRODID" };
            psProduct = conn.prepareStatement(sqlProduct, returnId);
            psProduct.setString(1, productName);
            psProduct.setDouble(2, price);
            psProduct.setString(3, categoryName);
            psProduct.executeUpdate();

            // Retrieve the generated prodID
            rs = psProduct.getGeneratedKeys();
            long newProdId = 0;
            if (rs.next()) {
                newProdId = rs.getLong(1);
            } else {
                throw new SQLException("Creating product failed, no ID obtained.");
            }

            // 2. Insert into Plant or Tool table (Subtype)
            if ("Plant".equals(productType)) {
                String scientificName = request.getParameter("scientificName");
                String sunlightReqStr = request.getParameter("sunlightReq");
                int sunlightReq = (sunlightReqStr != null && !sunlightReqStr.isEmpty()) ? Integer.parseInt(sunlightReqStr) : 0;

                String sqlPlant = "INSERT INTO Plant (prodID, scientificName, sunlightReq) VALUES (?, ?, ?)";
                psSubtype = conn.prepareStatement(sqlPlant);
                psSubtype.setLong(1, newProdId);
                psSubtype.setString(2, scientificName);
                psSubtype.setInt(3, sunlightReq);
                psSubtype.executeUpdate();

            } else if ("Tool".equals(productType)) {
                String material = request.getParameter("material");
                String weightStr = request.getParameter("weight");
                double weight = (weightStr != null && !weightStr.isEmpty()) ? Double.parseDouble(weightStr) : 0.0;

                String sqlTool = "INSERT INTO Tool (prodID, material, weight) VALUES (?, ?, ?)";
                psSubtype = conn.prepareStatement(sqlTool);
                psSubtype.setLong(1, newProdId);
                psSubtype.setString(2, material);
                psSubtype.setDouble(3, weight);
                psSubtype.executeUpdate();
                
            } else {
                throw new SQLException("Invalid product type selected.");
            }

            // Commit transaction
            conn.commit();
            
            // Redirect with success message
            response.sendRedirect("product.jsp?status=success");

        } catch (Exception e) {
            e.printStackTrace();
            // Rollback transaction if any error occurs
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            redirectWithError(response, "Database error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (psProduct != null) psProduct.close();
                if (psSubtype != null) psSubtype.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // reset default
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void redirectWithError(HttpServletResponse response, String message) throws IOException {
        String encodedMsg = URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
        response.sendRedirect("product.jsp?status=error&message=" + encodedMsg);
    }
}
