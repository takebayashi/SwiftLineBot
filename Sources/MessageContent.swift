public protocol MessageContent {
    var contentType: Int { get set }
    var toType: Int  { get set }
}

public protocol SendingMessageContent: MessageContent {
}

public protocol ReceivedMessageContent: MessageContent {
    var fromUser: String { get set }
    var toUsers: [String] { get set }
}

public protocol TextMessageContent: MessageContent {
    var text: String  { get set }
}

public struct SendingTextMessageContent: SendingMessageContent, TextMessageContent {
    public var contentType: Int
    public var toType: Int
    public var text: String
}

public struct ReceivedTextMessageContent: ReceivedMessageContent, TextMessageContent {
    public var contentType: Int
    public var fromUser: String
    public var toUsers: [String]
    public var toType: Int
    public var text: String
}
