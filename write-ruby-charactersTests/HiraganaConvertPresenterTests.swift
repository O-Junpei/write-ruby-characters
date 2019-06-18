import XCTest
@testable import write_ruby_characters

class MockHiraganaConvertView {
    var text = ""
    var hiragana = ""
    var presenter: HiraganaConvertPresenterInput!
    
    func inject(presenter: HiraganaConvertPresenterInput) {
        self.presenter = presenter
    }
}

extension MockHiraganaConvertView: HiraganaConvertPresenterInput {
    func didTapClearButton() {
        presenter.didTapClearButton()
    }
    
    func didTapConvertButton(text: String) {
        presenter.didTapConvertButton(text: text)
    }
    
    func textViewDidChange(text: String) {}
    
    func textViewReplacementText(text: String) -> Bool {
        return true
    }
}

extension MockHiraganaConvertView: HiraganaConvertPresenterOutput {
    func hideKeyBoard() {}
    
    func updateClearButtonEnabled(isEnabled: Bool) {}
    
    func updateConvertButtonEnabled(isEnabled: Bool) {}
    
    func updateTextViewText(text: String) {
        self.text = text
    }
    
    func updateIndicatorAnimating(isStart: Bool) {}
    
    func presentToRubyAlertViewController(hiragana: String) {
        self.hiragana = hiragana
    }
    
    func showErrorAlert() {}
}


class HiraganaConvertPresenterTests: XCTestCase {
    
    let view = MockHiraganaConvertView()
    let model = HiraganaConvertModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDidTapClearButton() {
        // text が空になることをアサート
        let presenter = HiraganaConvertPresenter(view: view, model: model)
        view.inject(presenter: presenter)
        
        view.text = "Hello World"
        view.didTapClearButton()
        print(view.text)
        XCTAssertTrue(view.text.isEmpty)
    }
    
    func testDidTapConvertButton() {
        
        // hurigana に きょうは いい てんきです が入る
        let presenter = HiraganaConvertPresenter(view: view, model: model)
        view.inject(presenter: presenter)
        
        view.didTapConvertButton(text: "今日はいい天気です")

        let exp = expectation(description: "DidTapConvertButton Test")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertEqual(self.view.hiragana, "きょうは いい てんきです")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
    }
}
