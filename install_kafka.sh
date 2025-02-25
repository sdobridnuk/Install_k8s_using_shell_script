sudo apt -y install curl
sudo apt -y install default-jdk
# ������� ������
java -version
wget https://dlcdn.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz
mkdir /opt/kafka
tar zxf kafka_*.tgz -C /opt/kafka --strip 1
useradd -r -c 'Kafka broker user service' kafka
chown -R kafka:kafka /opt/kafka
rm -f kafka_2.13-3.9.0.tgz
#������� ������ ����-����:
# ----------   Configure prerequisites  ( kubernetes.io/docs/setup/production-environment/container-runtimes/ )
sudo cat <<EOF | sudo tee /etc/systemd/system/zookeeper.service
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

sudo cat <<EOF | sudo tee /etc/systemd/system/kafka.service
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
#������������ ������������ systemd, ����� ���������� ���������
#
systemctl daemon-reload
#
# ��������� ���������� �������� zookeeper � kafka
#
systemctl enable zookeeper kafka
#
# �������� �����
systemctl start kafka
#
#���������, ��� ������ ��� ������ ���������� � ��������� �� ����� 9092
ss -tunlp | grep :9092
#
#�������� ����� �����������
#��������� ������� ��������� �������� � ������ � ���������, ��� ������ ��������. �� �������� ���� ��� ��������� � �������� ����� Hello, World from Kafka.

#��� ������������ ��� �������, ������� ���� � ��������� � ������:

#kafka-topics.sh � ������� ����, ���� ����� ���������� ���������.
#kafka-console-producer.sh � ������� ��������� ��������, ������� ���������� ���������.
#kafka-console-consumer.sh � ��������� ������ � ������� � �������� ���������.
#� ���, ������ �������� �� ������� ����:

/opt/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic Test

#* ���:
#
#/opt/kafka � ����, ���� ���� ����������� ���� �����.
#bootstrap-server localhost:9092 � ����� ����� kafka. ��������������, ��� �� ��������� ���� ������� �� ��� �� �������, ��� �� � ����������.
#replication-factor � ���������� ������ ������� ���������.
#partitions � ���������� �������� � ����.
#topic Test � � ����� ������� �� �������� ���� � ��������� Test.
#������ ���������� ��������� �������:

echo "Hello, World from Kafka" | /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic Test

#* � ������ ������� �� ���������� � ��� ������ ��������� Hello, World from Kafka.

#��������� ������� ���������. ��������� �������:

/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic Test --from-beginning

#* ����� from-beginning ��������� ������� ��� ���������, ������� ���� ���������� � ������ �� �������� ���������� (�������� ������� �� ������ ������ �� �����).
#
#�� ������ �������:
#
#Hello, World from Kafka
#��� ���� �� ����������� � ������� � ������������� ������. �� ������ ��������. ������� ������ ������ SSH � ��� ��� ������:

#echo "Hello, World from Kafka again" | /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic Test

#�������� � ���������� ������ SSH � �� ������ �������:

#Hello, World from Kafka
#Hello, World from Kafka again

#����� �������, ��� ��������� ������� ��������� � Kafka ����������� � ��������
#
