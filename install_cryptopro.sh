#!/bin/bash

tar -zxf linux-amd64_deb.tgz 
cd linux-amd64_deb 
sudo ./install_gui.sh 
dpkg -l | grep cprocsp 
export PATH="$(/bin/ls -d /opt/cprocsp/{s,}bin/*|tr '\n' ':')$PATH" 
sudo apt install libccid pcscd libgost-astra 
#
#
# проверить срок лицензий  КриптоПро
/opt/cprocsp/sbin/amd64/cpconfig -license -view
sleep 60
#
# ввести список лицензий
#sudo /opt/cprocsp/sbin/amd64/cpconfig -license -set <номер_лицензии>
#
# посмотреть список ключевых носителей
#/opt/cprocsp/sbin/amd64/cpconfig -hardware reader -view
#
# узнать модели ключевых носителей
#/opt/cprocsp/bin/amd64/csptest -card -enum -v -v
#
# Проверить наличие носителей с контейнерами
#/opt/cprocsp/bin/amd64/csptest -keyset -verifycontext -enum -unique
#
# Получить имя носителя в формате FQCN (Fully Qualified Container Nam)
#/opt/cprocsp/bin/amd64/csptest -keyset -enum_cont -fqcn -verifyc | iconv -f cp1251
#
# Для просмотра подробной информации о контейнерах
#/opt/cprocsp/bin/amd64/csptestf -keyset -container 'ИМЯ' -info
#
#
# При наличии кириллических символов в имени ключевого контейнера для дальнейшей работы с таким контейнером необходимо использовать его уникальный идентификатор. 
# Получить уникальные идентификаторы ключевых контейнеров можно командой
#/opt/cprocsp/bin/amd64/csptest -keys -enum -verifyc -fqcn -un
#
# Для того чтобы проверить работу контейнера (в том числе возможность выполнения разных операций при текущей лицензии), 
# следует выполнить команду
#/opt/cprocsp/bin/amd64/csptestf -keyset -container ИМЯ -check
#
#
# Удалить контейнер
# /opt/cprocsp/bin/amd64/csptestf -passwd -cont '\\.\Aktiv Rutoken ECP 00 00\TestCont' -deletek
#
#
# Копирование контейнера
# csptestf -keycopy -contsrc '\\.\HDIMAGE\Контейнер_оригинал' -contdest '\\.\Aktiv Rutoken ECP 00 00\Контейнер_копия'
#
#
# Смена пароля на контейнер (снятие паролей с контейнера) 
# /opt/cprocsp/bin/amd64/csptestf -passwd -cont '\\.\Aktiv Rutoken ECP 00 00\TestContainer' -change <новый_пароль> -passwd <старый_пароль>
# 
# В случае, если контейнеру с ключом не был задан PIN, следует воспользоваться командой:
# /opt/cprocsp/bin/amd64/csptestf -passwd -cont '\\.\Aktiv Rutoken ECP 00 00\TestContainer' -change <новый_пароль>
#
# Пример установки личного сертификата, выданного УЦ Министерства Обороны Российской Федерации
#
#
# Установка всех личных сертификатов из всех контейнеров в хранилище uMy
# /opt/cprocsp/bin/amd64/csptestf -absorb -certs -autoprov
#
#
# Установка определенного сертификата из определенного контейнера в хранилище uMy
# /opt/cprocsp/bin/amd64/certmgr -inst -cont '\\.\Aktiv Rutoken ECP 00 00\Ivanov'
#
#
# Установка сертификата удостоверяющего центра ГУЦ в хранилище mRoot
# wget https://zgt.mil.ru/upload/site228/document_file/GUC_2022.cer -O - | sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -stdin
#
# 
# Установка списка отозванных сертификатов (CRL) (список загружается с того же сайта и устанавливается в хранилище mca)
# wget http://reestr-pki.ru/cdp/guc2022.crl -O - | sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mca -stdin -crl 
#
#
# В случае, если требуется установка сертификата УЦ и CRL на рабочую станцию, не имеющую доступа к сети, следует
# -сохранить сертификаты в файлах;
#  wget https://zgt.mil.ru/upload/site228/document_file/GUC_2022.cer
#  wget http://reestr-pki.ru/cdp/guc2022.crl
# -перенести файлы на рабочую станцию;
# -в команде установки вместо параметра -stdin применить параметр -file с указанием имени файла
# sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file GUC_2022.cer
# sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mca -file guc2022.crl -crl
#
# Просмотр ранее установленных сертификатов 
# /opt/cprocsp/bin/amd64/certmgr -list
#
# Для удаления определенного сертификата из хранилища КриптоПро
#
# После выполнения команды на экран будет выведен весь список сертификатов и предложение ввести номер удаляемого сертификата
#
# Для удаления всех сертификатов выполнить команду
# /opt/cprocsp/bin/amd64/certmgr -del -all
#
# Экспорт сертификатов на другую машину
#
# Закрытые ключи к сертификатам находятся в каталоге /var/opt/cprocsp/keys. 
# Для переноса ключей нужно создаем архив и перенести его на нужную машину в тот же каталог
#
# Экспорт сертификата
# /opt/cprocsp/bin/amd64/certmgr -export -dest cert.cer
#
# Переносим эти файлы на машину и смотрим, какие контейнеры есть
# csptest -keyset -enum_cont -verifycontext -fqcn
#
# Связываем сертификат и закрытый ключ:
# certmgr -inst -file 1.cer -cont '\\.\HDIMAGE\container.name'
# Если закрытый ключ и сертификат не подходят друг к другу, будет выведена ошибка
# Can not install certificate
# Public keys in certificate and container are not identical
#
# Проверка цепочки сертификатов
# Для примера: чтобы проверить цепочку сертификатов, можно скопировать персональный сертификат в файл
# Можно указать другое поле сертификата: CN, E, SN, OGRN, SNILS и тд.
# /opt/cprocsp/bin/amd64/cryptcp -copycert -dn 'CN=Имя_вашего_сертификата' -df  /temp/сертификат.cer
#
# CP_PRINT_CHAIN_DETAIL=1 --> включает режим отладки
# CP_PRINT_CHAIN_DETAIL=1 /opt/cprocsp/bin/amd64/cryptcp -copycert -dn 'CN=Имя_вашего_сертификата' -df  /temp/сертификат.cer
#
# В нашем примере из логов можно сделать вывод, что нам надо установить сертификат УЦ МО с CN=Министерство обороны Российской Федерации
# /opt/cprocsp/bin/amd64/certmgr -inst -store uRoot -file minoboron-root-2018.crt
#
# Подписание документа ЭЦП
# Подпись документа может быть сделана двумя способами:
# attached (присоединенная), когда результирующий файл - это CMS-сообщение, внутрь которого упакованы данные и атрибуты (типа подписи). Формат сообщения соответствует международному стандарту, поэтому извлекать данные оттуда можно любыми утилитами, типа cryptcp / csptest / openssl / certutil (на windows);
# detached (отсоединенная), когда результирующий файл - это CMS-сообщение БЕЗ исходных данных, но с атрибутами (типа подписи). В этом случае для проверки надо "принести" исходный файл. Разумеется он остаётся неизменным и его можно смотреть cat-ом
#
# Подпись файлов (присоединенная)
# /opt/cprocsp/bin/amd64/cryptcp -sign -dn 'CN=Название_нужного_сертификата' -der zayavlenie.pdf
#
# Подпись файлов (отсоединенная)
# /opt/cprocsp/bin/amd64/cryptcp -sign -detach -dn 'CN=Название_нужного_сертификата' -pin 12345678 raport.pdf raport.pdf.sig
#
# Проверка присоединенной подписи
# /opt/cprocsp/bin/amd64/cryptcp -verify raport.pdf.sig
#
# Способ "естественный"
# Использовать ключ -verall, указывающий, что надо найти всех подписавших, в том числе в сообщении
# /opt/cprocsp/bin/amd64/cryptcp -verify -verall -detached /home/shuhrat/smolensk/raport.pdf raport.pdf.sig
#
# Способ "обучающий"
# Указать в качестве хранилища сертификатов само сообщение (ключ -f):
# /opt/cprocsp/bin/amd64/cryptcp -verify -f raport.pdf.sig -detached raport.pdf raport.pdf.sig
#
# Извлечение подписанного файла
# cryptcp -verify raport.pdf.sig raport.pdf
#
#
# Графический интерфейс КриптоПро CSP v. 5.0 (cptools)
# cptools
# либо
# /opt/cprocsp/bin/amd64/cptools
#
# Удаление КриптоПро CSP
# sudo rm -rf /opt/cprocsp
# sudo rm -rf /var/opt/cprocsp/
# sudo rm -rf /etc/opt/cprocsp/
#
# Отключение сообщений о необходимости перехода на ГОСТ Р 34.10-2012
# Для отключения данных предупреждений в КриптоПро CSP, нужно добавить два ключа в конфигурационный файл /etc/opt/cprocsp/config64.ini в существующую секцию Parameters:
#
# [Parameters]
# Параметры провайдера
# warning_time_gen_2001=ll:9223372036854775807
# warning_time_sign_2001=ll:9223372036854775807#
#
# Полезные ссылки
#
# КриптоПро: IFCP plugin для входа ЕСИА (Госуслуги)
# https://wiki.astralinux.ru/pages/viewpage.action?pageId=53645439
#
# КриптоПро CADES ЭЦП Browser plug-in
# https://wiki.astralinux.ru/pages/viewpage.action?pageId=53645421
#
# Таблица поддерживаемых устройств Крипто-Про CSP
# https://www.cryptopro.ru/products/csp/compare
# База знаний КриптоПро
# https://support.cryptopro.ru/index.php?/Knowledgebase/List
#
# Обсуждение КриптоПро CSP на форуме astralinux
# https://forum.astralinux.ru/threads/419/
#
# Chromium+КриптоПРО
# https://www.cryptopro.ru/news/2018/12/zashchishchennyi-brauzer-dlya-gosudarstvennykh-elektronnykh-ploshchadok-teper-i-na-linu
#
# Список ГИС и ЭТП использующих cades-bes plugin
# https://wiki.astralinux.ru/pages/viewpage.action?pageId=39878870
# Перечень аккредитованных удостоверяющих центров
# https://e-trust.gosuslugi.ru/#/portal/accreditation/accreditedcalist?filter=eyJwYWdlIjoxLCJvcmRlckJ5IjoiaWQiLCJhc2NlbmRpbmciOmZhbHNlLCJyZWNvcmRzT25QYWdlIjo1LCJzZWFyY2hTdHJpbmciOm51bGwsImNpdGllcyI6bnVsbCwic29mdHdhcmUiOm51bGwsImNyeXB0VG9vbENsYXNzZXMiOm51bGwsInN0YXR1c2VzIjpudWxsfQ%3D%3D
