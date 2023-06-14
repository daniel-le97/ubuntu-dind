FROM kasmweb/ubuntu-jammy-dind:1.13.1-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN apt update
RUN apt -y upgrade
RUN apt -y install ansible
RUN apt -y install wget
RUN wget https://github.com/Eugeny/tabby/releases/download/v1.0.181/tabby-1.0.181-linux-x64.deb
RUN apt --fix-broken install -y
RUN apt -y install ./tabby-1.0.181-linux-x64.deb

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000