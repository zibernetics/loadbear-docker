FROM maven

RUN yum update -y
RUN yum install wget -y
RUN cd /tmp && \
    wget http://apache.spinellicreations.com/jmeter/binaries/apache-jmeter-5.3.tgz -O jmeter.tgz && \
    mkdir jmeter && \
    tar zxvf jmeter.tgz -C jmeter --strip-components=1 && \
    wget http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/1.4/jmeter-plugins-manager-1.4.jar -O jmeter/lib/ext/jmeter-plugins-manager-1.4.jar && \
    wget http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/2.2/cmdrunner-2.2.jar -O jmeter/lib/cmdrunner-2.2.jar && \
    java -cp jmeter/lib/ext/jmeter-plugins-manager-1.4.jar org.jmeterplugins.repository.PluginManagerCMDInstaller && \
    mv jmeter /jmeter

COPY . /

RUN chmod +x entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
