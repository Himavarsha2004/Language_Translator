<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="indexstyle.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <form class="form-register" method="post" name="myform" onsubmit="return validate();" action="index.jsp">
        <div class="form-register-with-email">
            <div class="form-white-background">
                <div class="form-title-row">
                    <h1>Login</h1>
                </div>
                <p style="color:red">
                    <% if (request.getAttribute("errorMsg") != null) 
                    { 
                        out.println(request.getAttribute("errorMsg")); 
                    } %>
                </p>
                <br>
                <div class="form-row">
                    <label>
                        <span>Email</span>
                        <input type="text" name="txt_email" id="email" placeholder="enter email">
                    </label>
                </div>
                <div class="form-row">
                    <label>
                        <span>Password</span>
                        <input type="password" name="txt_password" id="password" placeholder="enter password">
                    </label>
                </div>
                <input type="submit" name="btn_login" value="Login">
            </div>
            <a href="register.jsp" class="form-log-in-with-existing">You Don't have an account? <b>Register here</b></a>
        </div>
        <script>
            function validate() 
            {
                var email = document.myform.txt_email;
                var password = document.myform.txt_password;
                if (email.value == null || email.value === "") 
                {
                    window.alert("Please enter email");
                    email.focus();
                    return false;
                }
                if (password.value == null || password.value === "") 
                {
                    window.alert("Please enter password");
                    password.focus();
                    return false;
                }
            }
        </script>
    </form>
    <%@ page import="java.sql.*" %>
    <%
    if (session.getAttribute("login") != null) 
    {
        response.sendRedirect("home.jsp");
    }
    %>
    <%
    try {
    	System.setProperty("javax.net.debug", "ssl");
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load driver
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/langtrans", "root", "himavarsha@30");
        if (request.getParameter("btn_login") != null) { // Check login button click event not null
            String dbemail, dbpassword;
            String email, password;
            email = request.getParameter("txt_email"); // txt_email
            password = request.getParameter("txt_password"); // txt_password
            PreparedStatement pstmt = null; // Create statement
            pstmt = con.prepareStatement("SELECT * FROM data WHERE Email = ? AND Password = ?");
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery(); // Execute query
            if (rs.next()) 
            {
                dbemail = rs.getString("Email");
                dbpassword = rs.getString("Password");
                if (email.equals(dbemail) && password.equals(dbpassword)) 
                {
                    session.setAttribute("login", dbemail); // Set session attribute for logged-in user
                    response.sendRedirect("home.jsp"); // After login success, redirect to hello.jsp page
                } 
                else 
                {
                    request.setAttribute("errorMsg", "Invalid email or password");
                }
            } 
            else 
            {
                request.setAttribute("errorMsg", "Invalid email or password");
            }
        }
        con.close();
    } 
    catch(SQLException se)
    {
    	System.out.println(se);
    }
    catch (Exception e) 
    {
        e.printStackTrace();
    }
    %>
</body>
</html>