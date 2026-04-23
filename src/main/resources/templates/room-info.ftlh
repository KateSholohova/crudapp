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
            color: #e59b9b;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 1.5em;
            margin-top: 20px;
        }
        b {
            color: #3f3c3c;
            font-weight: bold;
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
<h4>More about room</h4>
<b>Number of room: </b>${room.numberOfRoom}<br>
<b>Condition of room: </b>${room.conditions}<br>
<b>Price of room: </b>${room.price}<br>
<b>Type of room: </b>${room.type}<br>
<b>Free of room: </b>${room.numberOfAvailableSeats}<br>
<b>Жильцы:</b><br>
<#list users as user>
    <div>
        <p><b>${user.FIO}</b></p>
    </div>
<#else>
    <h3>Жителей нет</h3>
</#list>
</body>
</html>