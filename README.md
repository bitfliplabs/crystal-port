# Crystal OpenBSD Port
OpenBSD port of [crystal](https://github.com/crystal-lang/crystal); a Ruby-like, statically typed, object oriented, language. This port also includes [shards](https://github.com/crystal-lang/shards) a dependancy manager for Crystal.

## Pre-Built:
```
pkg_add -D unsigned https://github.com/chris-huxtable/crystal-port/releases/download/v0.25.1/crystal-0.25.1.tgz
```

## Setup:
On OpenBSD [with ports installed](https://www.openbsd.org/faq/ports/ports.html#PortsFetch):
```
cd /usr/ports/lang
git clone https://github.com/bitfliplabs/crystal-port.git crystal
cd crystal
```

## Dependencies:
Easier and faster to add from ports then by compilation:
```
pkg_add gmake libiconv boehm-gc libevent llvm pcre libyaml bash
```

## Cross Compiling
On MacOS/Linux:
```
cd root/dir/of/crystal/
make clean && make
.build/crystal build --release --cross-compile --target "amd64-unknown-openbsd6.3" -D i_know_what_im_doing src/compiler/crystal.cr
mv crystal.o crystal-v0.25.1.o
tar -cvf crystal-v0.25.1-object.tar crystal-v0.25.1.o
gzip -9 crystal-v0.25.1-object.tar
```

## Updating Port
```
make clean=all
make makesum
make
make update-plist
make package
```

## Help:
- [Manual for ports](https://man.openbsd.org/ports)
- [Manual for bsd.port.mk](https://man.openbsd.org/bsd.port.mk)
- [Porters Handbook](https://www.openbsd.org/faq/ports/index.html)
