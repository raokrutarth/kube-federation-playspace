# Trial operator SDK development

```bash
docker run --rm \
    --network bridge  \
    -i -t golang:1.11-stretch /bin/bash
```

Trial to see how easy it is to develop an operator with a kube operator sdk.

```bash
mkdir -p $GOPATH/src/github.com/operator-framework
cd $GOPATH/src/github.com/operator-framework
git clone https://github.com/operator-framework/operator-sdk
cd operator-sdk
git checkout master
make dep
make install
```

start a container that has the operator sdk installed.