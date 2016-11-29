FROM fedora:23
MAINTAINER Fatima

RUN dnf -y update
RUN dnf -y install wget
RUN dnf -y install tar
RUN dnf -y install java-1.8.0-openjdk.x86_64
RUN wget http://apache.mediamirrors.org//jmeter/binaries/apache-jmeter-3.1.tgz
RUN tar -xvzf apache-jmeter-3.1.tgz
RUN rm -f apache-jmeter-3.1.tgz
RUN rm -fr /apache-jmeter-3.1/docs
RUN mkdir results
COPY *.jmx ./
COPY *.csv ./

#la commande VOLUME crée un dossier partagé dans le système hote
# de cette façon, le fichier de résultat sera enregistré sur le système hote
# et non dans le container
VOLUME /apache-jmeter-3.1/bin/results



#version formateur
#CMD ["/apache-jmeter-3.1/bin/jmeter", "-n", "-Jjmeter.save.saveservice.output_format=xml", "-Jjmeter.save.saveservice.assertion_results=all", "-Jjmeter.save.saveservice.response_data=true", "-Jjmeter.save.saveservice.autoflush=true", "-t", "csrf_token_csv_data.jmx", "-l", "/results/tests_results.jtl", "-H", "localhost", "-P", "5000"]
#version freddy
ENTRYPOINT ["/apache-jmeter-3.1/bin/jmeter", "-n", "-Jjmeter.save.saveservice.output_format=xml", "-Jjmeter.save.saveservice.assertion_results=all", "-Jjmeter.save.saveservice.response_data=true", "-Jjmeter.save.saveservice.autoflush=true", "-t", "csrf_token_csv_data.jmx", "-l", "/results/tests_results.jtl"]
CMD ["-H", "localhost", "-P", "5000"]