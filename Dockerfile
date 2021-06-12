FROM ubuntu:21.10 as final

ARG GITSTATUS_VERSION=1.5.1
ARG DEFAULT_PYTHON_VERSION=3.9.5
ENV PYENV_ROOT=/home/anders/.pyenv
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH" \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        zsh \
        ca-certificates \
        curl \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        llvm \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -ms /bin/zsh anders

USER anders

RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
 && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k \
 && mkdir -p /home/anders/.cache/gitstatus \
 && curl -s -L --output \
    /tmp/gitstatusd-linux-x86_64.tar.gz https://github.com/romkatv/gitstatus/releases/download/v${GITSTATUS_VERSION}/gitstatusd-linux-x86_64.tar.gz \
 && tar -xzf /tmp/gitstatusd-linux-x86_64.tar.gz -C /home/anders/.cache/gitstatus

COPY .zshrc .p10k.zsh /home/anders/
COPY pyenv.zsh /home/anders/.oh-my-zsh/custom/pyenv.zsh

RUN curl -s https://pyenv.run | bash \
    && pyenv install $DEFAULT_PYTHON_VERSION \
    && pyenv global $DEFAULT_PYTHON_VERSION \
    && pyenv rehash

WORKDIR /home/anders

ENTRYPOINT ["zsh"]





