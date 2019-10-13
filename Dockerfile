FROM silex/emacs:26.3

# Install Go
RUN apt-get update
RUN apt-get -y upgrade
RUN apt install -y wget sudo git
RUN wget https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz
RUN sudo tar -xvf go1.13.1.linux-amd64.tar.gz
RUN sudo mv go /usr/local
ENV GOPATH=$HOME/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
RUN GO111MODULE=on go get golang.org/x/tools/gopls@latest
RUN go get -u -v github.com/rogpeppe/godef
RUN go get -u -v golang.org/x/tools/cmd/guru
RUN go get -u -v golang.org/x/tools/cmd/gorename
RUN go get -u -v golang.org/x/tools/cmd/goimports
RUN rm -rf ~/.emacs.d
RUN git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
RUN cd ~/.emacs.d; git pull; git checkout develop
COPY ./.spacemacs ~/.spacemacs.template
