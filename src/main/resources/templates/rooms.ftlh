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
            color: #e776ce;
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

        .username {
            position: absolute;
            top: 10px;
            left: 10px;
            color: #3f3c3c;
        }

        .form-container {
            display: flex;
            justify-content: center;
        }

        .square {
            width: 200px;
            height: 200px;
            background-color: #e891d6;
            margin: 20px;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: inline-block;
            text-align: center;
        }

    </style>
</head>
<body>
<a href="/dorm" style="text-decoration: none"><h1>DORM</h1></a>
<hr>
<#if user.email??>
    <div class="username">
        <h3 style="color: #e374cb;">Имя пользователя: <i>${user.FIO}</i></h3>
    </div>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button class="logout-button">Выйти</button>
    </form>
    <#if user.isAdmin()>
        <div class="form-container">
            <div class="square">
                <a href="/admin" style="color: #3f3c3c;">Список проживающих</a>
            </div>
            <div class="square">
                <a href="/allResettlement" style="color: #3f3c3c;">Список заявок</a>
            </div>
            <div class="square">
                <a href="/allRooms" style="color: #3f3c3c;">Список комнат</a>
            </div>
        </div>
    </#if>
    <#if user.isUserr()>
        <#if user.room.numberOfAvailableSeats <= 3>
            <#list user.room.users as neighbour>
                <#if neighbour.applicationForResettlement?? && !neighbour.equals(user)>
                    <p>Ваш сосед ${neighbour.FIO} хочет переселиться</p>
                </#if>
            </#list>
        </#if>
        <#if user.answerForResettlement??>
            <#if !user.answerForResettlement.isAnswered()>
                <h3 style="color: #8dcc6d;">К вам хотят переселиться</h3>
                <p style="color: #e374cb;">${user.answerForResettlement.whoWant}
                <hr></p>
                <h3 style="color: #e374cb;">Описание</h3>
                <p style="color: #3f3c3c;">${user.answerForResettlement.description}
                <hr></p>
                <h3 style="color: #8dcc6d;">А хотите ли вы?</h3>
                <form action="/answer/create" method="post">
                    Хотите ли вы чтобы к вам подселились?:
                    <select name="ifAgree">
                        <option value="false">нет</option>
                        <option value="true">да</option>
                    </select>
                    Если нет, то почему: <input type="text" name="reason"/><br><br>
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Создать"/>
                </form>
            </#if>
        </#if>
        <#if user.applicationForResettlement??>
            <h3 style="color: #624141;">Ваша заявка: </h3>
            <p style="color: #8dcc6d;">Статус: ${user.applicationForResettlement.status}<br><br></p>
            <table border="1">
                <tr>
                    <th>Мнение тех, к кому вы хотите переселиться?</th>
                </tr>
                <#list user.applicationForResettlement.answers as answer>
                    <tr>
                        <#if answer.isAnswered()>
                            <#if answer.ifAgree>
                                <th style="color: #3e623b;">да</th>
                            <#else>
                                <th style="color: #810f0f;">нет</th>
                            </#if>
                        </#if>
                    </tr>
                <#else>
                    <h3 style="color: #fc1212;">Ещё не ответили</h3>
                </#list>
            </table>
        <#else>
            <div class="form-container">
                <div class="square">
                    <a href="/freeRooms" style="color: #3f3c3c;">Куда можно переселиться</a>
                </div>
            </div>
        </#if>
        <div class="form-container">
            <#--            <div class="square">-->
            <#--                <a href="/repair" style="color: #3f3c3c;">Создать заявку на ремонт</a>-->
            <#--            </div>-->
            <div class="square">
                <a href="/repair/users" style="color: #3f3c3c;">Ваши заявки на ремонт</a>
            </div>
        </div>
    </#if>
    <#if user.isWorker()>
        <#if repairs??>
            <table border="1">
                <tr>
                    <th>Номер комнаты</th>
                    <th>Что не так</th>
                    <th>ФИО заказавшего</th>
                    <th>Действия</th>
                    <th>Статус</th>
                    <th>Принято со стороны студента?</th>
                </tr>
                <#list repairs as repair>
                    <#if repair.specialization.equals(user.specialization)>
                        <tr>
                            <th>${repair.numberOfRoomForResettlement}</th>
                            <th>${repair.description}</th>
                            <th>${repair.FIO}</th>
                            <th>
                                <#if repair.getStatus().name() == "NEW">
                                    <form action="/changeToAccepted/${repair.id}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <input type="submit" value="Принять в работу">
                                    </form>
                                </#if>
                                <#if repair.getStatus().name() == "ACCEPT_IN_WORK" && !repair.workerDone>
                                    <form action="/applyRepairWorker/${repair.id}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <input type="submit" value="Выполнено">
                                    </form>
                                </#if>
                                <#if repair.getStatus().name() == "ACCEPT_IN_WORK" && repair.workerDone>
                                    Заявка выполнена
                                </#if>
                            </th>
                            <th>
                                <#if repair.getStatus().name() == "NEW">
                                    Новая
                                </#if>
                                <#if repair.getStatus().name() == "ACCEPT_IN_WORK" && !repair.workerDone>
                                    Принята в работу
                                </#if>
                                <#if repair.getStatus().name() == "ACCEPT_IN_WORK" && repair.workerDone>
                                    Выполнена
                                </#if>
                            </th>
                            <th>
                                <#if repair.userDone>
                                    да
                                <#else>
                                    нет
                                </#if>
                            </th>
                        </tr>
                    </#if>
                <#else>
                    <h3 style="color: #fc1212;">Заявок нет</h3>
                </#list>
            </table>
        </#if>
    </#if>
<#else>
    <form action="/login" method="get">
        <button class="login-button">Войти</button>
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

            <p>От м. Ладожская<br>Маршрутное такси: № 22, 187, 401, 531, 533<br>Автобус: № 21, 24, 30, 429, 453, 462,
                531, 532<br>Троллейбус: № 1, 22<br>Трамвай: любой<br>Остановка: ТК «Народный»</p>

            <p>Тел.: (812) 521-00-32<br>Заведующий общежитием: Васильев Александр Владимирович</p>

            <p>Тел.: (812) 521-00-33<br>Зам. зав. общежитием: Левашова Людмила Григорьевна</p>
        </div>
        <div style="flex: 1; margin-left: 40px;">
            <img src="https://photos.wikimapia.org/p/00/07/36/53/29_big.jpg" alt="Описание картинки"
                 style="max-width: 100%; height: auto;">
        </div>
    </div>





</#if>
</body>
</html>