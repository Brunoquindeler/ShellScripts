#!/bin/bash
#
codigo_http=$(curl --write-out %{http_code} --silent --output /dev/null http://dominiosite.com/)
#
if [ $codigo_http -ne 200 ]; then
#
    echo "Houve um problema com o servidor, tentando reiniciá-lo - $(date +%F\ %T)" >> /var/logs/statusHttp.log
#
    var1=`cat /etc/*-release | grep PRETTY | cut -c 14- | awk '{print $1}'`
    var2=`cat /etc/*-release | awk '{print $1}' | head -n 1`
#
    if [ "$var1" = 'CentOS' -o "$var2" = 'CentOS' ]; then
        systemctl restart httpd
        echo "CentOS - $(date +%F\ %T)" >> /var/logs/statusHttp.log
    elif [ "$var1" = 'Ubuntu' -o "$var2" = 'Ubuntu' -o "var1" = 'Debian' -o "var2" = 'Debian' ]; then
        systemctl restart apache2
        echo "Ubuntu ou Debian - $(date +%F\ %T)" >> /var/logs/statusHttp.log
    else
        echo "S.O não reconhecido - $(date +%F\ %T)" >> /var/logs/statusHttp.log
    fi
#
fi
#
# Obter o S.O, Debian, Ubuntu, CentOS...
# cat /etc/*-release | grep PRETTY | cut -c 14- | awk '{print $1}'
#
# Caso o primeiro retorne vazio
# cat /etc/*-release | awk '{print $1}' | head -n 1
#
# Referencia: https://www.alura.com.br/artigos/automatizando-tarefas-com-shell-script