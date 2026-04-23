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
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1 {
            color: #e891d6;
            text-align: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 3em;
            margin-top: 20px;
        }
        hr {
            border: none;
            border-top: 2px solid #3f3c3c;
            width: 80%;
            margin-top: 20px;
        }
        h4 {
            color: #8dcc6d;
            text-align: center;
            font-size: 1.5em;
            margin-top: 20px;
        }
        form {
            width: 40%;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        input[type="text"], input[type="submit"], select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #3f3c3c;
        }
        select {
            width: 20%;
        }
        input[type="submit"] {
            width: 20%; /* Уменьшено до 40% */
            background-color: #3f3c3c;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #2e2b2b;
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
<h4>Создать заявку</h4>
<form action="/repair/create" method="post">
    Описание: <textarea name="description" rows="4"></textarea><br><br>
    Специализация:
    <select name="specialization">
        <option value="Carpenter">Плотник</option>
        <option value="Electrician">Электрик</option>
        <option value="Plumber">Сантехник</option>
    </select><br><br>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Создать"/>
</form>
</body>
</html>