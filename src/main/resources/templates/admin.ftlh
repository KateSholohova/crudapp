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

        h4 {
            color: #8dcc6d;
            font-size: 1.5em;
            margin-top: 20px;
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

        .popup {
            position: fixed;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            top: 0;
            left: 0;
            opacity: 0;
            visibility: hidden;
        }

        .popup_body {
            min-height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 10px;
        }

        .popup_content {
            background-color: #fff;
            color: #000;
            max-width: 800px;
            padding: 30px;
            position: relative;
        }

        .popup_title {
            font-size: 40px;
            margin: 0px 0px 1em 0px;
        }

        .popup_close {
            position: absolute;
            right: 10px;
            top: 10px;
            font-size: 20px;
            color: #000;
            text-decoration: none;
        }

        .popup:target {
            opacity: 1;
            visibility: visible;
        }

        .popup_text {
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
<h4>Проживающие</h4>
<table>
    <tr>
        <th>Email</th>
        <th>Номер комнаты</th>
        <th>Пол</th>
        <th>ФИО</th>
        <th>Выселить</th>
    </tr>
    <#list users as user>
        <#if !user.isAdmin() && !user.isWorker()>
            <tr>
                <td>${user.email}</td>
                <td>${user.room.numberOfRoom}</td>
                <td>${user.sex}</td>
                <td>${user.FIO}</td>
                <td>
                    <form action="/admin/${user.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Выселить">
                    </form>
                </td>
            </tr>
        </#if>
    </#list>
</table>
<div id="popup" class="popup">
    <div class="popup_body">
        <div class="popup_content">
            <a href="" class="popup_close">X</a>
            <div class="popup_title">Предупреждение</div>
            <div class="popup_text">
                <p>У этого студента есть заявка на переселение, вы точно хотите его выселить?</p>
                <p>
                    wergt
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>