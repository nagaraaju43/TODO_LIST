<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .login-container {
        width: 30%;
        padding: 30px;
        background-color: white;
        box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        animation: slideIn 0.5s ease-in-out;
    }
    @keyframes slideIn {
        from {
            transform: translateY(-50px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
    table {
        width: 100%;
    }
    th, td {
        padding: 10px;
    }
    input[type="text"], input[type="password"] {
        width: 95%;
        padding: 10px;
        margin: 5px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
        transition: border-color 0.3s ease;
    }
    input[type="text"]:focus, input[type="password"]:focus {
        border-color: #4CAF50;
        outline: none;
    }
    .error-msg {
        color: red;
        background-color: #ffebee;
        font-style: italic;
        padding: 10px;
        text-align: center;
        border-radius: 5px;
        margin-bottom: 20px;
        animation: fadeIn 0.5s ease-in-out;
    }
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }
    .btn-container {
        text-align: center;
    }
    input[type="submit"], input[type="reset"] {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    input[type="submit"] {
        background-color: #4CAF50;
        color: white;
    }
    input[type="reset"] {
        background-color: #f44336;
        color: white;
    }
    input[type="submit"]:hover, input[type="reset"]:hover {
        opacity: 0.9;
    }
    .remember-me {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .links {
        text-align: center;
        margin-top: 20px;
    }
    .links a {
        color: #4CAF50;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    .links a:hover {
        color: #45a049;
    }
</style>
<script>
    function validateForm() {
        var email = document.loginForm.email.value.trim();
        var pass = document.loginForm.pass.value.trim();
        if (email === "" || pass === "") {
            alert("Both fields are required!");
            return false;
        }
        return true;
    }
</script>
</head>
<body>

  <div class="login-container">
  
    <center>
      <p class="error-msg">
        <% Object error = request.getAttribute("loginError"); %>
        <%=(error == null) ? "" : error.toString()%>
      </p>
    </center>
    
    <form name="loginForm" method="post" action="./LoginServlet" onsubmit="return validateForm()">
      <table align="center" border="0">
        <tr>
          <th>Email</th>
          <td><input type="text" name="email" placeholder="Enter your email"></td>
        </tr>
        <tr>
          <th>Password</th>
          <td><input type="password" name="pass" placeholder="Enter your password"></td>
        </tr>
        <tr>
          <td colspan="2" class="remember-me">
            <input type="checkbox" name="rememberMe"> Remember Me
          </td>
        </tr>
        <tr>
          <td colspan="2" class="btn-container">
            <input type="submit" name="submit" value="Login">
            <input type="reset" name="reset" value="Clear">
          </td>
        </tr>
      </table>
    </form>

    <div class="links">
      <p>New User? <a href="Register.html">Sign Up</a></p>  
      <p><a href="forgotPassword.jsp">Forgot Password?</a></p>  
    </div>

  </div>

</body>
</html>