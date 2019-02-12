FROM postgres:11.1

# Install the wait-for-it package, which will be used in the setup script.
RUN apt-get update -y
RUN apt-get install -y wait-for-it

# Copy the listen script to the container.
COPY listen.sh /listen.sh
RUN chmod +x /listen.sh