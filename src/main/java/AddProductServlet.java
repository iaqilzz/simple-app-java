import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/AddProductServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AddProductServlet extends HttpServlet {

    // amik file extension
    private String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName != null && submittedFileName.contains(".")) {
            return submittedFileName.substring(submittedFileName.lastIndexOf("."));
        }
        return ".jpg"; // fallback
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // amik data dari form
        String prodIdStr = request.getParameter("prodID");
        String productName = request.getParameter("productName");
        String priceStr = request.getParameter("productPrice");
        String categoryName = request.getParameter("productCategory");
        String productType = request.getParameter("productType");

        boolean isUpdate = (prodIdStr != null && !prodIdStr.trim().isEmpty());
        long existingProdId = 0;
        if (isUpdate) {
            try {
                existingProdId = Long.parseLong(prodIdStr);
            } catch (NumberFormatException e) {
                redirectWithError(response, "Invalid Product ID.");
                return;
            }
        }

        double price = 0.0;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            redirectWithError(response, "Invalid price format.");
            return;
        }

        // proses gambar
        Part imagePart = request.getPart("productImage");
        String relativeImagePath = "";
        
        if (imagePart != null && imagePart.getSize() > 0) {
            try {
                // buat nama fail baru
                String safeProductName = productName.replaceAll("[^a-zA-Z0-9_-]", "").toLowerCase();
                String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
                String extension = getFileExtension(imagePart);
                String newFileName = safeProductName + "_" + timestamp + extension;

                // set folder upload
                String uploadFolder = "images" + File.separator + "product";
                
                // path sebenar dlm server
                String appPath = request.getServletContext().getRealPath("");
                String savePath = appPath + File.separator + uploadFolder;

                // buat folder kalau takde
                File fileSaveDir = new File(savePath);
                if (!fileSaveDir.exists()) {
                    fileSaveDir.mkdirs();
                }

                // save gambar
                Path destination = Paths.get(savePath + File.separator + newFileName);
                try (InputStream input = imagePart.getInputStream()) {
                    Files.copy(input, destination, StandardCopyOption.REPLACE_EXISTING);
                }

                // path utk simpan dlm db
                relativeImagePath = "images/product/" + newFileName;
                
            } catch (Exception e) {
                e.printStackTrace();
                redirectWithError(response, "Failed to upload image: " + e.getMessage());
                return;
            }
        }

        Connection conn = null;
        PreparedStatement psProduct = null;
        PreparedStatement psSubtype = null;
        ResultSet rs = null;

        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false); // mula transaction

            long newProdId = 0;

            if (isUpdate) {
                // UPDATE
                if (!relativeImagePath.isEmpty()) {
                    String sqlUpdate = "UPDATE Product SET prodName=?, price=?, categoryName=?, imagePath=? WHERE prodID=?";
                    psProduct = conn.prepareStatement(sqlUpdate);
                    psProduct.setString(1, productName);
                    psProduct.setDouble(2, price);
                    psProduct.setString(3, categoryName);
                    psProduct.setString(4, relativeImagePath);
                    psProduct.setLong(5, existingProdId);
                } else {
                    String sqlUpdate = "UPDATE Product SET prodName=?, price=?, categoryName=? WHERE prodID=?";
                    psProduct = conn.prepareStatement(sqlUpdate);
                    psProduct.setString(1, productName);
                    psProduct.setDouble(2, price);
                    psProduct.setString(3, categoryName);
                    psProduct.setLong(4, existingProdId);
                }
                psProduct.executeUpdate();
                newProdId = existingProdId;

                // Padam subtype lama kalau ada, supaya boleh tukar type (Plant <-> Tool)
                try (PreparedStatement psDelPlant = conn.prepareStatement("DELETE FROM Plant WHERE prodID=?")) {
                    psDelPlant.setLong(1, newProdId);
                    psDelPlant.executeUpdate();
                }
                try (PreparedStatement psDelTool = conn.prepareStatement("DELETE FROM Tool WHERE prodID=?")) {
                    psDelTool.setLong(1, newProdId);
                    psDelTool.executeUpdate();
                }

            } else {
                // INSERT
                String sqlProduct = "INSERT INTO Product (prodName, price, categoryName, imagePath) VALUES (?, ?, ?, ?)";
                String[] returnId = { "PRODID" };
                psProduct = conn.prepareStatement(sqlProduct, returnId);
                psProduct.setString(1, productName);
                psProduct.setDouble(2, price);
                psProduct.setString(3, categoryName);
                psProduct.setString(4, relativeImagePath);
                psProduct.executeUpdate();

                // dptkan id baru
                rs = psProduct.getGeneratedKeys();
                if (rs.next()) {
                    newProdId = rs.getLong(1);
                } else {
                    throw new SQLException("Creating product failed, no ID obtained.");
                }
            }

            // masuk dlm table subtype
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
                    conn.setAutoCommit(true);
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
