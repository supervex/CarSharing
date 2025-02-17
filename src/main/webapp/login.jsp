<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Utente" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .login-container h2 {
            text-align: center;
        }
        .login-container input, .login-container button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .login-container button {
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }
        .login-container button:hover {
            background-color: #218838;
        }
        .error {
            color: red;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <% Utente utenteLoggato = (Utente) session.getAttribute("user");
           if (utenteLoggato != null) { %>
            <p class="text-center">Benvenuto, <%= utenteLoggato.getNome() %>!</p>
            <form action="UtenteController" method="post">
                <input type="hidden" name="tipoOperazione" value="logout">
                <button type="submit">Logout</button>
            </form>
        <% } else { %>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <p class="error"><%= errorMessage %></p>
            <% } %>
            <form action="UtenteController" method="post">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <input type="hidden" name="tipoOperazione" value="login">
                <button type="submit">Accedi</button>
            </form>
        <% } %>
    </div>
</body>
</html>