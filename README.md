# asdf-alpine

This repo provides Dockerized versions of [asdf] supported tool sets.

An image can provide one or more asdf tools, you can for example create a image
with just erlang, or erlang+elixir or erlang+elixir+node, basically anything
that asdf supports.

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

## Images

The following is a list of existing images with pre-installed toolsets. Be sure
to add yours once your pull-request and image have been published to dockerhub.


##### Elixir
- [`elixir-1.5.0-rc.2-otp-20`](https://github.com/vic/asdf-alpine/tree/elixir-1.5.0-rc.2-otp-20)

##### Erlang
- [`erlang-20.0`](https://github.com/vic/asdf-alpine/tree/erlang-20.0)


## Contributing new tool sets or versions.

If you are adding a new tool, please create an orphan branch, for example

```shell
git clone https://github.com/vic/asdf-alpine
cd asdf-alpine

# start working on a new node image
git checkout --orphan nodejs-8.2.1
rm * # clean the branch files
echo 'FROM vborja/asdf-alpine' > Dockerfile
# Read the following section and edit your .tool-* files 

# build it
docker build . -t nodejs-8.2.1

# try it
docker run --rm -ti nodejs-8.2.1 node

# commit and create a new PR when everything is ok.
```

## Repo layout

The [`master Dockerfile`][master] from this repo serves as base for all asdf-alpine
images. It's single purpose is to create an `asdf` user with home `/asdf`, copy
the following files from the build environment:

### Tool Files

- `.tool-versions` 
    A tipical asdf tool-versions file, following the same format as specified in the
    asdf readme. You can list as many tools as you need.
    
    Example:
```
erlang 20.0
elixir 1.5.0-rc.1@otp-20
```
    
- `.tool-repo` 
    This file contains the list of plugins that will be used on the image
    
```
erlang https://github.com/asdf-vm/asdf-erlang.git
elixir https://github.com/asdf-vm/asdf-elixir.git
```
    
- `.tool-deps`
    This should be an executable script that is run as `root` and it must
    install all build/runtime dependencies for your toolset.
    
- `.tool-env` 
    An script that will be sourced as `asdf` user just before doing `asdf install`
    You can use it to set environment variables needed for building.

For a working example see the files at [elixir-1.5.0-rc.2-otp-20] branch.


[elixir-1.5.0-rc.2-otp-20]: https://github.com/vic/asdf-alpine/tree/elixir-1.5.0-rc.2-otp-20
[erlang-20.0]: https://github.com/vic/asdf-alpine/tree/erlang-20.0
[master]: https://github.com/vic/asdf-alpine/blob/master/Dockerfile
[dockerhub]: https://hub.docker.com/r/vborja/asdf-alpine/tags/
[asdf]: https://github.com/asdf-vm/asdf
[builds]: https://hub.docker.com/r/vborja/asdf-alpine/builds/
[multi]: https://docs.docker.com/engine/userguide/eng-image/multistage-build/
