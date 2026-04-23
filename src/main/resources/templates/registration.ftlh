<!DOCTYPE html>
<html>
<head>
    <title>DORM</title>
</head>
<body>
<h1>DORM</h1><hr>
<h4>Регистрация</h4>
<form action="/registration" method="post">
    ФИО пользователя: <input type="text" name="FIO"><br><br>
    Эл. почта: <input type="email" name="email"><br><br>
    Пол:
    <select name="sex">
        <option value="M">Мужской</option>
        <option value="F">Женский</option>
    </select>
    Описание: <input type="text" name="description"><br><br>
    Номер комнаты: <input type="text" name="room"><br><br>
    Пароль: <input type="password" name="password"><br><br>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Вход"/>
</form>

</body>
</html>