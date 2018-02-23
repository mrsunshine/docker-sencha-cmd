# docker-sencha-cmd

Docker file to run Sencha CMD in a docker container. Sencha CMD version is configurable.

## Prepare

Set SENCHA_CMD_VERSION in Dockerfile to the Sencha CMD version you need.

Current version number can be found here: 

	https://www.sencha.com/products/extjs/cmd-download/

## Docker build and run

6.x.y.z is the same as SENCHA_CMD_VERSION

	docker build --tag=sencha-cmd:6.x.y.z . 
	docker run -t --user=$(id -u):$(id -g) -v /:/system -w /system/$(pwd) sencha-cmd:6.x.y.z <args>

	Example:

	docker run -t --user=$(id -u):$(id -g) -v /:/system -w /system/$(pwd) sencha-cmd:6.5.3.6 help

