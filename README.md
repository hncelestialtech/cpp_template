# Template for Cpp Project

## Usage

### Docker Image
Run docker compose, it will build the image and run the container.
```bash
docker-compose up -d
```
> Note: The container will be running in the background. And repository will be mounted to the container.

If you want to any dependencies, you can add them in the `Dockerfile` and rebuild the image.
```bash
docker build --no-cache .
```

### Github Action
Change the `repository_url` with your own in the `.chglog/config.yml` file. Otherwise the link will be broken.

```yaml
style: github
template: CHANGELOG.tpl.md
info:
  title: CHANGELOG
  repository_url: https://github.com/hncelestialtech/cpp_template
```
To use the `CHANGELOG` generator, your commit message should be in the following format.
```bash
feat: Add new feature
or
feat(scope): Add new feature
```

Refer to the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for more information.

### CMake and Conan
This project uses CMake and Conan for building and managing dependencies. You can add the dependencies in the `conanfile.txt` file. You can refer to the [Conan Center](https://conan.io/center/) for the available packages.

To build the project, run the following commands.
```bash
make build
```
Also, you can run the tests using the following command.
```bash
make test
```
> Note: The `make` command is a wrapper for the `cmake` and `conan` commands.
> Please remember to use `find_package` in the `CMakeLists.txt` file to include the dependencies. You can refer to the `CMakeLists.txt` file in the `tests` directory.

## Contributing
Use linear issue: [Optimize Build Workflow](https://linear.app/celestial-tech/issue/CEL-133/optimize-build-workflow) to track the progress.