# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: iostancu <iostancu@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/07/16 17:25:10 by iostancu          #+#    #+#              #
#    Updated: 2022/08/17 17:35:15 by iostancu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BLUE	=\033[1;34m
LILA 	=\033[0;35m
GREEN	=\033[2;32m
YELLOW	=\033[1;33m
END	=\033[1;37m

TARGET_SRC = /home/
APP_NAME = stockholm:v1
CONTAINER = wannacry
MOUNT_SRC = $(shell pwd)
DOCKER_PATH = './docker/Dockerfile'

all:	run	exec

info:	header

define HEADER

                         ▀▄▀     ▄     ▄
                      ▄███████▄  ▀██▄██▀
                    ▄█████▀█████▄  ▄█
                    ███████▀████████▀
                     ▄▄▄▄▄▄███████▀


** Configure the main variables: 'APP_NAME' for your image:version name, 'CONTAINER' name
and 'DOCKER_PATH' where the Dockerfile is located. **

	[ make build ]  Build the image if it's not created. If it's create you don't need to exec it twice.
	[ make ]        Run and execute the container_name based on the builded image.

	[ make delete ] When finish, this commands deletes image and container. 

	If you exit container but you need to execute it again. You can run [ make exec ]
					
endef
export HEADER

list:
	@echo "${BLUE}> All running containers: \t--------------------------------${END}"
	@docker ps -a
	@echo "${LILA}> Existing docker images: \t--------------------------------${END}"
	@docker images 
	@echo "${LILA}> Existing containers: \t\t--------------------------------${END}"
	@docker ps

build:
	docker build -f ${DOCKER_PATH} -t ${APP_NAME} .

run:
	docker run  -it -d --mount type=bind,source=${MOUNT_SRC},target=${TARGET_SRC} --name ${CONTAINER} ${APP_NAME} bash 

delete:
	@echo "${BLUE}"
	docker rm -fv ${CONTAINER}
#	@echo "${GREEN}"
#	docker rm  ${CONTAINER}
	@echo "${YELLOW}"
	docker rmi  ${APP_NAME}

exec:
	docker exec -it ${CONTAINER} bash


header: 
	@echo "$(BLUE)$$HEADER$(END)"

help:	header
	@echo "${BLUE}GENERAL COMMANDS:\033[2;37m"
	@echo "\t[ make ] run a container and execute it with bash"
	@echo "\t[ exec ] execute container with bash"
	@echo "\t[ list ] shows images and all containers"
	@echo "\t[ delete ] stops running containers, deletes containers and images"
	@echo "\t[ build ] build image"
