// Code generated by Wire protocol buffer compiler, do not edit.
// Source: helloworld.HelloRequest in helloworld.proto
import Foundation
import Wire

/**
 * The request message containing the user's name.
 */
public struct HelloRequest {

    public var name: String
    public var unknownFields: Data = .init()

    public init(name: String) {
        self.name = name
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension HelloRequest : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension HelloRequest : Hashable {
}
#endif

#if swift(>=5.5)
extension HelloRequest : Sendable {
}
#endif

extension HelloRequest : ProtoMessage {

    public static func protoMessageTypeURL() -> Swift.String {
        return "type.googleapis.com/helloworld.HelloRequest"
    }

}

extension HelloRequest : Proto3Codable {

    public init(from reader: Wire.ProtoReader) throws {
        var name: Swift.String = ""

        let token = try reader.beginMessage()
        while let tag = try reader.nextTag(token: token) {
            switch tag {
            case 1: name = try reader.decode(Swift.String.self)
            default: try reader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try reader.endMessage(token: token)

        self.name = name
    }

    public func encode(to writer: Wire.ProtoWriter) throws {
        try writer.encode(tag: 1, value: self.name)
        try writer.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension HelloRequest : Codable {

    public init(from decoder: Swift.Decoder) throws {
        let container = try decoder.container(keyedBy: Wire.StringLiteralCodingKeys.self)
        self.name = try container.decode(Swift.String.self, forKey: "name")
    }

    public func encode(to encoder: Swift.Encoder) throws {
        var container = encoder.container(keyedBy: Wire.StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        if includeDefaults || !self.name.isEmpty {
            try container.encode(self.name, forKey: "name")
        }
    }

}
#endif
