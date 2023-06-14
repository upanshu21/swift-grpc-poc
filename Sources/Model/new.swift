public struct HelloRequest {
    public var name: String

    public init(_name: String) {
        self.name = _name
    }

    public func helloworldHelloRequest() -> Helloworld_HelloRequest {
        return Helloworld_HelloRequest.with {
            $0.name = self.name
        }
    }
}

public struct HelloReply {
    public var message: String

    public init(_message: String) {
        self.message = _message
    }

    public func helloworldHelloReply() -> Helloworld_HelloReply {
        return Helloworld_HelloReply.with {
            $0.message = self.message
        }
    }
}

