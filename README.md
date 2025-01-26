# Автоматизация VLC Media player для ОС Windows

## Автор:
- Имя: Хмыров Н.А. 
- Email: nekitjavadev@yandex.ru
- Telegram: https://t.me/NekitJavaDev @NekitJavaDev

## Описание:

Cmd batch скрипт для ОС Windows, который открывает в VLC Media player видео поток 
для одновременного просмотра прямой online трансляции и записи в файл на жёсткий диск вашего ПК.

## Подготовка к запуску:
1. Скачиваем VLC Media player с официального сайт и оставляем всё по умолчанию (https://www.videolan.org/vlc/download-windows.ru.html).
2. Подключаем WEB-камеру к ПК, устанавливаем драйверы (в моём случае это подключение по USB старой Logitech камеры).
3. Проверяем её работу в VLC с помощью кнопки PLAY или STREAM. 
4. Добавляем в брандмауере новое правило, в разделе Правила для входящих подключений. Например:
   - Name: VLC custom stream
   - Protocol: TCP
   - Remote port: 55555
   - Local port: 55555
   - Input: Internet or Provider (if Router is connected to Provider via wire), or other...
   - Output: Your server PC with local IP (192.168.1.36 for example), where execute this script
5. Для доступа к прямой online трансляции из <b>другой сети (не локальной)</b> необходимо <b>ОБЯЗАТЕЛЬНОЕ</b> использование <b>БЕЛОГО IP-адреса</b> (покупается у вашего провайдера).
6. Наличие свободного места на жёстком диске.
7. Скачиваем VLC на телефон или ПК клиента (для IOS/Android есть отдельное приложение).
8. В самом скрипте, в самом начале файла указаны глобальные переменные, значения которых необходимо заменить на свои.

### Переменные:
1. vlc_execution_path="C:\Program Files\VideoLAN\VLC\vlc.exe" - полный путь до запуска VLC Media player (можно просто указать <code>vlc</code>, если добавить полный путь до папки с VLC в переменные окружения PATH)
2. output_save_folder="E:\VLC_saved_videos\prod" - полный путь до папки, куда будут сохранятся видео файлы (папка должна существовать, скрипт сам её не создаёт!!!).
3. execution_time_in_sec=1800 - время выполнения в секундах (по умолчанию выставлено 30 минут), по истечению которого будет:
   - Закрыт текущий stream (поток) в VLC.
   - Сохранён новый файл. Пример выходного файла: 2025-01-26_20-59-40.avi
   - Закрыт текущий экземпляр VLC (только открытое скриптом окно, <b>будет убит только этот процесс по-текущему PID!!!</b>). Позволяет пользователю продолжать работать в VLC, открывая другие окна.
4. device_name="USB Video Device" - название WEB-камеры (у меня не определилась конкретная модель) <b>из интерфейса программы VLC в устройстве захвата (capture device)</b>.
5. server_port=55555 - номер свободного TCP порта для онлайн потока, который будет указан в URL.
6. stream_name="stream" - имя потока, который будет указан в URL через / после номера порта.


## Запуск и тестирование в локальной сети:
- Кликаем дважды по скрипту ЛКМ.
- Открываем VLC на клиенте и нажимает открыть сетевой поток.
- Вводим адрес http://{ip_address_of_server_pc}:{server_port}/{name_of_stream}. Например: http://192.168.1.17:55555/anyStreamName
- Через 5-20 секунд должны увидеть реалтайм поток с задержкой секунд на 10-30 (Если не открывается с первого раза - пробуем ещё).