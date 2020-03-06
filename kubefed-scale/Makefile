

all: start logs

start:
	docker-compose up --build -d

logs:
	docker-compose logs -f

reload-prom:
	curl -X POST http://localhost:9090/-/reload

prom:
	docker-compose up prometheus

clean:
	docker-compose down --remove-orphans