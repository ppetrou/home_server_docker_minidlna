FROM debian:latest

LABEL maintainer="ppetrou@gmail.com"

RUN groupadd minidlna
RUN useradd -M minidlna -g minidlna

RUN apt-get update
RUN apt-get install -y libexif-dev libjpeg-dev libid3tag0-dev libflac++-dev libvorbis-dev libsqlite3-dev libavformat-dev gettext gcc make net-tools wget

RUN wget https://downloads.sourceforge.net/project/minidlna/minidlna/1.2.1/minidlna-1.2.1.tar.gz
RUN tar xvf minidlna-1.2.1.tar.gz

RUN ["/bin/bash", "-c", "cd minidlna-1.2.1; ./configure && make && make install"]

COPY --chown=minidlna:minidlna minidlna.conf /etc/

EXPOSE 8200

ENTRYPOINT /usr/local/sbin/minidlnad -d -u minidlna -f /etc/minidlna.conf

