Для запуска проекта необходимы:
    docker
    docker-compose
    ruby 1.5.1
После установки зависимостей в корне каталога выполняются поочередно команды:
1. bundle
2. docker-compose up -d 
3. bundle exec rake setup_base

Для конфигурации парсера используется файл config.yml, в каждом значении которого содержится массив ключей для доступа к значению файла xml
Пример настроен для файла fcsNotification.xml

Для запуска парсера используется команда:
bundle exec rake parse_and_store_file[fcsNotification.xml,config.yml]