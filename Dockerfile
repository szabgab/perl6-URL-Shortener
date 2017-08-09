FROM rakudo-star

WORKDIR /srv

ENV AUTHOR_TESTING=1

RUN echo "===> Installing system dependencies" && \
    apt-get update && \
    apt-get -y upgrade && \
    echo "===> Installing: Perl6 modules" && \
    zef install \
        Test::META \
        TAP::Harness \
        DBIish \
        && \
    zef install \
        Bailador

COPY . .

CMD ["/bin/bash"]
