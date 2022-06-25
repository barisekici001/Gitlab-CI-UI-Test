
DOCKER = docker
IMAGE_RF          = jfxs/robot-framework:5.0
IMAGE_SELENIUM_GC = selenium/standalone-chrome:101.0
IMAGE_SELENIUM_FF = selenium/standalone-firefox:99.0

## Tests
## -----

test-selenium: ## Run Robot Framework tests. Argument browser=ff|gc -- make browser=gc test-selenium

test-selenium:
	test -n "${browser}"  # Failed if browser parameter is not set
	 $(DOCKER) network create tests-network
	@if [ "${browser}" = "ff" ]; then \
	   $(DOCKER) run --rm -d -p 4444:4444 -p 5900:5900 -p 7900:7900 -v /dev/shm:/dev/shm --network=tests-network --name selenium ${IMAGE_SELENIUM_FF}; \
	else \
	   $(DOCKER) run --rm -d -p 4444:4444 -p 5900:5900 -p 7900:7900 -v /dev/shm:/dev/shm --network=tests-network --name selenium ${IMAGE_SELENIUM_GC}; \
	fi
	 while (! wget -T 2 -q -O /dev/null http://localhost:4444); do sleep 1; done
	 -$(DOCKER) run -t --rm -v ${PWD}:/ui-tests -v ${PWD}/reports:/reports --network=tests-network ${IMAGE_RF} /bin/sh -c "pip install --user robotframework-faker && robot -v BROWSER:${browser} --include trendyol-ui --outputdir /reports /ui-tests/Tests"
	 $(DOCKER) kill selenium
	 $(DOCKER) network rm tests-network

clean-test-selenium: ## Clean local test environment
clean-test-selenium:
	 -$(DOCKER) kill selenium
	 -$(DOCKER) network rm tests-network

.PHONY: checks tests-local clean-tests-local tests-remote

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help
