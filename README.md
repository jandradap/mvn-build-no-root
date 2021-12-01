# mvn-build-no-root

## Example how to use this Docker image using Gitlab CI

.gitlab-ci.yml

```yml
stages:
  - build

java-maven-3.5.4-jdk-8-alpine-job:
  image: jtim/maven-non-root:3.5.4-jdk-8-alpine
  stage: build
  script:
    - whoami
    - java -version
    - mvn -v
    - mvn clean package
```