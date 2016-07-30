public protocol Message {
    var toUsers: [String] { get set }
    var toChannel: Int64 { get set }
    var eventType: EventType { get set }
    var content: MessageContent { get set }
}

public struct SendingMessage: Message {
    public var toUsers: [String]
    public var toChannel: Int64
    public var eventType: EventType
    public var content: MessageContent
    
    public init(toUsers: [String], toChannel: Int64, eventType: EventType, content: MessageContent) {
        self.toUsers = toUsers
        self.toChannel = toChannel
        self.eventType = eventType
        self.content = content
    }
}

public struct ReceivedMessage: Message {
    public var toUsers: [String]
    public var toChannel: Int64
    public var eventType: EventType
    public var content: MessageContent
    public var id: String
}

public enum EventType: String {
    case sendingMessage = "138311608800106203"
    case sendingMultipleMessage = "140177271400161403"
    case receivingMessage = "138311609000106303"
    case receivingOperation = "138311609100106403"
}

public enum ContentType: Int {
    case text = 1
    case image = 2
    case video = 3
    case audio = 4
    case location = 7
    case sticker = 8
    case contact = 10
}
