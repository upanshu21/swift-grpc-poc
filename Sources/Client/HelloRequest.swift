import Foundation
import HelloWorldModel

public struct HelloRequest {
    
    let helloRequest: Helloworld_HelloRequest
    public var name: String { helloRequest.name }
    
    public init(name: String) {
        self.helloRequest = Helloworld_HelloRequest.with {
            $0.name = name
        }
    }
}
