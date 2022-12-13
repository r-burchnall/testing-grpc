
install_prereqs:
	brew install go
	go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
	PATH="$PATH:$(go env GOPATH)/bin"  protoc --go_out=. --go_opt=paths=source_relative \
  		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
        helloworld/helloworld.proto

#https://docs.buf.build/installation
build_server:
	mkdir -p ./platform/pkg/hello-world/
	protoc --go_out=platform/pkg/hello-world \
		--go_opt=paths=source_relative \
  		--go-grpc_out=platform/pkg/hello-world \
  		--go-grpc_opt=paths=source_relative \
        protos/hello-world.proto

build_client:
	mkdir -p ./platform/pkg/hello-world/
	protoc --go_out=platform/pkg/hello-world \
		--go_opt=paths=source_relative \
  		--go-grpc_out=platform/pkg/hello-world \
  		--go-grpc_opt=paths=source_relative \
        protos/hello-world.proto

