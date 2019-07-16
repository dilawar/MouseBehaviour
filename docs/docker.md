# Run inside docker

## Check that docker works

Follow [these instruction to install docker](https://docs.docker.com/install).
Also see [these
instructions](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy)
for adding proxy support to docker. To check that docker works fine, execute
following in the terminal.

```bash
$ docker run hello-world
```

I saw the following output.

```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
1b930d010525: Pull complete 
Digest: sha256:6540fc08ee6e6b7b63468dc3317e3303aae178cb8a45ed3123180328bcc1d20f
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```

# Run docker

The image is `bhallalab/mousebehaviour`. We can not just run this image, we have
to make sure that docker can access devices connected to host computer. As well
as we have to make sure that data collected inside the docker is saved on the
host computer. 

__NOTE__: Type `xhost +` once in the terminal. This makes docker to access
graphics. You have to do it just once.

```bash
xhost +   # once 
docker run --rm \
    --net=host --privileged \
    -v /dev:/dev \
    -e DISPLAY=$(DISPLAY) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $(HOME)/.Xauthority:/root/.Xauthority \
    -v $(HOME)/DATA:/root/DATA \
    -it bhallalab/mousebehaviour
```

And voila, you should see this gui.

![](images/gui_in_docker.png)


