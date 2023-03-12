.PHONY=build run clean

all: build run

build:
	@podman build -t ontherun .

run: clean
	@podman run -d --rm --name ontherun -p 127.0.0.1:5948:5900 ontherun
	@sleep 4
	@vncviewer 127.0.0.1:5948

sound: clean
	@podman run -d --rm --privileged --name ontherun -p 127.0.0.1:5948:5900 -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id -v /run/user/$$UID/pulse:/run/user/$$UID/pulse -v /var/lib/dbus:/var/lib/dbus ontherun
	@sleep 4
	@vncviewer 127.0.0.1:5948

clean:
	@-podman stop -t 0 ontherun
	@-podman rm -f ontherun
