# flameuploadx

Este minimal script esta diseñado para configurar la carga automatica de capturas de pantalla al servicio autohospedado de xbackbone, para esto es necesario tener configurado y disponible el script de xbackbone linux script

## Requisitos
- Tener instalado y configurado xbackbone
- Descargar el script del uploader

## Como Usar

1. Descargar el script configure.sh
2. Ejecutar configure.sh
Agregar las rutas que se van solicitando durante el tiempo de ejecución
```
Do you want yo use this path to scripts and log bin? /root/Repositorios/flameuploabx (Y/N) [Y]:
Scripts bin and log Path: /root/Repositorios/flameuploabx/bin
The directory does not exist, it will try to create
------------------
created /root/Repositorios/flameuploabx/bin directory
######################
suggested path for screenshots: /root/Pictures/Screenshots
----------------------
Please add path to the screenshots: /root/Pictures/Screenshots
The directory does not exist, it will try to create
------------------
created /root/Pictures/Screenshots directory
Enter the name of the script xbackbone_uploader_user.sh: uploader
############# WARNING #################
The file uploader does not exist 
Please put the file ## uploader ## in the /root/Repositorios/flameuploabx/bin directory and give execution permissions

```

## Importante
El uploader de xbackbone por default copia la url donde se cargo el archivo, si no se requiere ese comportamiento debemos modificar el archivo en la función upload y comentar la línea `echo "${URL}" | xclip -selection c;`

```
if [ "${DESKTOP_SESSION}" != "" ]; then
            echo "${URL}" | xclip -selection c;
            notify-send "Upload completed!" "${URL}";
        else
```

```
if [ "${DESKTOP_SESSION}" != "" ]; then
         #   echo "${URL}" | xclip -selection c;
            notify-send "Upload completed!" "${URL}";
        else
```