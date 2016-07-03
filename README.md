# eea.docker.uwwtd_web_dem

run the container:

```
# cd /var/local/deploy/eea.docker.uwwtd_web_dem
# docker-compose up -d
```
 
install/first run:

```
# cd /var/local/deploy/
# git clone https://github.com/eea/eea.docker.uwwtd_web_dem.git
# docker-compose build
```

prepare the data containers:

```
# docker run -d --name uwwtd_web_dem_home eeacms/php_data 
# docker run -d --name uwwtd_web_dem_data eeacms/mysql_data
```

dump application and data from donor host (stop database service first)

```
# docker run --rm --volumes-from=eeadockeruwwtdwebdem_home_1 -v $(pwd):/backup busybox tar cvfp /backup/uwwtd_web_dem_home.tar /var/www
# docker run --rm --volumes-from=eeadockeruwwtdwebdem_database_1 -v $(pwd):/backup busybox tar cvfp /backup/uwwtd_web_dem_data.tar /var/lib/mysql
```

import application and data to target host

```
# docker run --rm --volumes-from=uwwtd_web_dem_home -v $(pwd):/backups busybox tar xvf /backups/uwwtd_web_dem_home.tar 
# docker run --rm --volumes-from=uwwtd_web_dem_data -v $(pwd):/backups busybox tar xvf /backups/uwwtd_web_dem_data.tar
```

Update application:

```
# cd /var/local/deploy/eea.docker.uwwtd_web_dem
# docker-compose stop
# docker run -it --rm --volumes-from=uwwtd_web_dem_home ubuntu bash

    #apt-get update
    #apt-get install -y subversion
    #svn --username USERNAME checkout https://svn.eionet.europa.eu/repositories/PHP/trunk/UWWTD-WEB-DEM/UWWTD_Final/
    #mv /var/www/UWWTD-WEB-DEM /var/www/UWWTD-WEB-DEM_bak -- if you dare: rm -r /var/www/UWWTD-WEB-DEM
    #mv UWWTD_Final /var/www/UWWTD-WEB-DEM
    #chown -R www-data /var/www/UWWTD-WEB-DEM
    #chgrp -R www-data /var/www/UWWTD-WEB-DEM
```

```
# cd /var/local/deploy/eea.docker.uwwtd_web_dem
# docker-compose start
```

## Release to production

The production deployment isn't made with `git clone` and `docker-compose build`.
Instead it pulls an image from Docker Hub. When you have tested your changes
and are satisfied, then you must push a new image up. Here is how you do it:

    docker build -t eeacms/uwwtd_web_dem:latest php
    docker push eeacms/uwwtd.web_dem:latest

This mechanism will allow us to later implement release versioning and rollback of deployments.
