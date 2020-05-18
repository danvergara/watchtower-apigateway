.PHONY: up
## up: builds and starts containers for a service
up:
	docker-compose up --build --detach

.PHONY: down
## down: stops containers and remove containers, networks, volumes and images created by up
down:
	docker-compose down

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
