#!/usr/bin/env bash
#
# Builder image defaults and container runtime detection.
# The CRI detection was extracted from kubevirt/kubevirt hack/common.sh
# when this repository was split out of hack/builder.

determine_cri_bin() {
    if [ "${KUBEVIRT_CRI}" = "podman" ]; then
        echo podman
    elif [ "${KUBEVIRT_CRI}" = "docker" ]; then
        echo docker
    else
        if podman ps >/dev/null 2>&1; then
            echo podman
        elif docker ps >/dev/null 2>&1; then
            echo docker
        else
            echo ""
        fi
    fi
}

fail_if_cri_bin_missing() {
    if [ -z "${KUBEVIRT_CRI}" ]; then
        echo >&2 "no working container runtime found. Neither docker nor podman seems to work."
        exit 1
    fi
}

KUBEVIRT_CRI="$(determine_cri_bin)"

DOCKER_PREFIX=${DOCKER_PREFIX:-"quay.io/kubevirt"}
DOCKER_IMAGE=${DOCKER_IMAGE:-"builder"}
DOCKER_CROSS_IMAGE=${DOCKER_CROSS_IMAGE:-"builder-cross"}
DOCKER_CS10_IMAGE=${DOCKER_CS10_IMAGE:-"builder-cs10"}
DOCKER_CS10_CROSS_IMAGE=${DOCKER_CS10_CROSS_IMAGE:-"builder-cs10-cross"}

ARCHITECTURES=${ARCHITECTURES:-"amd64 arm64 s390x"}
