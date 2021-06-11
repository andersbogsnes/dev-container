FROM ubuntu:21.10
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        zsh \
        ca-certificates \
        curl \
    && useradd -ms /bin/zsh anders

USER anders
RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
 && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
COPY .zshrc .p10k.zsh /home/anders/

WORKDIR /home/anders

ENTRYPOINT ["zsh"]





