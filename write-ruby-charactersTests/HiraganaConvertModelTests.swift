import XCTest
@testable import write_ruby_characters

class HiraganaConvertModelTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchRubySentence() {
        // 今日はいい天気です を渡すと きょうは いい てんきです が返る
        let exp = expectation(description: "Model Test")

        let model = HiraganaConvertModel()
        model.fetchRubySentence(sentence: "今日はいい天気です") { (sentence) in
            guard let sentence = sentence else {
                XCTFail()
                return
            }
            XCTAssertEqual(sentence, "きょうは いい てんきです")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10.0)
    }
}
