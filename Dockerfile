FROM ubuntu:18.04
WORKDIR /opt/repeatmodeler
ADD ./trf /usr/local/bin
ADD nseg/nseg /usr/local/bin
RUN \
  apt-get update && apt-get -y install \
  build-essential wget hmmer ;\
  cpan JSON URI LWP::UserAgent
RUN \
  wget http://eddylab.org/software/recon/RECON1.05.tar.gz ;\
  tar -xzvf RECON1.05.tar.gz ;\
    cd RECON1.05/src ; make ; make install ; \
    cd ../scripts ; sed -i 's|$path = "";|$path = "/opt/repeatmodeler/RECON1.05/bin";|g' recon.pl ;\
    cd ../../ ;\
  wget http://www.repeatmasker.org/RepeatScout-1.0.5.tar.gz ;\
  tar -xzvf RepeatScout-1.0.5.tar.gz ;\
  cd RepeatScout-1 ;\
  make ;\
  cd .. ; \
  wget http://www.repeatmasker.org/rmblast-2.9.0+-x64-linux.tar.gz ;\
  tar -xzvf rmblast-2.9.0+-x64-linux.tar.gz ;\
  mkdir nseg ;\
    cd nseg ;\
    wget ftp://ftp.ncbi.nih.gov/pub/seg/nseg/* ;\
    make ;\
    cd ../ ;\
  wget http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz


ENV PATH=${PATH}:/opt/repeatmodeler/RECON1.05/scripts\
:/opt/repeatmodeler/RepeatScout-1\
:/opt/repeatmodeler/nseg\
:/opt/repeatmodeler/rmblast-2.9.0

RUN wget http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz ;\
    tar -xzvf RepeatMasker-open-4-0-7.tar.gz ;\
    cd RepeatMasker ; printf "\n\n\n\n4\n/usr/bin/\n\n5\n" | ./configure
RUN wget http://www.repeatmasker.org/RepeatModeler/RepeatModeler-open-1.0.11.tar.gz ;\
    tar -xzvf RepeatModeler-open-1.0.11.tar.gz

#ENV PATH=${PATH}:/opt/repeatmodeler/RepeatMasker
#    cd RepeatModeler-open-1.0.11 ;\
#    perl ./configure

#yes
#yes --- /opt/repeatmodeler/RepeatMasker /opt/repeatmodeler/RECON1.05/bin /opt/repeatmodeler/RepeatScout-1 /opt/repeatmodeler/nseg /usr/local/bin 1 /opt/repeatmodeler/rmblast-2.9.0 -
#redoing the repeatmasker config step to use rmblast

#RUN cpan Text::Soundex
