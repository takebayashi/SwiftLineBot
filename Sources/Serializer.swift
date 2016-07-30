import JSON
import C7

extension SendingMessage {
    public func toJSONString() -> String {
        return JSONSerializer().serializeToString(json: toJSON())
    }
    
    public func toJSON() -> JSON {
        var json = [
            "to": JSON.infer(self.toUsers.map { JSON.infer($0) }),
            "toChannel": JSON.infer(Int(self.toChannel)),
            "eventType": JSON.infer(self.eventType.rawValue)
        ]
        switch self.content {
        case let text as SendingTextMessageContent:
            json["content"] = text.toJSON()
        default:
            break
        }
        return JSON.infer(json)
    }
}

extension SendingTextMessageContent {
    func toJSON() -> JSON {
        return JSON.infer([
            "contentType": JSON.infer(self.contentType.rawValue),
            "toType": JSON.infer(self.toType),
            "text": JSON.infer(self.text)
        ])
    }
}