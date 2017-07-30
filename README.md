# asdf-alpine

This repo provides Dockerized versions of [asdf] supported tool sets.

An image can provide one or more asdf tools, you can for example create a image
with just erlang, or erlang+elixir or erlang+elixir+node, basically anything
that asdf supports.

There's also an [asdf-ubuntu](https://github.com/vic/asdf-ubuntu) sister repo.

## Images

The list of [built][builds] images can be found at [dockerhub] and you can find their [source branch][branches] on github.


| Status | Dockerfile |
|--------|------------|
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/elixir-1.4.4-otp-19.svg)](https://github.com/vborja/asdf-alpine/tree/elixir-1.4.4-otp-19)| [`FROM vborja/asdf-alpine:elixir-1.4.4-otp-19`](https://github.com/vborja/asdf-alpine/blob/elixir-1.4.4-otp-19/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/elixir-1.4.5-otp-19.svg)](https://github.com/vborja/asdf-alpine/tree/elixir-1.4.5-otp-19)| [`FROM vborja/asdf-alpine:elixir-1.4.5-otp-19`](https://github.com/vborja/asdf-alpine/blob/elixir-1.4.5-otp-19/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/elixir-1.4.5-otp-20.svg)](https://github.com/vborja/asdf-alpine/tree/elixir-1.4.5-otp-20)| [`FROM vborja/asdf-alpine:elixir-1.4.5-otp-20`](https://github.com/vborja/asdf-alpine/blob/elixir-1.4.5-otp-20/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/elixir-1.5.0-nodejs-8.2.1.svg)](https://github.com/vborja/asdf-alpine/tree/elixir-1.5.0-nodejs-8.2.1)| [`FROM vborja/asdf-alpine:elixir-1.5.0-nodejs-8.2.1`](https://github.com/vborja/asdf-alpine/blob/elixir-1.5.0-nodejs-8.2.1/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/elixir-1.5.0-otp-20.svg)](https://github.com/vborja/asdf-alpine/tree/elixir-1.5.0-otp-20)| [`FROM vborja/asdf-alpine:elixir-1.5.0-otp-20`](https://github.com/vborja/asdf-alpine/blob/elixir-1.5.0-otp-20/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/elixir-1.5.0-rc.2-otp-20.svg)](https://github.com/vborja/asdf-alpine/tree/elixir-1.5.0-rc.2-otp-20)| [`FROM vborja/asdf-alpine:elixir-1.5.0-rc.2-otp-20`](https://github.com/vborja/asdf-alpine/blob/elixir-1.5.0-rc.2-otp-20/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/erlang-19.3.svg)](https://github.com/vborja/asdf-alpine/tree/erlang-19.3)| [`FROM vborja/asdf-alpine:erlang-19.3`](https://github.com/vborja/asdf-alpine/blob/erlang-19.3/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/erlang-20.0.svg)](https://github.com/vborja/asdf-alpine/tree/erlang-20.0)| [`FROM vborja/asdf-alpine:erlang-20.0`](https://github.com/vborja/asdf-alpine/blob/erlang-20.0/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/master.svg)](https://github.com/vborja/asdf-alpine/tree/master)| [`FROM vborja/asdf-alpine:master`](https://github.com/vborja/asdf-alpine/blob/master/Dockerfile) |
| [![Travis branch](https://img.shields.io/travis/vic/asdf-alpine/nodejs-8.2.1.svg)](https://github.com/vborja/asdf-alpine/tree/nodejs-8.2.1)| [`FROM vborja/asdf-alpine:nodejs-8.2.1`](https://github.com/vborja/asdf-alpine/blob/nodejs-8.2.1/Dockerfile) |


## Build

Images are [built automatically][builds] for every branch and published at [dockerhub].

The `master` branch provides the base [`Dockerfile`][master] for all other branches.
See the [Repo Layout](#repo-layout) section for more information on how to create more
images.

Every branch name *must* be a valid docker tag name that specifies the tool names and 
versions it provides, for example: 

[`erlang-20.0`][erlang-20.0] and [`elixir-1.5.0-rc.2-otp-20`][elixir-1.5.0-rc.2-otp-20]

This way people can either base their own Docker images on them or try any existing
tool set published as an image, like latest elixir:

```
docker run --rm -ti vborja/asdf-alpine:elixir-1.5.0-rc.2-otp-20 iex
```


## Contributing new tool sets or versions.

All contributions are more than welcome, if you'd like to help expanding the number of tools available
as docker images that would be really great!

If you want to create a new version, just start a new branch from the old-version, and send a PR, be sure to
build the image locally and test if the tool works as expected.

If you are adding a new unrelated tool, please create an orphan branch, for example

```shell
git clone https://github.com/vic/asdf-alpine
cd asdf-alpine

# start working on a new node image
git checkout --orphan nodejs-8.2.1
rm * # clean the branch files


echo 'FROM vborja/asdf-alpine' > Dockerfile
# Read the following section about Repo layout

# build it
docker build . -t nodejs-8.2.1

# try it
docker run --rm -ti nodejs-8.2.1 node

# commit and create a new PR when everything is ok.
```

If you create a new branch be sure to add the `.travis.yml` file so that the image
for that branch is built automatically.

## Repo layout

The [`master Dockerfile`][master] from this repo serves as base for all asdf-alpine
images. It's single purpose is to create an `asdf` user with home `/asdf`, add the
asdf shim directory to PATH, along with a `asdf-install-toolset`. 

Your repo can contain as many asdf tools as you want, the following example is
taken from [erlang-20.0] branch.

```
/
  Dockerfile    # 
  
  erlang/       # the directory name must be the same as the tool name.
    version     # stores the erlang version as expected by asdf
    plugin-repo # stores the erlang tool plugin url.
    build-deps  # an script run as root to install system dependencies
    build-env   # an script run as asdf user sourced before asdf install.  
    
  other/        # another tool with the same file structure
```

The `Dockerfile` content typically looks like:

```Dockerfile
FROM vborja/asdf-alpine

# start erlang install
COPY erlang .asdf/toolset/erlang/
USER root
RUN bash .asdf/toolset/erlang/build-deps
USER asdf
RUN asdf-install-toolset erlang

# install other tool if needed
COPY other .asdf/toolset/other/
USER root
RUN bash .asdf/toolset/other/build-deps
USER asdf
RUN asdf-install-toolset other
```

Some images like [elixir-1.5.0-rc.2-otp-20] start from a previous one,
in this case from (erlang 20.0) and just add another tool into it.

[elixir-1.5.0-rc.2-otp-20]: https://github.com/vic/asdf-alpine/tree/elixir-1.5.0-rc.2-otp-20
[erlang-20.0]: https://github.com/vic/asdf-alpine/tree/erlang-20.0
[master]: https://github.com/vic/asdf-alpine/blob/master/Dockerfile
[dockerhub]: https://hub.docker.com/r/vborja/asdf-alpine/tags/
[asdf]: https://github.com/asdf-vm/asdf
[builds]: https://travis-ci.org/vic/asdf-alpine/builds
[multi]: https://docs.docker.com/engine/userguide/eng-image/multistage-build/
[branches]: https://github.com/vic/asdf-alpine/branches
