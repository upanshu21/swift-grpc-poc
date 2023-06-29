# How to generate the structs from .proto file using Wire

Run the following command from the root folder: 

```
  java -jar ./Pods/WireCompiler/compiler.jar \
  "--proto_path=./demo" \
  "--swift_out=./demo"
```

That will generate `HelloRequest.swift` and `HelloReply.swift` files inside the `demo` folder.

