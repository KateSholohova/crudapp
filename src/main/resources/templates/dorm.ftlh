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

        }

        h1 {
            color: #e374cb;
            text-align: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 3em;
            margin-top: 20px;
        }

        .logout-button {
            background-color: #ff3333;
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

        .login-button {
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
    <button class="onMainScreen-button">В личный кабинет</button>
</form>
    <div style="display: flex; margin: 0 40px;">
        <div style="flex: 1;">
            <p><strong>Общежитие № 3</strong></p>

            <p>Адрес: Санкт-Петербург, пр. Косыгина, д. 19/2</p>

            <p>м. Ладожская</p>

            <ul>
                <li>В общежитии 966 мест</li>
                <li>Блочный тип проживания, размещение по 2-3 человека в комнате</li>
                <li>12 этажей</li>
                <li>Кухня оснащена электрическими плитами и столами</li>
                <li>Прачечная</li>
                <li>Интернет</li>
                <li>5-10 минут от метро на транспорте</li>
            </ul>

            <p>От м. Ладожская<br>Маршрутное такси: № 22, 187, 401, 531, 533<br>Автобус: № 21, 24, 30, 429, 453, 462, 531, 532<br>Троллейбус: № 1, 22<br>Трамвай: любой<br>Остановка: ТК «Народный»</p>

            <p>Тел.: (812) 521-00-32<br>Заведующий общежитием: Васильев Александр Владимирович</p>

            <p>Тел.: (812) 521-00-33<br>Зам. зав. общежитием: Левашова Людмила Григорьевна</p>
        </div>
        <div style="flex: 1; margin-left: 40px;">
            <img src="https://photos.wikimapia.org/p/00/07/36/53/29_big.jpg" alt="Описание картинки" style="max-width: 100%; height: auto;">
        </div>
    </div>
</body>
</html>