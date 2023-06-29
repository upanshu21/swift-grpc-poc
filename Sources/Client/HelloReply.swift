import Foundation
import HelloWorldModel

public struct HelloReply {
    
    let helloReply: Helloworld_HelloReply
    public var message: String { helloReply.message }

    public init(message: String) {
        self.helloReply = Helloworld_HelloReply.with {
            $0.message = message
        }
    }
}
