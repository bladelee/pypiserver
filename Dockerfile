FROM python:3.4

# Build
COPY . /code
WORKDIR /code
RUN python setup.py install
RUN pip install passlib
WORKDIR /
RUN rm -rf /pypiserver

# Data Directory
RUN mkdir -p /data/packages
COPY  htpasswd.txt /data
WORKDIR /data


ENTRYPOINT ["pypi-server"]
CMD ["-p", "80","-P","htpasswd.txt", "-a", "update,download", "packages"]
EXPOSE 80
