#!/bin/bash

sudo apt -y install curl 
sudo apt -y install default-jdk
# смотрим версию
java -version
wget https://dlcdn.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz
mkdir /opt/kafka
tar zxf kafka_*.tgz -C /opt/kafka --strip 1
useradd -r -c 'Kafka broker user service' kafka
chown -R kafka:kafka /opt/kafka
rm -f kafka_2.13-3.9.0.tgz
#Создаем первый юнит-файл:
# ----------   Configure prerequisites  ( kubernetes.io/docs/setup/production-environment/container-runtimes/ )
sudo cat > /etc/systemd/system/zookeeper.service << EOF
[Unit]
Description=Zookeeper Service
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=kafka
ExecStart=/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties
ExecStop=/opt/kafka/bin/zookeeper-server-stop.sh
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo cat  > /etc/systemd/system/kafka.service << EOF
[Unit]
Description=Kafka Service
Requires=zookeeper.service
After=zookeeper.service

[Service]
Type=simple
User=kafka
ExecStart=/bin/sh -c '/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties > /opt/kafka/kafka.log 2>&1'
ExecStop=/opt/kafka/bin/kafka-server-stop.sh
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
#
#Перечитываем конфигурацию systemd, чтобы подхватить изменения
#
systemctl daemon-reload
#
# Разрешаем автозапуск сервисов zookeeper и kafka
#
systemctl enable zookeeper kafka
#
# Стартуем кафку
systemctl start kafka
#
#Проверить, что нужный нам сервис запустился и работаешь на порту 9092
ss -tunlp | grep :9092
#
#Тестовый обмен сообщениями
#Попробуем немного научиться работать с кафкой и проверить, что сервис работает. Мы создадим тему для сообщений и отправим текст Hello, World from Kafka.

#Нам понадобиться три скрипта, которые идут в комплекте с кафкой:

#kafka-topics.sh — создает тему, куда будем отправлять сообщение.
#kafka-console-producer.sh — создает обращение издателя, который отправляет сообщение.
#kafka-console-consumer.sh — формирует запрос к брокеру и получает сообщение.
#И так, первой командой мы создаем тему:

/opt/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic Test

#* где:
#
#/opt/kafka — путь, куда была установлена нами кафка.
#bootstrap-server localhost:9092 — адрес хоста kafka. Предполагается, что мы запускаем нашу команду на том же сервере, где ее и развернули.
#replication-factor — количество реплик журнала сообщений.
#partitions — количество разделов в теме.
#topic Test — в нашем примере мы создадим тему с названием Test.
#Теперь отправляем сообщение брокеру:

echo "Hello, World from Kafka" | /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic Test

#* в данном примере мы отправляем в наш сервер сообщение Hello, World from Kafka.

#Попробуем достать сообщение. Выполняем команду:

/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic Test --from-beginning

#* опция from-beginning позволяет увидеть все сообщения, которые были отправлены в брокер до создания подписчика (отправки запроса на чтения данных из кафки).
#
#Мы должны увидеть:
#
#Hello, World from Kafka
#При этом мы подключимся к серверу в интерактивном режиме. Не спешим выходить. Откроем вторую сессию SSH и еще раз введем:

#echo "Hello, World from Kafka again" | /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic Test

#Вернемся к предыдущей сессии SSH и мы должны увидеть:

#Hello, World from Kafka
#Hello, World from Kafka again

#Можно считать, что программа минимум выполнена — Kafka установлена и работает
#
