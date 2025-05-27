FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV RUBY_VERSION_PATH=snapshot
ENV RUBY_VERSION_FILE=snapshot-master
ENV RUBY_CONFIGURE_OPTS="--disable-install-doc"

# Install dependencies required for building Ruby
RUN apt-get update && apt-get install -y \
    autoconf \
    bison \
    build-essential \
    curl \
    git \
    libdb-dev \
    libffi-dev \
    libgdbm-compat-dev \
    libgdbm-dev \
    libncurses5-dev \
    libreadline6-dev \
    libssl-dev \
    libyaml-dev \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for Ruby source
WORKDIR /tmp/ruby-build

# Download Ruby source code
RUN wget https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION_PATH}/${RUBY_VERSION_FILE}.tar.gz \
    && tar -xzf ${RUBY_VERSION_FILE}.tar.gz \
    && cd ${RUBY_VERSION_FILE} 

# Configure, compile and install Ruby
WORKDIR /tmp/ruby-build/${RUBY_VERSION_FILE}
RUN ./configure ${RUBY_CONFIGURE_OPTS} \
    && make -j$(nproc) \
    && make install

# Clean up build dependencies and source files
RUN cd / \
    && rm -rf /tmp/ruby-build \
    && apt-get autoremove -y \
    && apt-get clean

# Verify Ruby installation
RUN ruby --version && gem --version

# Set working directory for applications
WORKDIR /app

# Default command
CMD ["ruby", "--version"]
