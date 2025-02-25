#!/bin/bash

tar -zxf linux-amd64_deb.tgz cd linux-amd64_deb sudo ./install_gui.sh 
dpkg -l | grep cprocsp export PATH="$(/bin/ls -d 
/opt/cprocsp/{s,}bin/*|tr '\n' ':')$PATH" sudo apt install libccid pcscd 
libgost-astra /opt/cprocsp/sbin/amd64/cpconfig -license -view
#
# ������ ������ ��������
#sudo /opt/cprocsp/sbin/amd64/cpconfig -license -set <�����_��������>
#
# ���������� ������ �������� ���������
#/opt/cprocsp/sbin/amd64/cpconfig -hardware reader -view
#
# ������ ������ �������� ���������
#/opt/cprocsp/bin/amd64/csptest -card -enum -v -v
#
# ��������� ������� ��������� � ������������
#/opt/cprocsp/bin/amd64/csptest -keyset -verifycontext -enum -unique
#
# �������� ��� �������� � ������� FQCN (Fully Qualified Container Nam)
#/opt/cprocsp/bin/amd64/csptest -keyset -enum_cont -fqcn -verifyc | iconv -f cp1251
#
# ��� ��������� ��������� ���������� � �����������
#/opt/cprocsp/bin/amd64/csptestf -keyset -container '���' -info
#
#
# ��� ������� ������������� �������� � ����� ��������� ���������� ��� ���������� ������ � ����� ����������� ���������� ������������ ��� ���������� �������������. 
# �������� ���������� �������������� �������� ����������� ����� ��������
#/opt/cprocsp/bin/amd64/csptest -keys -enum -verifyc -fqcn -un
#
# ��� ���� ����� ��������� ������ ���������� (� ��� ����� ����������� ���������� ������ �������� ��� ������� ��������), 
# ������� ��������� �������
#/opt/cprocsp/bin/amd64/csptestf -keyset -container ��� -check
#
#
# ������� ���������
# /opt/cprocsp/bin/amd64/csptestf -passwd -cont '\\.\Aktiv Rutoken ECP 00 00\TestCont' -deletek
#
#
# ����������� ����������
# csptestf -keycopy -contsrc '\\.\HDIMAGE\���������_��������' -contdest '\\.\Aktiv Rutoken ECP 00 00\���������_�����'
#
#
# ����� ������ �� ��������� (������ ������� � ����������) 
# /opt/cprocsp/bin/amd64/csptestf -passwd -cont '\\.\Aktiv Rutoken ECP 00 00\TestContainer' -change <�����_������> -passwd <������_������>
# 
# � ������, ���� ���������� � ������ �� ��� ����� PIN, ������� ��������������� ��������:
# /opt/cprocsp/bin/amd64/csptestf -passwd -cont '\\.\Aktiv Rutoken ECP 00 00\TestContainer' -change <�����_������>
#
# ������ ��������� ������� �����������, ��������� �� ������������ ������� ���������� ���������
#
#
# ��������� ���� ������ ������������ �� ���� ����������� � ��������� uMy
# /opt/cprocsp/bin/amd64/csptestf -absorb -certs -autoprov
#
#
# ��������� ������������� ����������� �� ������������� ���������� � ��������� uMy
# /opt/cprocsp/bin/amd64/certmgr -inst -cont '\\.\Aktiv Rutoken ECP 00 00\Ivanov'
#
#
# ��������� ����������� ��������������� ������ ��� � ��������� mRoot
# wget https://zgt.mil.ru/upload/site228/document_file/GUC_2022.cer -O - | sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -stdin
#
# 
# ��������� ������ ���������� ������������ (CRL) (������ ����������� � ���� �� ����� � ��������������� � ��������� mca)
# wget http://reestr-pki.ru/cdp/guc2022.crl -O - | sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mca -stdin -crl 
#
#
# � ������, ���� ��������� ��������� ����������� �� � CRL �� ������� �������, �� ������� ������� � ����, �������
# -��������� ����������� � ������;
#  wget https://zgt.mil.ru/upload/site228/document_file/GUC_2022.cer
#  wget http://reestr-pki.ru/cdp/guc2022.crl
# -��������� ����� �� ������� �������;
# -� ������� ��������� ������ ��������� -stdin ��������� �������� -file � ��������� ����� �����
# sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file GUC_2022.cer
# sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mca -file guc2022.crl -crl
#
# �������� ����� ������������� ������������ 
# /opt/cprocsp/bin/amd64/certmgr -list
#
# ��� �������� ������������� ����������� �� ��������� ���������
#
# ����� ���������� ������� �� ����� ����� ������� ���� ������ ������������ � ����������� ������ ����� ���������� �����������
#
# ��� �������� ���� ������������ ��������� �������
# /opt/cprocsp/bin/amd64/certmgr -del -all
#
# ������� ������������ �� ������ ������
#
# �������� ����� � ������������ ��������� � �������� /var/opt/cprocsp/keys. 
# ��� �������� ������ ����� ������� ����� � ��������� ��� �� ������ ������ � ��� �� �������
#
# ������� �����������
# /opt/cprocsp/bin/amd64/certmgr -export -dest cert.cer
#
# ��������� ��� ����� �� ������ � �������, ����� ���������� ����
# csptest -keyset -enum_cont -verifycontext -fqcn
#
# ��������� ���������� � �������� ����:
# certmgr -inst -file 1.cer -cont '\\.\HDIMAGE\container.name'
# ���� �������� ���� � ���������� �� �������� ���� � �����, ����� �������� ������
# Can not install certificate
# Public keys in certificate and container are not identical
#
# �������� ������� ������������
# ��� �������: ����� ��������� ������� ������������, ����� ����������� ������������ ���������� � ����
# ����� ������� ������ ���� �����������: CN, E, SN, OGRN, SNILS � ��.
# /opt/cprocsp/bin/amd64/cryptcp -copycert -dn 'CN=���_������_�����������' -df  /temp/����������.cer
#
# CP_PRINT_CHAIN_DETAIL=1 --> �������� ����� �������
# CP_PRINT_CHAIN_DETAIL=1 /opt/cprocsp/bin/amd64/cryptcp -copycert -dn 'CN=���_������_�����������' -df  /temp/����������.cer
#
# � ����� ������� �� ����� ����� ������� �����, ��� ��� ���� ���������� ���������� �� �� � CN=������������ ������� ���������� ���������
# /opt/cprocsp/bin/amd64/certmgr -inst -store uRoot -file minoboron-root-2018.crt
#
# ���������� ��������� ���
# ������� ��������� ����� ���� ������� ����� ���������:
# attached (��������������), ����� �������������� ���� - ��� CMS-���������, ������ �������� ��������� ������ � �������� (���� �������). ������ ��������� ������������� �������������� ���������, ������� ��������� ������ ������ ����� ������ ���������, ���� cryptcp / csptest / openssl / certutil (�� windows);
# detached (�������������), ����� �������������� ���� - ��� CMS-��������� ��� �������� ������, �� � ���������� (���� �������). � ���� ������ ��� �������� ���� "��������" �������� ����. ���������� �� ������� ���������� � ��� ����� �������� cat-��
#
# ������� ������ (��������������)
# /opt/cprocsp/bin/amd64/cryptcp -sign -dn 'CN=��������_�������_�����������' -der zayavlenie.pdf
#
# ������� ������ (�������������)
# /opt/cprocsp/bin/amd64/cryptcp -sign -detach -dn 'CN=��������_�������_�����������' -pin 12345678 raport.pdf raport.pdf.sig
#
# �������� �������������� �������
# /opt/cprocsp/bin/amd64/cryptcp -verify raport.pdf.sig
#
# ������ "������������"
# ������������ ���� -verall, �����������, ��� ���� ����� ���� �����������, � ��� ����� � ���������
# /opt/cprocsp/bin/amd64/cryptcp -verify -verall -detached /home/shuhrat/smolensk/raport.pdf raport.pdf.sig
#
# ������ "���������"
# ������� � �������� ��������� ������������ ���� ��������� (���� -f):
# /opt/cprocsp/bin/amd64/cryptcp -verify -f raport.pdf.sig -detached raport.pdf raport.pdf.sig
#
# ���������� ������������ �����
# cryptcp -verify raport.pdf.sig raport.pdf
#
#
# ����������� ��������� ��������� CSP v. 5.0 (cptools)
# cptools
# ����
# /opt/cprocsp/bin/amd64/cptools
#
# �������� ��������� CSP
# sudo rm -rf /opt/cprocsp
# sudo rm -rf /var/opt/cprocsp/
# sudo rm -rf /etc/opt/cprocsp/
#
# ���������� ��������� � ������������� �������� �� ���� � 34.10-2012
# ��� ���������� ������ �������������� � ��������� CSP, ����� �������� ��� ����� � ���������������� ���� /etc/opt/cprocsp/config64.ini � ������������ ������ Parameters:
#
# [Parameters]
# ��������� ����������
# warning_time_gen_2001=ll:9223372036854775807
# warning_time_sign_2001=ll:9223372036854775807#
#
# �������� ������
#
# ���������: IFCP plugin ��� ����� ���� (���������)
# https://wiki.astralinux.ru/pages/viewpage.action?pageId=53645439
#
# ��������� CADES ��� Browser plug-in
# https://wiki.astralinux.ru/pages/viewpage.action?pageId=53645421
#
# ������� �������������� ��������� ������-��� CSP
# https://www.cryptopro.ru/products/csp/compare
# ���� ������ ���������
# https://support.cryptopro.ru/index.php?/Knowledgebase/List
#
# ���������� ��������� CSP �� ������ astralinux
# https://forum.astralinux.ru/threads/419/
#
# Chromium+���������
# https://www.cryptopro.ru/news/2018/12/zashchishchennyi-brauzer-dlya-gosudarstvennykh-elektronnykh-ploshchadok-teper-i-na-linu
#
# ������ ��� � ��� ������������ cades-bes plugin
# https://wiki.astralinux.ru/pages/viewpage.action?pageId=39878870
# �������� ��������������� �������������� �������
# https://e-trust.gosuslugi.ru/#/portal/accreditation/accreditedcalist?filter=eyJwYWdlIjoxLCJvcmRlckJ5IjoiaWQiLCJhc2NlbmRpbmciOmZhbHNlLCJyZWNvcmRzT25QYWdlIjo1LCJzZWFyY2hTdHJpbmciOm51bGwsImNpdGllcyI6bnVsbCwic29mdHdhcmUiOm51bGwsImNyeXB0VG9vbENsYXNzZXMiOm51bGwsInN0YXR1c2VzIjpudWxsfQ%3D%3D
