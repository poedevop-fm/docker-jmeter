FROM alpine
RUN mkdir /test
WORKDIR /test
RUN touch data.csv
VOLUME /test
