#! /bin/bash
#
limparCache() {
echo "================ Limpando Cache/Buffer, Dentries e Inodes, Swap ================"
echo -e  `date +"%d %b %Y: %X"`: "\n"
#
echo  "================ Memória atual ================"
free -h
#
sync; echo 1 > /proc/sys/vm/drop_caches
swapoff -a && swapon -a
#
echo  "================ Memória após limpeza ================"
free -h
#
echo -e  "\n================ Limpeza completa! ================\n"
}
#
limparCache >> /var/log/limparCache.log
#
#Para limpar o Cache/Buffer de RAM:
#echo "Limpando Cache/Buffer"
# sync; echo 1 > /proc/sys/vm/drop_caches
#
#Para limpar dentries e inodes:
#echo "Limpando Dentries e Inodes"
# sync; echo 2 > /proc/sys/vm/drop_caches
#
#Para limpar tudo: Cache/Buffer, Dentries e Inodes:
#echo "Limpando Cache/Buffer, Dentries e Inodes, Swap"
#sync; echo 3 > /proc/sys/vm/drop_caches
#
#Para limpar o espaço em disco consumido pela SWAP:
#echo "Limpando Swap"
#swapoff -a && swapon -a
#
#sync
#Vai sincronizar e liberar o buffer do sistema de arquivos, permitindo que você possa limpá-lo sem riscos de corromper nada.
#;
#Executará o comando somente quando o anterior terminar. Somente após a sincronia, o buff poderá ser apagado sem corromper arquivos do sistema.
#Escrever 1, 2 ou 3 no arquivo drop_cache vai limpar o cache sem matar nenhum programa, processo ou serviço do sistema.
#E por fim, o comando echo fará a escrita no arquivo.
#
#O primeiro comando é seguro para sistemas servidores de empresas e produção.
#
#Não recomendamos o uso do segundo e terceiro comandos em sistemas de produção e servidores
#pois pode acarretar no corrompimento de bancos de dados dos programas em uso pelos diversos usuários simultâneos (Firebird);
#a unica situação tecnicamente segura, é se o servidor não estiver sendo acessado por ninguém, tal qual no momento de backup de bancos de dados
#
#Referencia: https://unixuniverse.com.br/linux/ram-buffer-swap