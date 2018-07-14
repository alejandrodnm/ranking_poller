style:
	mix credo --strict

docs-report:
	MIX_ENV=docs mix inch --pedantic

coverage:
	MIX_ENV=test mix coveralls -u

test: coverage docs-report style

.PHONY: test style docs-report coverage
