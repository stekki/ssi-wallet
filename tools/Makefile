backend:
	@{ \
	sh pull-cli-tools.sh ; \
	if [ -d "cli-tools" ]; then \
		echo "success" ; \
	else \
		echo "Abort. cli-tools not found" ; \
	fi \
	}

cli-tools:
	@sh pull-cli-tools.sh

clean:
	@rm -rf cli-tools/

.PHONY: cli-tools clean
