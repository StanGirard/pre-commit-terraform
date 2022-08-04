# Pre-commit with Terraform
## Description

This image contains python [pre-commit](https://pre-commit.com/).
It also contains specific tools (e.g. terraform-docs) to run the tool.
[Docker image](https://hub.docker.com/r/stangirard/pre-commit-terraform)

## Tags

I don't push a `latest` tag on this repository. In order to find the version you want, just find your terraform version and find the latest tag for that version.

For example the tag `0.12.29-1` means that it has **Terraform 0.12.29** with the first version of **tflint, tfsec, tfvalidate,etc**.
If there is an update with pre-commit, tflint, etc the tag will be `0.12.29-2` and so on.
It helps ensure that there won't be any changes to existing version.

## Adding missing Terraform or updating tools

If you want to add a missing Terraform version simply add it to the `VERSION` file and open a PR.

If you want to update a tool to it's latest version, modify the Dockerfile, increase the `VERSION-CORE` and open a PR.
## Usage

`docker run --rm -v $(pwd):/data stangirard/pre-commit-terraform pre-commit run -a`

## Example - Use in Gitlab CI

```yaml
.lint:
  stage: lint
  image: stangirard/pre-commit-terraform:0.12.29-1
  variables:
    PRE_COMMIT_HOME: ${CI_PROJECT_DIR}/.cache/pre-commit
  cache:
    paths:
      - ${PRE_COMMIT_HOME}
  script:
    - pre-commit run -a
```

For other CI systems, please check the [pre-commit documentation](https://pre-commit.com/#pre-commitci-example).

## Comments & Issues

If you have comments or detect an issue, please be advised I don't check the docker hub comments.
You can always contact me through the repository.

[Source Code](https://gitlab.com/StanGirard/pre-commit-terraform)
