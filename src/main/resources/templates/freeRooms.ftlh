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
            border-top: 2px solid #8dcc6d;
            width: 80%;
            margin-top: 20px;
        }
        table {
            border-collapse: collapse;
            width: 80%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #3f3c3c;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #3f3c3c;
            color: #fff;
        }
        a {
            text-decoration: none;
            color: #3f3c3c;
            font-weight: bold;
        }
        a:hover {
            color: #2e2b2b;
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
<table>
    <tr>
        <th>Номер</th>
        <th>Состояние</th>
        <th>Цена</th>
        <th>Количество свободных мест</th>
        <th>Подробнее</th>
        <th>Подать заявку</th>
    </tr>
    <#list rooms as room>
        <#if room.numberOfAvailableSeats != 0 && room.type.equals(user.sex) && user.room.hashCode() != room.hashCode()>
            <tr>
                <td>${room.numberOfRoom}</td>
                <td>${room.conditions}</td>
                <td>${room.price}</td>
                <td>${room.numberOfAvailableSeats}</td>
                <td>
                    <a href="/freeRooms/${room.id}">Студенты</a>
                </td>
                <td>
                    <a href="/resettlement">Подать заявку</a>
                </td>
            </tr>
        </#if>
    <#else>
        <tr>
            <td colspan="6"><h3>Свободных комнат нет</h3></td>
        </tr>
    </#list>
</table>
</body>
</html>