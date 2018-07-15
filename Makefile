migrate:
	mix ecto.migrate -r Persistence.Repo --all

style:
	mix credo --strict

docs-report:
	mix inch --pedantic

coverage:
	mix coveralls -u

test: coverage style docs-report

.PHONY: test style docs-report coverage
