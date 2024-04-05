<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
    <link rel="stylesheet" href="registerstyle.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <form class="form-register" method="post" name="myform" onsubmit="return validate();" action="register.jsp">
        <div class="form-register-with-email">
            <div class="form-white-background">
                <div class="form-title-row">
                    <h1>Register</h1>
                </div>
                <p style="color:green">
                    <% if (request.getAttribute("successMsg") != null) 
                    {
                        out.println(request.getAttribute("successMsg")); 
                    } %>
                </p>
                <br>
                <div class="form-row">
                    <label>
                        <span>First Name</span>
                        <input type="text" name="txt_firstname" id="fname" placeholder="enter firstname">
                    </label>
                </div>
                <div class="form-row">
                    <label>
                        <span>Last Name</span>
                        <input type="text" name="txt_lastname" id="lname" placeholder="enter lastname">
                    </label>
                </div>
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
                <input type="submit" name="btn_register" value="Register">
            </div>
            <a href="index.jsp" class="form-log-in-with-existing">Already have an account?<b>Login here</b></a>
        </div>
        <script> 
    function validate() 
    {
        var first_name = /^[a-zA-Z]+$/; //pattern allowed alphabet a-z or A-Z
        var last_name = /^[a-zA-Z]+$/; //pattern allowed alphabet a-z or A-Z
        var email_valid = /^[\w\d\.]+\@[a-zA-Z\.]+\. [A-Za-z]{1,4}$/; //pattern validation for email
        var password_valid = /^[A-Za-z_@-9!@#$%&*()<>]{6,12}$/; //pattern validation for password
        var fname = document.getElementById("fname"); //textbox id fname
        var lname = document.getElementById("lname"); //textbox id lname
        var email = document.getElementById("email"); //textbox id email
        var password = document.getElementById("password");

        if (!first_name.test(fname.value) || fname.value === '')
        {
            alert("Enter Firstname Alphabet Only....!");
            fname.focus();
            return false;
        }

        if (!last_name.test(lname.value) || lname.value === '')
        {
            alert("Enter Lastname Alphabet Only....!");
            lname.focus();
            return false;
        }

        if (email.value == null || email.value === '')
        {
            alert("Please enter email");
            email.focus();
            return false;
        }

        if (!email_valid.test(email.value) || email.value === '')
        {
            alert("Enter Valid Email....!");
            email.focus();
            return false;
        }

        if (password.value == null || password.value === '')
        {
            alert("Please enter password");
            password.focus();
            return false;
        }

        if (!password_valid.test(password.value) || password.value === '')
        {
            alert("Password Must Be 6 to 12 and allowed !@$%&*()<> characters");
            password.focus();
            return false;
        }

        return true;
    }
</script>

    </form>
    <%@ page import="java.sql.*" %>
    <%
    if (session.getAttribute("login") != null) // Check login session user not access or back to registration
    {
        response.sendRedirect("home.jsp");
    }
    %>
    <%
    try
    {
    	System.setProperty("javax.net.debug", "ssl");

        Class.forName("com.mysql.cj.jdbc.Driver"); // Load driver
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/langtrans", "root", "himavarsha@30");
        if (request.getParameter("btn_register") != null) // Check register button click event not null
        {
            String firstname, lastname, email, password;
            firstname = request.getParameter("txt_firstname"); // txt_firstname
            lastname = request.getParameter("txt_lastname"); // txt_lastname
            email = request.getParameter("txt_email"); // txt_email
            password = request.getParameter("txt_password"); // txt_password
            PreparedStatement pstmt = null; // Create statement
            pstmt = con.prepareStatement("INSERT INTO data (First_name, Last_name, Email, Password) VALUES (?, ?, ?, ?)");
            pstmt.setString(1, firstname);
            pstmt.setString(2, lastname);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.executeUpdate(); // Execute query
            request.setAttribute("successMsg", "Register Successfully...! Please login"); // Set success message
        }
        con.close(); // Close connection
    }
    catch(SQLException se)
    {
    	System.out.println(se);
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    %>
</body>
</html>