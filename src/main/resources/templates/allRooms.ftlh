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
        a {
            background-color: #e59b9b;
            color: #3f3c3c;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            margin-top: 20px;
        }
        a:hover {
            background-color: #ff6666;
        }
        table {
            background-color: #ffffff;
            border-collapse: collapse;
            width: 80%;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #dddddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
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
<a href="/createRoom">Создать комнату</a>
<table>
    <tr>
        <th>Номер</th>
        <th>Состояние</th>
        <th>Цена</th>
        <th>Тип</th>
        <th>Количество свободных мест</th>
        <th>Подробнее</th>
    </tr>
    <#list rooms as room>
        <tr>
            <td>${room.numberOfRoom}</td>
            <td>${room.conditions}</td>
            <td>${room.price}</td>
            <td>${room.type}</td>
            <td>${room.numberOfAvailableSeats}</td>
            <td>
                <a href="/freeRooms/${room.id}">Студенты</a>
            </td>
        </tr>
    </#list>
</table>
</body>
</html>