# Vault-to-Lockbox Migrator

Скрипт предназначен для миграции секретов из HashiCorp Vault в сервис [Yandex Cloud Lockbox](https://cloud.yandex.ru/services/lockbox).

Подробнее о сервисе Lockbox можно узнать в [статье](https://cloud.yandex.ru/blog/posts/2023/04/lockbox-ga).

### Что можно сделать с помощью скрипта
 - Проверить успешность подключения к Vault, выведя список хранящихся там секретов в консоль.
 - Выгрузить секреты из Vault в JSON файл. Файл можно отредактировать в любом редакторе, например если вы не хотите импортировать всё что было в Vault.
 - Загрузить секреты из JSON файла в Lockbox. 
 - Удалить все секреты из Lockbox с помощью консольной команды.

### Начало работы
1. Установите Python версии 3.8 или выше.
2. Для работы скрипта в одной папке должны находиться файлы:
- `vault_to_lockbox_migrator.py` — сам скрипт миграции
- `requirements.txt` — список модулей, необходимых для корректной работы скрипта
- `.env` — параметры конфигурации скрипта

4. Установите модули, выполнив в консоли команду:

`pip install -r requirements.txt`

4. Заполните файл `.env` на основе таблицы с параметрами, приведенной ниже. 
5. Запустите скрипт в консоли с помощью команды:

 `python vault_to_lockbox_migrator.py`
 
6. Для импорта секретов из Vault и переноса их в Lockbox, используйте параметры из таблицы приведенной ниже.

### Ограничения
Секреты должны находиться в KV Version 2 Secrets Engine.

### Параметры для конфигурации скрипта

_Вместо использования файла .env, можно передать в скрипт эти параметры через переменные среды._

| Параметр         | Значение по умолчанию | Описание                                                         | Пример значения                        |
|------------------|:----------------------|:-----------------------------------------------------------------|----------------------------------------|
| VAULT_TOKEN      |                       | Токен с правами доступа к значением секретов в Vault             | "00000000-0000-0000-0000-000000000000" |
| VAULT_URL        |                       | Адрес сервера Vault                                              | "https://localhost:8201"               |
| VAULT_ROOT_PATH  |                       | Корневой путь в хранилище секретов Vault                              | "secret"                               |
| VAULT_KV_VERSION | 2                     | Версия KV хранилища                                              | 2                                      |
| VAULT_VERIFY_SSL | False                 | Отключить проверку сертификата при запросе API Vault             | False                                  |
| YC_TOKEN         |                       | Токен Yandex Cloud с правами создания секретов в сервисе Lockbox | "t1.9euxxx"                            |
| YANDEX_FOLDER_ID |                       | Имя папки в Yandex Cloud, где будут создаваться секреты          | "f9sdf9e"                              |
| OUT_FILE         | "secrets.json"        | Имя файла для выгрузки секретов из Vault                         | "secrets.json"                          |
| INPUT_FILE       | "secrets.json"        | Имя файла для загрузки секретов в Lockbox                        | "secrets.json"                                     |


### Доступные параметры командной строки

| Параметр                       | Описание                                                                                                                      |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| -h или --help                  | Вызов справки                                                                                                                 |
| -l или --list                  | Вывод секретов Vault на экран                                                                                                 |
| -o или --outFile [filename]    | Вывод секретов Vault в файл (если не указывать имя файла, то его имя будет загружено из переменной среды OUT_FILE)            |
| -m или --migrate               | Перенос всех секретов из Vault в Lockbox                                                                                      |
| -c или --createFrom [filename] | Создание секретов в Lockbox из файла (если не указывать имя файла, то его имя будет загружено из переменной среды INPUT_FILE) |
| -d или --deleteAll             | Удаление всех секретов в Lockbox                                                                                              |
