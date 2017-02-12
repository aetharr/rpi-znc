This build of ZNC is simple to setup, it already has a config file built in that you can tweak after the fact if you create a volume (Use of a volume is not required, but is recommended).

This has been tested on a Raspberry Pi 3 running Docker 1.11.1
[Github Repository](https://github.com/aetharr/rpi-znc)

## Running the bouncer
`docker run -d -p 8080:8080 aetharr/rpi-znc`

## Regarding the Config File
When the container has been run for the first time, it will detect whether there is a config file in the appropriate place and if not, add the default one. 
This allows you to specify one using a volume for easier access if you wish. It will not create one if a `ZNC.conf` file already exists.

## Using a Volume
If you'd like to map the ZNC config directory to one of your choosing, you can make use of a volume, simple amend the command as such.
`docker run -d  -v $HOME/znc:/home/znc/.znc -p 8080:8080 aetharr/rpi-znc`

## Going Forward
To configure the bouncer while running, visit `http://<hostname>:8080`
The default login details are:
`u: admin p: password`

To connect an IRC client to the bouncer, you can connect to `http://<hostname>:8080` too for simplicity.