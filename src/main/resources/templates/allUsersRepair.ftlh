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

        table {
            width: 80%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #3f3c3c;
            text-align: left;
        }

        th {
            background-color: #3f3c3c;
            color: #fff;
        }

        form {
            display: inline;
        }

        input[type="submit"] {
            background-color: #3f3c3c;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
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
<h4>Заявки на ремонт</h4>
Создать заявку
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
<table border="1">
    <tr>
        <th>Описание</th>
        <th>Специализация</th>
        <th>Принять работу?</th>
<#--        <th>Выполнена со стороны рабочего?</th>-->
        <th>Статус</th>
        <th>Удалить заявку</th>
    </tr>
    <#list user.applicationForRepair as repair>
        <tr>
            <td>${repair.description}</td>
            <td>
                <#if repair.getSpecialization().name() == "Electrician">
                    Электрик
                </#if>
                <#if repair.getSpecialization().name() == "Plumber">
                    Сантехник
                </#if>
                <#if repair.getSpecialization().name() == "Carpenter">
                    Плотник
                </#if>
            </td>
            <td>
                <#if repair.workerDone>
                <#if !repair.userDone>
                    <form action="/repair/users/${repair.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Принято">
                    </form>
                <#else>
                    Вы приняли заявку
                </#if>
                <#else>
                    Дождитесь пока работник, выполнит заявку
                </#if>
            </td>
<#--            <td>-->
<#--                <#if repair.workerDone>-->
<#--                    да-->
<#--                <#else>-->
<#--                    нет-->
<#--                </#if>-->
<#--            </td>-->
            <td>
                <#if repair.getStatus().name() == "NEW">
                    Новая
                </#if>
                <#if repair.getStatus().name() == "ACCEPT_IN_WORK" && !repair.workerDone>
                    Принята в работу
                </#if>
                <#if repair.getStatus().name() == "ACCEPT_IN_WORK" && repair.workerDone>
                    Выполнена
                </#if>
            </td>
            <td>
                <form action="/repair/delete/${repair.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Удалить">
                </form>
            </td>

        </tr>
    <#else>
        <tr>
            <td colspan="3">Заявок нет</td>
        </tr>

    </#list>
</table>
</body>
</html>