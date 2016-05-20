docker build -t=shellfactory_guard_tests .
docker run \
  -v $(pwd):/app/bats-tests \
  -e "TERM=xterm-256color" \
  -ti shellfactory_guard_tests
