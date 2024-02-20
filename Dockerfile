FROM rocker/r-ver:4.3 as base
RUN /rocker_scripts/setup_R.sh \
    https://packagemanager.posit.co/cran/__linux__/jammy/2024-01-01
    # https://code.visualstudio.com/docs/devcontainers/create-dev-container#:~:text=Note%3A%20The%20DEBIAN_FRONTEND%20export%20avoids%20warnings%20when%20you%20go%20on%20to%20work%20with%20your%20container.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y --no-install-recommends \
    libxml2-dev libfontconfig1-dev libcairo2-dev curl libcurl4-openssl-dev \
    libssl-dev libharfbuzz-dev libfribidi-dev \
    libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev

RUN mkdir requirements

# https://github.com/RamiKrispin/sdsu-docker-workshop/tree/main/.devcontainer
COPY install_quarto.sh requirements/
RUN bash ./requirements/install_quarto.sh

# Install main packages for work
RUN install2.r  \
     desc flextable fs here knitr officer quarto \
     stringr markdown checkmate \
     # remove downloaded packages 
     && rm -rf /tmp/downloaded_packages \
     && strip /usr/local/lib/R/site-library/*/libs/*.so

FROM base as development
# https://www.makeuseof.com/install-python-ubuntu/
# install radian
RUN apt-get update
RUN apt-get -y install software-properties-common  
RUN add-apt-repository -y ppa:deadsnakes/ppa && apt-get update 
RUN apt-get -y install python3.11 python3-pip git
RUN pip3 install radian
# end install radian
RUN install2.r --error \
    languageserver httpgd jsonlite rlang

RUN apt-get update
RUN apt-get install -y --no-install-recommends ninja-build gettext cmake unzip curl
RUN git clone https://github.com/neovim/neovim
RUN cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN cd neovim/build && cpack -G DEB && dpkg -i nvim-linux64.deb

RUN install2.r --error \
    simstudy simsurv flexsurv 

RUN install2.r --error \
    usethis devtools

RUN apt-get install -y --noinstall recommends tmux

# Copy Neovim configuration files.

COPY ./config/nvim /root/.config/nvim/

# requirements for some lazyvim language
#RUN apt-get install -y --no-install-recommends wget npm
#RUN apt-get install -y --no-install-recommends ripgrep fd-find
#RUN curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/SourceCodePro.zip
#RUN unzip SourceCodePro.zip -d ~/.font
#RUN fc-cache -fv


RUN nvim --headless +"Lazy! install" +qa
#RUN nvim --headless +"MasonInstall lua-language-server stylua r-languageserver marksman" +q


WORKDIR /project
ENTRYPOINT ["/bin/bash"]


#Run apt-get -y install neovim
