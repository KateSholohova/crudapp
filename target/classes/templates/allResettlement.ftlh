<!DOCTYPE html>
<html>
<head>
    <title>DORM</title>
    <style>
        body {
            background-color: #f1eded;
            color: #3f3c3c;
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
        .button {
            background-color: #e59b9b;
            color: #3f3c3c;
            border: none;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            font-size: 14px;
            margin: 5px;
            cursor: pointer;
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
<h4>Заявки на переселение</h4>
<table>
    <tr>
        <th>Студент</th>
        <th>Комната для переселения</th>
        <th>Причина</th>
        <th>Согласны ли проживающие</th>
        <th>Отказать</th>
        <th>Принять</th>
    </tr>
    <#list users as user>
        <#if user.applicationForResettlement??>
            <tr>
                <td>${user.FIO}</td>
                <td>${user.applicationForResettlement.numberOfRoomForResettlement}</td>
                <td>${user.applicationForResettlement.reason}</td>
                <td>
                    <#list user.applicationForResettlement.answers as answer>
                        <#if answer.isAnswered()>
                            <#if answer.ifAgree>
                                согласен<br>
                            <#else>
                                не согласен (${answer.reason})<br>
                            </#if>
                        </#if>
                    </#list>
                </td>
                <td>
                    <form action="/allResettlement/${user.id}/${user.applicationForResettlement.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Отказать" class="button">
                    </form>
                </td>
                <td>
                    <form action="/allResettlement/accept/${user.id}/${user.applicationForResettlement.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Принять" class="button">
                    </form>
                </td>
            </tr>
        </#if>
    </#list>
</table>
</body>
</html>