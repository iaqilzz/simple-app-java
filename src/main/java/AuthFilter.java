import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
            
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();

        // allow public resource
        boolean isStaticResource = uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") || uri.endsWith(".jpg");
        boolean isLoginPage = uri.endsWith("index.jsp") || uri.equals(req.getContextPath() + "/");
        boolean isLoginAction = uri.endsWith("LoginServlet");

        if (isStaticResource || isLoginPage || isLoginAction) {
            chain.doFilter(request, response);
            return;
        }

        // auth guard
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);
        if (!isLoggedIn) {
            // no session, redirect login
            res.sendRedirect("index.jsp");
            return;
        }

        // role guard
        String role = (String) session.getAttribute("role");
        boolean isStaff = "2".equals(role);

        // block staff from these pages
        boolean isRestrictedForStaff = uri.endsWith("product.jsp") 
                                    || uri.endsWith("report.jsp") 
                                    || uri.endsWith("create-staff.jsp");

        if (isStaff && isRestrictedForStaff) {
            // redirect to sale page if staff
            res.sendRedirect("sale.jsp?error=unauthorized");
            return;
        }

        // pass
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
