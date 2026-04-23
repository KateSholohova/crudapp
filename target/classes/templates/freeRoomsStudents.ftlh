<!DOCTYPE html>
<html>
<head>
    <title>DORM</title>
    <style>
        body {
            background-color: #f1eded;
            color: #545454;
            font-family: Arial, sans-serif;
            margin: 0;
            height: 100vh;
        }
        h1 {
            color: #e374cb;
            text-align: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 3em;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        hr {
            border: none;
            border-top: 2px solid #3f3c3c;
            width: 80%;
            margin-top: 20px;
        }
        h4 {
            color: #e59b9b;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 1.5em;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        div {
            margin-top: 10px;
        }
        p {
            margin: 5px 0;
        }
        h3 {
            color: #3f3c3c;
        }
        .onMainScreen-button {
            background-color: #33cc33;
            color: #3f3c3c;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px;
            cursor: pointer;
            position: absolute;
            top: 10px;
            right: 10px;
        }
    </style>
</head>
<body>
<h1>DORM</h1>
<hr>
<form action="/onMainScreen" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <button class="onMainScreen-button">На главный экран</button>
</form>
<h4>Жители в комнате</h4>
<#list users as user>
    <div>
        <p><b>${user.FIO}: ${user.description}</b></p>
    </div>
<#else>
    <h3>Жителей нет</h3>
</#list>
</body>
</html>