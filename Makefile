VERSION = 0.0.1

.PHONY: build

build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib

xcode:
	swift package generate-xcodeproj --enable-code-coverage

lint:
	swiftlint autocorrect --quiet
	swiftlint lint --quiet

