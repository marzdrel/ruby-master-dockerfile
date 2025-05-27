# Building Ruby

This is a simple Dockerfile to build Ruby from source using the official master snapshot.

See [Building Ruby](https://docs.ruby-lang.org/en/3.4/contributing/building_ruby_md.html) for more details.

## Usage

# Build the Docker image
```bash
docker build -t ruby-from-source .
```

# Run a container
```bash
docker run -it ruby-from-source
```

# Or run with a volume for your Ruby code
```bash
docker run -it -v $(pwd):/app -e RUBY_NAMESPACE=1 ruby-from-source bash
```
