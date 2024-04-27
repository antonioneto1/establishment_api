# Definir argumento de construção para a versão do Ruby
ARG ARG_RUBY_VERSION
FROM --platform=linux/amd64 ruby:${ARG_RUBY_VERSION}-slim-buster

SHELL ["/bin/sh", "-c"]
ARG ARG_USER_UID=1000
ARG ARG_USER_GID=1000

# Atualizar e instalar pacotes necessários
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        sudo \
        locales-all \
        bash-completion \
        dh-autoreconf \
        cmake \
        git-core \
        curl \
        wget \
        zip \
        vim && \
    update-alternatives --config editor && \
    apt autoremove --purge && \
    apt autoclean

# Definir argumento de construção para a localidade do Linux
ARG ARG_LINUX_LOCALE
ENV LC_ALL=$ARG_LINUX_LOCALE LANG=$ARG_LINUX_LOCALE LANGUAGE=$ARG_LINUX_LOCALE

# Definir argumentos de construção para UID e GID do usuário
ARG ARG_USER_UID=1000
ARG ARG_USER_GID=1000

# Remover usuário e grupo existentes (se existirem)
RUN set -eux; \
    existing_username=$(getent passwd $ARG_USER_UID | cut -d: -f1); \
    if [ -n "$existing_username" ]; then deluser --remove-home "$existing_username"; fi; \
    existing_groupname=$(getent group $ARG_USER_GID | cut -d: -f1); \
    if [ -n "$existing_groupname" ]; then delgroup --remove-home "$existing_groupname"; fi

# Adicionar um novo grupo com o GID especificado
RUN groupadd --gid $ARG_USER_GID user

# Adicionar um novo usuário com o UID e GID especificados
RUN useradd --disabled-password --gecos '' --uid $ARG_USER_UID --gid $ARG_USER_GID user

# Remover a senha do usuário root
RUN passwd -d root

# Adicionar permissões sudo para o usuário criado
RUN echo 'user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

# Mudar o usuário para 'user' e definir diretório de trabalho
USER user
WORKDIR /home/user

# Instalar pacote de desenvolvimento PostgreSQL
RUN sudo apt install -y libpq-dev
