FROM ubuntu:18.04
WORKDIR /opt/repeatmodeler
ADD ./trf /usr/local/bin

RUN \
  apt-get update && apt-get -y install \
  build-essential wget ; \
  wget http://www.repeatmasker.org/RepeatModeler/RepeatModeler-open-1.0.11.tar.gz ;\
  tar -xzvf RepeatModeler-open-1.0.11.tar.gz ;\
  wget http://eddylab.org/software/recon/RECON1.05.tar.gz ;\
  tar -xzvf RECON1.05.tar.gz ;\
  wget http://www.repeatmasker.org/RepeatScout-1.0.5.tar.gz ;\
  tar -xzvf RepeatScout-1.0.5.tar.gz ;\
  wget http://www.repeatmasker.org/rmblast-2.9.0+-x64-linux.tar.gz ;\
  tar -xzvf rmblast-2.9.0+-x64-linux.tar.gz ;\
  mkdir nseg ;\
    cd nseg ;\
    wget ftp://ftp.ncbi.nih.gov/pub/seg/nseg/* ;\
    make ;\
    cd .. ;\
