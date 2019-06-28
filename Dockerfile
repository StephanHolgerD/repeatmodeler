FROM ubuntu:18.04
WORKDIR /opt/repeatmodeler
ADD ./trf /usr/local/bin
ADD nseg/nseg /usr/local/bin
RUN \
  apt-get update && apt-get -y install \
  build-essential wget hmmer ;\
  cpan JSON URI LWP::UserAgent Text::Soundex ;\
  wget http://www.repeatmasker.org/RepeatModeler/RECON-1.08.tar.gz &&\
  tar -xzvf RECON-1.08.tar.gz && \
    cd RECON-1.08/src ; make ; make install ; \
    cd ../scripts ; sed -i 's|$path = "";|$path = "/opt/repeatmodeler/RECON-1.08/bin";|g' recon.pl ;\
    cd ../../ ;\
  wget http://www.repeatmasker.org/RepeatScout-1.0.5.tar.gz && \
  tar -xzvf RepeatScout-1.0.5.tar.gz && \
  cd RepeatScout-1 && \
  make ;\
  cd .. ; \
  wget http://www.repeatmasker.org/rmblast-2.9.0+-x64-linux.tar.gz ;\
  tar -xzvf rmblast-2.9.0+-x64-linux.tar.gz ;\
  wget http://www.repeatmasker.org/RepeatMasker-open-4-0-7.tar.gz ;\
  tar -xzvf RepeatMasker-open-4-0-7.tar.gz ;\

  cd RepeatMasker ; printf "\n\n\n\n2\n/opt/repeatmodeler/rmblast-2.9.0\n\n5\n" | ./configure ;\
  cd .. ;\
  wget http://www.repeatmasker.org/RepeatModeler/RepeatModeler-open-1.0.11.tar.gz ;\
  tar -xzvf RepeatModeler-open-1.0.11.tar.gz ;\
  cd RepeatModeler-open-1.0.11 ;\
  printf "\n\n\n/opt/repeatmodeler/RepeatMasker\n/opt/repeatmodeler/RECON-1.08/bin\n/opt/repeatmodeler/RepeatScout-1\n/usr/local/bin\n/usr/local/bin\n1\n/opt/repeatmodeler/rmblast-2.9.0\n\n3\n" | perl ./configure ;\
  cd .. ;\
  rm *gz
ENV PATH=$PATH:/opt/repeatmodeler/RepeatModeler-open-1.0.11
WORKDIR /data
