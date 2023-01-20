FROM ubuntu:22.04

# Set default environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

# Create working directory and relevant dirs
WORKDIR /app

# Install deps from APT
RUN apt-get update && apt-get install -y \
  tzdata \
  wget \
  gpg \
  python3 \ 
  python3-pip \
  chromium-chromedriver \
  xvfb \
  xfonts-cyrillic \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-base \
  xfonts-scalable \
  gtk2-engines-pixbuf \
&& rm -rf /var/lib/apt/lists/*

# Download and install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install -y ./google-chrome-stable_current_amd64.deb

# Install bot Python deps
ADD ./requirements.txt .
RUN pip3 install -r ./requirements.txt

RUN pip3 uninstall --yes chardet && pip3 uninstall --yes urllib3 && pip3 install --upgrade requests --no-input

# Add often-changed files in order to cache above
ADD ./ms_rewards_farmer.py .
ADD ./entrypoint.sh .
ADD ./keep_alive.py .
ADD ./accounts.json .


# Make the entrypoint executable
RUN chmod +x entrypoint.sh

# Set the entrypoint to our entrypoint.sh                                                                                                                     
ENTRYPOINT ["/app/entrypoint.sh"] 