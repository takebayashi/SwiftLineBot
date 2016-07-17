public protocol Message {
    var toUsers: [String] { get set }
    var toChannel: Int64 { get set }
    var eventType: Event { get set }
    var content: MessageContent { get set }
}

public struct SendingMessage: Message {
    public var toUsers: [String]
    public var toChannel: Int64
    public var eventType: Event
    public var content: MessageContent
}

public struct ReceivedMessage: Message {
    public var toUsers: [String]
    public var toChannel: Int64
    public var eventType: Event
    public var content: MessageContent
    public var id: String
}

public enum Event: String {
    case sendingMessage = "138311608800106203"
    case sendingMultipleMessage = "140177271400161403"
    case receivingMessage = "138311609000106303"
    case receivingOperation = "138311609100106403"
}
