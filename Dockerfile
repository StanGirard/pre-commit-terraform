FROM alpine:3.16

ARG RELEASE

ENV BASH_VERSION=5.1.4-r0 \
    CACERTIFICATES_VERSION=20191127-r5 \
    GCC_VERSION=10.3.1_git20210424-r2 \
    GIT_VERSION=2.32.0-r0 \
    HELM_VERSION=3.6.3 \
    MUSL_DEV_VERSION=1.2.2-r3 \
    PERL_VERSION=5.32.1-r0 \
    PRE_COMMIT_VERSION=2.20.0 \
    PYTHON3_VERSION=3.9.5-r2 \
    PYTHON3_PIP_VERSION=20.3.4-r1 \
    TERRAFORM_VERSION=${RELEASE} \
    TERRAFORM_DOCS_VERSION=v0.16.0

VOLUME /data
ADD ./resources /resources

RUN /resources/build && rm -rf /resources

WORKDIR /data

LABEL "maintainer"="stan@primates.dev" \
    "org.label-schema.name"="pre-commit" \
    "org.label-schema.base-image.name"="docker.io/library/alpine" \
    "org.label-schema.base-image.version"="3.14" \
    "org.label-schema.description"="pre-commit in a container" \
    "org.label-schema.url"="https://pre-commit.com/" \
    "org.label-schema.applications.bash.version"=$BASH_VERSION \
    "org.label-schema.applications.ca-certificates.version"=$CACERTIFICATES_VERSION \
    "org.label-schema.applications.helm.version"=$HELM_VERSION \
    "org.label-schema.applications.git.version"=$GIT_VERSION \
    "org.label-schema.applications.perl.version"=$PERL_VERSION \
    "org.label-schema.applications.pre-commit.version"=$PRE_COMMIT_VERSION \
    "org.label-schema.applications.python3.version"=$PYTHON3_VERSION \
    "org.label-schema.applications.python3_pip.version"=$PYTHON3_PIP_VERSION \
    "org.label-schema.applications.terraform.version"=$TERRAFORM_VERSION \
    "org.label-schema.applications.terraform-docs.version"=$TERRAFORM_DOCS_VERSION \
    "org.label-schema.applications.tflint.version"=$TFLINT_VERSION \
    "org.label-schema.applications.tfsec.version"=$TFSEC_VERSION \
    "org.label-schema.usage"="docker run stangirard/pre-commit-terraform pre-commit run"
