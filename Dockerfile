FROM centos:7.7.1908

MAINTAINER Sivakumar

RUN yum -y update -y

RUN yum -y install java-1.8.0-openjdk which unzip wget maven git
RUN wget --no-verbose -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN  rpm -v --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
RUN    yum -y install jenkins --nogpgcheck
#RUN    usermod -aG jenkins
RUN    mkdir -m 0755 /nix && chown jenkins /nix
RUN    chown -c jenkins /var/lib/jenkins
#RUN    chsh -s /bin/bash jenkins

USER jenkins

ENV USER jenkins

RUN wget -O /tmp/nix-installer.sh https://nixos.org/nix/install && \
    bash /tmp/nix-installer.sh && \
    . /var/lib/jenkins/.nix-profile/etc/profile.d/nix.sh

EXPOSE 8080

CMD ["java", "-jar", "/usr/lib/jenkins/jenkins.war"]
