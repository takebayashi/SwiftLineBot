import JSON

enum ParseError: ErrorProtocol {
    case MalformedJSON
    case InvalidJSON(String)
    case Unsupported(String)
}

extension ReceivedMessage {
    public static func parseAll(json: JSONSource) -> [ReceivedMessage] {
        guard let results = json.asJSON()?.objectValue?["result"]?.arrayValue else {
            return []
        }
        let parser = ReceivedMessageParser()
        return results.flatMap { result in
            do {
                return try parser.parse(json: result)
            }
            catch {
                return nil
            }
        }
    }
}

struct ReceivedMessageParser {
    func parse(json: JSON) throws -> ReceivedMessage {
        guard let toChannel = json["toChannel"]?.doubleValue else {
            throw ParseError.InvalidJSON("toChannel is missing")
        }
        guard let toUsers = json["to"]?.arrayValue?.flatMap({$0.stringValue}) else {
            throw ParseError.InvalidJSON("to is missing")
        }
        guard let type = json["eventType"]?.stringValue, let event = EventType(rawValue: type) else {
            throw ParseError.InvalidJSON("eventType is missing")
        }
        guard let id = json["id"]?.stringValue else {
            throw ParseError.InvalidJSON("id is missing")
        }
        guard let content = json["content"]?.objectValue else {
            throw ParseError.InvalidJSON("content is missing")
        }
        return ReceivedMessage(
            toUsers: toUsers,
            toChannel: Int64(toChannel),
            eventType: event,
            content: try ReceivedMessageContentParser().parse(json: content),
            id: id
        )
    }
}

class ReceivedMessageContentParser {
    func parse(json: [String: JSON]) throws -> ReceivedMessageContent {
        guard let contentTypeValue = json["contentType"]?.integerValue else {
            throw ParseError.InvalidJSON("contentType is missing")
        }
        guard let contentType = ContentType(rawValue: contentTypeValue) else {
            throw ParseError.InvalidJSON("contentType is invalid")
        }
        guard let fromUser = json["from"]?.stringValue else {
            throw ParseError.InvalidJSON("from is missing")
        }
        guard let toUsers = json["to"]?.arrayValue?.flatMap({ $0.stringValue }) else {
            throw ParseError.InvalidJSON("to is missing")
        }
        switch contentType {
        case .text:
            guard let toType = json["toType"]?.integerValue else {
                throw ParseError.InvalidJSON("toType is missing")
            }
            guard let text = json["text"]?.stringValue else {
                throw ParseError.InvalidJSON("text is missing")
            }
            return ReceivedTextMessageContent(
                contentType: contentType,
                fromUser: fromUser,
                toUsers: toUsers,
                toType: toType,
                text: text
            )
        default:
            throw ParseError.Unsupported("content type \(contentType) is not supported yet")
        }
    }
}
