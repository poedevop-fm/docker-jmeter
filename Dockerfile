FROM fedora:23
MAINTAINER Fatima

RUN dnf -y update
RUN dnf -y install wget
RUN dnf -y install tar
RUN dnf -y install java-1.8.0-openjdk.x86_64
RUN wget http://apache.mediamirrors.org//jmeter/binaries/apache-jmeter-3.0.tgz
RUN tar -xvzf apache-jmeter-3.0.tgz
RUN rm -f apache-jmeter-3.0.tgz
RUN rm -fr /apache-jmeter-3.0/docs
RUN mkdir results
COPY *.jmx ./
COPY *.csv ./

#la commande VOLUME crée un dossier partagé dans le système hote
# de cette façon, le fichier de résultat sera enregistré sur le système hote
# et non dans le container
VOLUME /apache-jmeter-3.0/bin/results

CMD ["/apache-jmeter-3.0/bin/jmeter", "-n", "-t", $(JMX_FILE), "-l", "/results/tests_results.jtl", "-H", "localhost", "-P", "5000"]

