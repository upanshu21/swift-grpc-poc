/*
 * Copyright 2019, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#if compiler(>=5.6)
import ArgumentParser
import GRPC
import NIOCore
import NIOPosix
import HelloWorldModel


protocol HelloService {

    func sayHello(request: HelloRequest) async throws -> HelloReply
    static func createService() -> HelloService
}

@available(macOS 10.15, *)
extension HelloService {
    static func createService() -> HelloService {
        return HelloServiceImpl()
    }
}

@available(macOS 10.15, *)
struct HelloServiceFactory {
    static func createService() -> HelloService {
        return HelloServiceImpl()
    }
}

@available(macOS 10.15, *)
class HelloServiceImpl: HelloService {
    
    func sayHello(request: HelloRequest) async throws -> HelloReply {
        
        let a = HelloRequest(name: "abc")

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
        let grpcReply = try await greeter.sayHello(request)

        // Construct and return HelloReply struct from Helloworld_HelloReply
        return HelloReply(message: grpcReply.message)
    }

    static func createService() -> HelloService {
           return HelloServiceImpl()
       }
}

    
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
@main
struct HelloWorldClient: AsyncParsableCommand {
        @Option(help: "The port to connect to")
        var port: Int = 1234
        
        @Argument(help: "The name to greet")
        var name: String?
        
        func run() async throws {
            // Create service
//            let service: HelloService = HelloServiceFactory.createService()

            // Create request with name provided
            let request = HelloRequest(name: "Joe")

            // Call the sayHello function from the service with the created request
            let reply = try await service.sayHello(request: request)

            // Print the reply message
            print(reply.message)
        }
}

#else
@main
enum HelloWorldClient {
  static func main() {
    fatalError("This example requires swift >= 5.6")
  }
}
#endif // compiler(>=5.6)





