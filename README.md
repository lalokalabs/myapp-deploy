Deployment repo for https://github.com/lalokalabs/myapp.

Make sure [webship](https://github.com/lalokalabs/webship) is properly installed.

## Build
```
podman build -t myapp .
.venv/bin/webship build myapp 1.0.1 --docker-image myapp
```

Test the build:-

```
.venv/bin/webship run build/myapp-1.0.1.tar.gz ".venv/bin/myapp manage runserver 0.0.0.0:8000" --env-file $PWD/.env --docker-image myapp
```
