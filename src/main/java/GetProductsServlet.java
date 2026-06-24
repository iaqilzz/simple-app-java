import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GetProductsServlet")
public class GetProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // set response to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        StringBuilder json = new StringBuilder();
        json.append("[");

        try (Connection conn = DBConfig.getConnection()) {
            // join table utk tahu jenis produk dan dpt details extra
            String sql = "SELECT p.prodID, p.prodName, p.price, p.categoryName, p.imagePath, " +
                         "CASE WHEN pl.prodID IS NOT NULL THEN 'plant' " +
                         "     WHEN t.prodID IS NOT NULL THEN 'tool' " +
                         "     ELSE 'unknown' END as type, " +
                         "pl.scientificName, pl.sunlightReq, " +
                         "t.material, t.weight " +
                         "FROM Product p " +
                         "LEFT JOIN Plant pl ON p.prodID = pl.prodID " +
                         "LEFT JOIN Tool t ON p.prodID = t.prodID " +
                         "ORDER BY p.prodID DESC";

            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {

                boolean isFirst = true;
                while (rs.next()) {
                    if (!isFirst) {
                        json.append(",");
                    }
                    isFirst = false;

                    String id = rs.getString("prodID");
                    String name = rs.getString("prodName").replace("\"", "\\\"").replace("'", "\\'");
                    String catName = rs.getString("categoryName").replace("\"", "\\\"").replace("'", "\\'");
                    String type = rs.getString("type");
                    double price = rs.getDouble("price");
                    String imagePath = rs.getString("imagePath");
                    if (imagePath == null) imagePath = "";

                    String scientificName = rs.getString("scientificName");
                    if (scientificName == null) scientificName = "";
                    else scientificName = scientificName.replace("\"", "\\\"").replace("'", "\\'");
                    
                    int sunlightReq = rs.getInt("sunlightReq");
                    
                    String material = rs.getString("material");
                    if (material == null) material = "";
                    else material = material.replace("\"", "\\\"").replace("'", "\\'");
                    
                    double weight = rs.getDouble("weight");

                    // buat json object
                    json.append("{")
                        .append("\"id\":\"").append(id).append("\",")
                        .append("\"name\":\"").append(name).append("\",")
                        .append("\"categoryName\":\"").append(catName).append("\",")
                        .append("\"type\":\"").append(type).append("\",")
                        .append("\"price\":").append(price).append(",")
                        .append("\"imagePath\":\"").append(imagePath).append("\",")
                        .append("\"scientificName\":\"").append(scientificName).append("\",")
                        .append("\"sunlightReq\":").append(sunlightReq).append(",")
                        .append("\"material\":\"").append(material).append("\",")
                        .append("\"weight\":").append(weight)
                        .append("}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // kalau ada error, return empty array
            json = new StringBuilder("[");
        }

        json.append("]");
        out.print(json.toString());
        out.flush();
    }
}
