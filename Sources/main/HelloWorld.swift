import SwiftProtobuf
import HelloWorldModel

public struct HelloWorld {
    public var name: String
    
    public init(_ name: String) {
        self.name = name
    }
    
    public func helloRequest() -> Helloworld_HelloRequest {

        return Helloworld_HelloRequest.with {
            $0.name = "upanshu"
        }
    }
}



