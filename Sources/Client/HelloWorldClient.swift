import ArgumentParser
import HelloWorldModel

@main
struct HelloWorldClient: AsyncParsableCommand {
    @Option(help: "The port to connect to")
    var port: Int = 1234
    
    @Argument(help: "The name to greet")
    var name: String?
    
    func run() async throws {
        // Create service
        let service: HelloService = HelloServiceFactory.createService()
        
        // Create request with name provided
        let request = HelloRequest(name: "John Doe")
        
        // Call the sayHello function from the service with the created request
        let reply = try await service.sayHello(request: request)
        
        // Print the reply message
        print(reply.message)
    }
}
