.. _release-notes:

#########
Изменения
#########
.. 1.3.6:

1.3.6:
=======

* добавлена возможность настройки размера 64/128bit trace_id для Zipkin

.. 1.3.5:

1.3.5:
=======

* добавлена поддержка python3.10
* обновлена библиотека aiojobs

.. 1.3.2:

1.3.2:
=======

* добавлен параметр statement_cache_size для asyncpg.Connection


.. 1.3.1:

1.3.1:
=======

* исправлена утечка памяти в taskmanager


.. 1.3.0:

1.3.0:
=======

* добавлен новый протокол - restrpc: http сервер и клиент,
  генерация OpenApi (swagger, redoc)
* обновлён Pydantic на 1.8 (есть несовместимости)


.. 1.2.1:

1.2.1:
=======

* обновлены зависимости


.. 1.1.1:

1.1.1:
=======

* обновлены зависимости


.. 1.1.0:

1.1.0:
=======

* добавлена возможноть передавать заголовки и куки ответа в json-rpc http сервере
* обновлены зависимости


.. 1.0.1:

1.0.1:
=======

* Исправлена ошибка в библиотеке pika в python версии от 3.8.
* в библиотеку добавлен декоратор shield
* исправлен механизм остановки приложения

.. 1.0.0:

1.0.0:
=======

* удален iprpc из зависимостей
* испрален healthcheck для redis lock
* отображение конфига в jsonschema

.. 1.0.0:

0.7.0:
=======

* удален плагин для qase

.. 0.6.4:

0.6.4:
=======

* мелкие правки и обновление пакетов

.. 0.6.3:

0.6.3:
=======

* исправлена утечка памяти в task manager
* исправлена трассировка в sftp клиента


.. 0.6.2:

0.6.2:
=======

* исправлена трассировка в TaskManager

.. 0.6.1:

0.6.1:
=======

* исправлена передача trace_id в задачи TaskManager. Добавлены тесты на совместимость с предыдущими версиями

.. 0.6.0:

0.6.0:
=======

* добавлена передача trace_id в задачи TaskManager. Для включения опции нужно добавить новые колонки в схему БД и в метод schedule передавать аргумент propagate_trace=True
* в декоратор @task у Task Manager добавлена возможность передачи информации о максимальном количестве повторов и интервале между ними. Передача этих параметров в функцию schedule сохраняется и переопределяет значения в декораторе
* добавлен компонент для распределенных блокировок с помощью redis или postgresql. также есть поддержка блокировок на уровне экземпляра приложения(работает по-умолчанию, если не передана строка подключения к БД)

.. 0.5.2:

0.5.2:
=======

* исправлено предупреждение о deprecated функции в Db TaskManager

.. 0.5.1:

0.5.1:
=======

* нет изменений

.. 0.5.0:

0.5.0:
=======

* Добавлена поддержка Python 3.9
* Сборка перенесана на GitHub Actions


.. 0.4.1:

0.4.1:
=======

* в зависимости добавлен потерянный jsonschema


.. 0.4.0:

0.4.0:
=======

* добавлена возможность в rpc в качестве объекта api передавать список функций(помеченных декоратором @method)
* добавлена возможность регистрировать задачи в Db Tasl Manager в качестве списка задач(функции с декоратором @task)


.. 0.3.3:

0.3.3:
=======

* в случае ошибки во время выполнения метода json-rpc, если ошибка не является потомком JsonRpcError (т.е. нет атрибута jsonrpc_error_code), она будет залогирована в logging.exception


.. 0.3.2:

0.3.2:
=======

* исправлена ошибка при старте Db Task Manager, если его таблицы не в схеме main, т.к. она была захардкожена


.. 0.3.1:

0.3.1:
=======

* правки по сборке... ничего особенного


.. 0.3.0:

0.3.0:
=======

* Crontab для DB task manager
* DB task manager теперь может сам создавать объекты в БД, если ему передать соответстующий конфигупрационный параметр (APP_TM_CREATE_DATABASE_OBJECTS=1)
* DB Logger теперь пытается сам создавать объекты в БД, если они не существуют. Чтоб отключить данное поведение нужно передать конфигурационный параметр (APP_LOG_REQUESTS_CREATE_DATABASE_OBJECTS=0)
* Декоратор @ipapp.rpc.method для DB task manager устарел. Вместо него следует использовать @ipapp.task.db.task

.. 0.2.5:

0.2.5:
=======

* версии большинства зависимых библиотек зафиксированы по мажорной версии

.. 0.2.4:

0.2.4:
=======

* исправлен openrpc discover

.. 0.2.3:

0.2.3:
=======

* cтруктура параметров в openrpc по-умолчанию теперь по именам

.. 0.2.2:

0.2.2:
=======

* исправлен openrpc discover
* правки компонента s3

.. 0.2.1:

0.2.1:
=======

* добалены s3 методы: copy_object, delete_object, list_objects
* cтруктура параметров в openrpc по-умолчанию теперь по именам
* исправлено имя адаптера sentry

.. 0.2.0:

0.2.0:
=======

* добавлена поддержка FastAPI
* обновлены библиотеки
* в s3/boto добавлен метод file_exists
* исправлен jsonrpcclient
* !!! могут быть неполадки с openapi


.. 0.1.5:

0.1.5:
=======

* добавлена возможность указания модели даннных для ответа json-rpc клиента


.. 0.1.4:

0.1.4:
=======

* Исправлена работа с S3 (теперь get_object загружает весь оюъект)
*
* JSON-RPC поверх AMQP
* taskmanager больше не зависит от iprpc
* Значение по-улолчанию для CORS в JSON-RPC HTTP сервере теперь https://playground.open-rpc.org
* добавлены методы app.shutdown() app.restart() для остановки и перезапуска приложения соответственно

.. 0.1.3:

0.1.3:
=======

* Поддержка CORS в JSON-RPC HTTP сервере
* добавлен потерянный tinyrpc в requirements.txt

.. 0.1.2:

0.1.2:
=======

* json rpc 2.0: мелкие правки и улучшения

.. 0.1.1:

0.1.1:
=======

* json rpc 2.0: http сервер и клинет, openrpc discover
* jaeger в qase
* sftp client

.. 0.1.0:

0.1.0:
=======

* релиз на pypi

.. 0.0.32:

0.0.32:
=======

* автоматическое формирование документации по конфигурации приложения для sphinx
* исправлена ошибка в DB task manager

.. 0.0.31:

0.0.31:
=======

* исправлена ошибка в DB task manager
* обновлены зависимости


.. 0.0.30:

0.0.30:
=======

* исправлен app контекст в RpcClient (создавало ошибки при тестировании)
* исправлено название и форматирование аннотаций postgres спанов
* добавлена поддержка qase

.. 0.0.29:

0.0.29:
=======

* исправлены ошибки генерации openapi

.. 0.0.28:

0.0.28:
=======

* openapi, swagger and redoc

.. 0.0.27:

0.0.27:
=======

* поддержка s3
* отображение конфига в переменных окружения(не стабильно)
* обновлен iprpc до 0.1.3

.. 0.0.26:

0.0.26:
=======

* исправлен fetch для oracle
* обновлены sentry-sdk idna mock Sphinx tox watchdog

.. 0.0.25:

0.0.25:
=======

* healthcheck для oracle

.. 0.0.24:

0.0.24:
=======

* добавлена поддержка oracle database
* обновлен iprpc

.. 0.0.23:

0.0.23:
=======

* логирование трассировки ошибок при обратотке rpc вызовов

.. 0.0.22:

0.0.22:
=======

* улучшен autoreload

.. 0.0.21:

0.0.21:
=======

* обновлены зависимости

.. 0.0.20:

0.0.20:
=======

* автоматический перезапуск сервиса при изменениях в директории проекта
* исправлена функция json_encode, добавлена возможноть ее переопределения в компонетах
* правка http сервера со статикой

.. 0.0.19:

0.0.19:
=======

* ВАЖНО! ТРЕБУЕТСЯ МИГРАЦИЯ БД НА НОВУЮ СХЕМУ ТАБЛИЦЫ
* переработано логирование запросов в БД.
* логирование параметров sql запросов
* новый стил именования span-ов (имена запросов будут в имени span-а)

.. 0.0.18:

0.0.18:
=======

* передача версии приложения и времени сборки при старте через cli


.. 0.0.17:

0.0.17:
=======

* логировать или нет http запрос/ответ теперь настраивается в конфигурации компонента, а не свойствами span-а
* логирование amqp в RequestsAdapter


.. 0.0.16:

0.0.16:
=======

* вместо декоратора @wrap2span теперь используется контекстный менеджер с явной передачей в него ссылки на объект Application. Данное изменение для большей гибкости автотестов
* возможность обработать span перед его отправкой в адаптер(например для наложения маски на данные)
* осправления в трассировке db taskmanager


.. 0.0.15:

0.0.15:
=======

* Обновлен iprpc
* Документация
* Больше квантили для метрик prometheus по умолчанию
* для http-rpc сервера исправлен ответ в случае ошибки
* исправлен db taskmanager


.. 0.0.14:

0.0.14:
=======

* Переподключение к БД в случае потери соединения в RequestsAdapter и Taskanager
* Исправлено: для http сервера не логировались ошибки


.. 0.0.13:

0.0.13:
=======

* в pg добавлен executemany.


.. 0.0.12:

0.0.12:
=======

* исправлена ошибка если query_one вернул None
* трассировка для amqp rpc теперь выгрядит как и для http rpc. Т.е. один span для вызова клиента и один span для сервера.


.. 0.0.11:

0.0.11:
=======

* вывод ошибки amqp rpc в stderr
* больше сервис не будет зависать, если канал AMQP закрылся
* логирование amqp сообщений(включается в конфиге)


.. 0.0.10:

0.0.10:
=======

* логирование SQL запроса и результата его выполнения(управляется через конфигурацию)

.. 0.0.9:

0.0.9:
=======

* Application переименован в BaseApplication
* конструктор(def __init__) BaseApplication теперь обязательно должен принимать объект конфигурации первым аргументом
* добавлен cli скрип для запуска сервиса с разбором аргументов командной строки
* все сервера по-умолчанию слушают 0.0.0.0 вместо 127.0.0.1
* добавлен компонент для отложенного гарантированного выполнения задач c повторами
* исправления ошибок


.. 0.0.8:

0.0.8:
======

* MVP
