all: test

test:
  azk shell -t -- mix do deps.get, mix compile
  azk shell -t -- mix test

.PHONY: test
