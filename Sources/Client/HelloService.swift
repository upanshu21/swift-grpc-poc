import Foundation
import GRPC
import NIOCore
import NIOPosix
import HelloWorldModel

protocol HelloService {
    
    func sayHello(request: HelloRequest) async throws -> HelloReply
    static func createService() -> HelloService
}


extension HelloService {
    static func createService() -> HelloService {
        return HelloServiceImpl()
    }
}


struct HelloServiceFactory {
    static func createService() -> HelloService {
        return HelloServiceImpl()
    }
}


class HelloServiceImpl: HelloService {
    
    func sayHello(request: HelloRequest) async throws -> HelloReply {
        
        let channel = try GRPCChannelPool.with(
            target: .host("localhost", port: 1234),
            transportSecurity: .plaintext,
            eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: 1)
        )
        defer {
            try! channel.close().wait()
        }
        
        let greeter = Helloworld_GreeterAsyncClient(channel: channel)
        // Call and await sayHello function on greeter object
        let grpcReply = try await greeter.sayHello(request.helloRequest)
        
        // Construct and return HelloReply struct from Helloworld_HelloReply
        return HelloReply(message: grpcReply.message)
    }
    
    static func createService() -> HelloService {
        return HelloServiceImpl()
    }
}
