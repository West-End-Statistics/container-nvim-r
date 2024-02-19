# Install Quarto and dependencies
# Identify the CPU type (M1 vs Intel)
if [[ $(uname -m) ==  "aarch64" ]] ; then 
  CPU="arm64"
elif [[ $(uname -m) ==  "arm64" ]] ; then
  CPU="arm64"
else
  CPU="amd64"
fi

apt-get install -y --no-install-recommends \
    gdebi-core \
    && rm -rf /var/lib/apt/lists/*
curl -LO "https://quarto.org/download/latest/quarto-linux-${CPU}.deb"
gdebi --non-interactive "quarto-linux-${CPU}.deb"

