all: test

test:
	azk shell -t -- mix do deps.get, mix compile
	azk shell -t -- mix test

publish:
	azk shell -t -- mix hex.publish
	azk shell -t -- mix hex.docs

.PHONY: test publish
