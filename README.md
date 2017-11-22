# crystal-openbsd-port

## Setup:

```
cd /usr/ports/lang
git clone https://github.com/bitfliplabs/crystal-openbsd-port.git crystal
cd crystal
```

## Building:
```
make build
```

## Cleaning:
```
make clean
make clean=all
make clean=depends
make clean=dist
make clean=packages
```

## Packaging:
```
make package
```

# Help:

- [Manual for ports](https://man.openbsd.org/ports)
- [Manual for bsd.port.mk](https://man.openbsd.org/bsd.port.mk)
- [Porters Handbook](https://www.openbsd.org/faq/ports/index.html)
- [Fetch Ports](https://www.openbsd.org/faq/ports/ports.html#PortsFetch)

## Cross Compiling

```
cd root/dir/of/crystal/
make clean && make
.build/crystal build --release --stats --cross-compile --target "amd64-unknown-openbsd" -D without_openssl -D without_zlib -D i_know_what_im_doing src/compiler/crystal.cr
mv crystal.o crystal-0.24.0-amd64-openbsd62.o
tar -cvf crystal-0.24.0-amd64-openbsd62.tar crystal-0.24.0-amd64-openbsd62.o 
gzip -9 crystal-0.24.0-amd64-openbsd62.tar
```
