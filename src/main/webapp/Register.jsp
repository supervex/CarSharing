<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .form-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .form-container h2 {
            text-align: center;
        }
        .form-container input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-container button:hover {
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
ciaooo
    <div class="form-container">
        <h2>Registrazione</h2>
        
        <!-- Messaggio di errore -->
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } %>

        <form action="UtenteController" method="post">
            <input type="text" id="username" name="username" placeholder="Username" required 
       value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
<input type="text" id="nome" name="nome" placeholder="Nome" required 
       value="<%= request.getAttribute("nome") != null ? request.getAttribute("nome") : "" %>">
<input type="text" id="cognome" name="cognome" placeholder="Cognome" required 
       value="<%= request.getAttribute("cognome") != null ? request.getAttribute("cognome") : "" %>">
<input type="date" id="dataNascita" name="dataNascita" required 
       value="<%= request.getAttribute("dataNascita") != null ? request.getAttribute("dataNascita") : "" %>">
<input type="password" id="password" name="password" placeholder="Password" required>
<input type="text" id="citta" name="citta" placeholder="Città" required 
       value="<%= request.getAttribute("citta") != null ? request.getAttribute("citta") : "" %>">
<input type="tel" id="telefono" name="telefono" placeholder="Telefono" required 
       value="<%= request.getAttribute("telefono") != null ? request.getAttribute("telefono") : "" %>">
<input type="email" id="email" name="email" placeholder="Email" required 
       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
<input type="hidden" name="tipoOperazione" value="register">
            
            <button type="submit">Registrati</button>
        </form>
    </div>
</body>
</html>
