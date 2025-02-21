<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Errore</title>
   <style>
       body {
           font-family: Arial, sans-serif;
           background: linear-gradient(135deg, #4B0082, #D8BFD8);
           margin: 0;
           display: flex;
           align-items: center;
           justify-content: center;
           height: 100vh;
       }
       .container {
           background: #fff;
           width: 80%;
           max-width: 600px;
           padding: 30px;
           border-radius: 15px;
           box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
           text-align: center;
           animation: fadeIn 1s ease-out;
       }
       @keyframes fadeIn {
           from { opacity: 0; transform: translateY(-20px); }
           to { opacity: 1; transform: translateY(0); }
       }
       h2 {
           color: #4B0082;
           font-size: 2em;
           margin-bottom: 20px;
       }
       .alert {
           background: #F8F8FF;
           border-left: 5px solid #FF4500;
           padding: 15px;
           border-radius: 5px;
           color: #333;
           font-size: 1.1em;
           margin: 20px 0;
       }
       .btn-container {
           margin-top: 20px;
           display: flex;
           justify-content: center;
           gap: 20px;
       }
       .btn-secondary {
           background: #FF4500;
           color: white;
           border: none;
           padding: 12px 25px;
           border-radius: 5px;
           text-decoration: none;
           font-size: 1em;
           transition: background 0.3s ease, transform 0.3s ease;
       }
       .btn-secondary:hover {
           background: #E63900;
           transform: scale(1.05);
       }
   </style>
</head>
<body>
   <div class="container">
       <h2>&#9888; Ops, qualcosa è andato storto!</h2>
       <% 
           // Recupera il messaggio di errore passato dal servlet
           String errorMessage = (String) request.getAttribute("errorMessage");
           if (errorMessage != null) { 
       %>
           <div class="alert">
               <%= errorMessage %>
           </div>
       <% } else { %>
           <div class="alert">
               Si è verificato un errore sconosciuto. Per favore riprova più tardi.
           </div>
       <% } %>
       <div class="btn-container">
           <a href="HomeController?method=get" class="btn-secondary">Torna alla homepage</a>
           <a href="javascript:history.back()" class="btn-secondary">Torna alla pagina precedente</a>
       </div>
   </div>
</body>
</html>