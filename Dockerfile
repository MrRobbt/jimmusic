FROM node:12.19-slim

ENV USER=jimmusic

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create jimmusic user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/jimmusic -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/jimmusic

COPY package*.json ./
RUN npm install
VOLUME [ "/home/jimmusic" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
