import XCTest
import JSON
@testable import SwiftLineBot

class SwiftLineBotTests: XCTestCase {
    func testReceivedMessageParseAll() {
        let input = "{\"result\":[ { \"from\":\"u2ddf2eb3c959e561f6c9fa2ea732e7eb8\", \"fromChannel\":1341301815, \"to\":[\"u0cc15697597f61dd8b01cea8b027050e\"], \"toChannel\":1441301333, \"eventType\":\"138311609000106303\", \"id\":\"ABCDEF-12345678901\", \"content\": { \"location\":null, \"id\":\"325708\", \"contentType\":1, \"from\":\"uff2aec188e58752ee1fb0f9507c6529a\", \"createdTime\":1332394961610, \"to\":[\"u0a556cffd4da0dd89c94fb36e36e1cdc\"], \"toType\":1, \"contentMetadata\":null, \"text\":\"Hello, BOT API Server!\" } } ]}"
        let results = ReceivedMessage.parseAll(json: input)
        XCTAssertEqual(results.count, 1)
    }
    
    func testParseReceivedResult() {
        let input = "{ \"from\":\"u2ddf2eb3c959e561f6c9fa2ea732e7eb8\", \"fromChannel\":1341301815, \"to\":[\"u0cc15697597f61dd8b01cea8b027050e\"], \"toChannel\":1441301333, \"eventType\":\"138311609000106303\", \"id\":\"ABCDEF-12345678901\", \"content\": { \"location\":null, \"id\":\"325708\", \"contentType\":1, \"from\":\"uff2aec188e58752ee1fb0f9507c6529a\", \"createdTime\":1332394961610, \"to\":[\"u0a556cffd4da0dd89c94fb36e36e1cdc\"], \"toType\":1, \"contentMetadata\":null, \"text\":\"Hello, BOT API Server!\" } }"
        let json = try! JSONParser().parse(data: Data(input))
        let result = try! ReceivedMessageParser().parse(json: json)
        XCTAssertEqual(result.toChannel, 1441301333)
        let content = result.content as! TextMessageContent
        XCTAssertEqual(content.text, "Hello, BOT API Server!")
    }
    
    func testParseReceivedTextContent() {
        let input = "{ \"location\":null, \"id\":\"325708\", \"contentType\":1, \"from\":\"uff2aec188e58752ee1fb0f9507c6529a\", \"createdTime\":1332394961610, \"to\":[\"u0a556cffd4da0dd89c94fb36e36e1cdc\"], \"toType\":1, \"contentMetadata\":null, \"text\":\"Hello, BOT API Server!\" }"
        let json = try! JSONParser().parse(data: Data(input)).asDictionary()
        let content = try! ReceivedMessageContentParser().parse(json: json)
        let textContent = content as! TextMessageContent
        XCTAssertEqual(textContent.text, "Hello, BOT API Server!")
    }
    
    static var allTests : [(String, (SwiftLineBotTests) -> () throws -> Void)] {
        return [
            ("testReceivedMessageParseAll", testReceivedMessageParseAll),
            ("testParseReceivedResult", testParseReceivedResult),
            ("testParseReceivedTextContent", testParseReceivedTextContent),
        ]
    }
}
