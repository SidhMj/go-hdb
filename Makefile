# builds and tests project via go tools
all:
	@echo "update dependencies"
	GOTOOLCHAIN=go1.20.7 go get -u ./...
	GOTOOLCHAIN=go1.20.7 go mod tidy
	@echo "build and test"
	GOTOOLCHAIN=go1.20.7 go build -v ./...
	GOTOOLCHAIN=go1.20.7 go vet ./...
	GOTOOLCHAIN=go1.20.7 golint -set_exit_status=true ./...
	GOTOOLCHAIN=go1.20.7 staticcheck -checks all -fail none ./...
	@echo execute tests on last supported go version
	GOTOOLCHAIN=go1.20.7 go test ./...
#see fsfe reuse tool (https://git.fsfe.org/reuse/tool)
	@echo "reuse (license) check"
	pipx run reuse lint

#install additional tools
tools:
#install linter
	@echo "install latest go linter version"
	go install golang.org/x/lint/golint@latest
#install staticcheck
	@echo "install latest staticcheck version"
	go install honnef.co/go/tools/cmd/staticcheck@latest

#install supported go version
go:
	go install golang.org/dl/go1.20.7@latest
	go1.20.7 download
