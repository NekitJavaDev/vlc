# Название:
Автоматизация VLC для ОС Windows

##Автор:
Хмыров Н.А. (nekitjavadev@yandex.ru)

##Функции:
- Запись видео в файл с настраиваемой продолжительностью
- Открытие online потока по HTTP

1. Запись.....


2. Для просмотра online потока за пределами вашей локальной сети:
- Необходим БЕЛЫЙ IP адресс на ПК, где запускаете этот скрипт (купить у провайдера).
- В настройках брандмауера добавить новое правило, в разделе Правила для входящих подключений. Например:
Name: VLC custom stream
Protocol: TCP
Remote port: 55555
Local port: 55555
Input: Internet or Provider (if Router is connected to Provider via wire), or other...
Output: Your server PC with local IP (192.168.1.36 for example), where execute this script
