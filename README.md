# eea.docker.uwwtd_web_dem

run the container:

    docker run --restart=always --name uwwtd_web_dem --volumes-from=uwwtd_web_dem_data --volumes-from=uwwtd_web_dem_home  -p <port_host>:80 -e MYSQL_ROOT_PASSWORD=<secret_password> -d eeacms/uwwtd_web_dem

current <port_host> = 50004

moving data volume containers from one host to another: 

<donor host>

    docker run --rm --volumes-from=uwwtd_web_dem_home -v $(pwd):/backup busybox tar cvfp /backup/uwwtd_web_dem_home.tar /var/www

    docker run --rm --volumes-from=uwwtd_web_dem_data -v $(pwd):/backup busybox tar cvfp /backup/uwwtd_web_dem_data.tar /var/lib/mysql

<target host>

    docker run -d --name uwwtd_web_dem_home eeacms/php_data 
    docker run -d --name uwwtd_web_dem_data eeacms/mysql_data

    docker run --rm --volumes-from=uwwtd_web_dem_home -v $(pwd):/backups busybox tar xvf /backups/uwwtd_web_dem_home.tar 

    docker run --rm --volumes-from=uwwtd_web_dem_data -v $(pwd):/backups busybox tar xvf /backups/uwwtd_web_dem_data.tar
