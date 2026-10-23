# kubevirt/builder

Build container images used to build, test and release [KubeVirt](https://github.com/kubevirt/kubevirt).

This repository was extracted from `hack/builder/` in kubevirt/kubevirt
([kubevirt/kubevirt#19597](https://github.com/kubevirt/kubevirt/issues/19597)) so the
builder images can be maintained and published per release branch, independently of the
kubevirt merge train — in particular so golang maintenance releases can be tracked on
release branches without hand-publishing images from unmerged changes.

## Images

| image | base |
|---|---|
| `quay.io/kubevirt/builder` | CentOS Stream 9 |
| `quay.io/kubevirt/builder-cs10` | CentOS Stream 10 |
| `quay.io/kubevirt/builder-cross` / `builder-cs10-cross` | the above plus arm64/s390x cross toolchains |

Images are tagged `$(date +%y%m%d%H%M)-$(git rev-parse --short HEAD)` — the build
timestamp and the builder repository commit they were built from. Images are only built
and published from merged commits.

## Branches

`main` tracks kubevirt/kubevirt `main`. A `release-1.x` branch is cut for each kubevirt
release and carries that release's pinned toolchain (go minor version, golangci-lint,
cs9/cs10 variants, …), mirroring kubevirt's own branch structure. Release branches only
ever take low-risk maintenance bumps (for go: patch releases of the pinned minor, until
the stream or the branch EOLs); minor toolchain bumps land on `main` only.

kubevirt/kubevirt consumes these images through the `kubevirt_builder_version` pins in
`hack/dockerized`.

## Usage

```console
make build                          # build CS9 builder + cross images (amd64 arm64 s390x)
make publish                        # build and push them
make build-centos-stream-10         # CS10 variants
make publish-centos-stream-10
```

Environment overrides: `KUBEVIRT_CRI` (`docker`/`podman`, autodetected), `DOCKER_PREFIX`,
`ARCHITECTURES`.
