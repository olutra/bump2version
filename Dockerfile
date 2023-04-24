FROM debian:bullseye-slim

RUN apt update && apt-get install -y --no-install-recommends git-core mercurial

# Install build environment for pyenv
RUN apt update && apt install -y --no-install-recommends build-essential libssl-dev zlib1g-dev \
                libbz2-dev libreadline-dev libsqlite3-dev curl ca-certificates \
                libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install pyenv
ENV PYENV_ROOT="/.pyenv" \
    PATH="/.pyenv/bin:/.pyenv/shims:$PATH"
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

RUN echo 3.7 3.8 3.9 3.10 3.11 pypy3.7 pypy3.8 pypy3.9 | xargs -P 4 -n 1 pyenv install
RUN pyenv global 3.7 3.8 3.9 3.10 3.11 pypy3.7 pypy3.8 pypy3.9

RUN python -m pip install nox

RUN git config --global user.email "bumpversion_test@example.org"
RUN git config --global user.name "Bumpversion Test"

ENV PYTHONDONTWRITEBYTECODE = 1  # prevent *.pyc files

WORKDIR /code
COPY noxfile.py .
RUN python -m nox --install-only

COPY . .
ENTRYPOINT ["python", "-m", "nox"]
