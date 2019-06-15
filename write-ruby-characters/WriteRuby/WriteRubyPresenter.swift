import UIKit

protocol WriteRubyPresenterInput {
    func didTapWriteRubyButton(text: String)
}

protocol WriteRubyPresenterOutput {
    func showAlert(ruby: String, text: String)
}

class WriteRubyPresenter: WriteRubyPresenterInput {
    
    private var view: WriteRubyPresenterOutput!
    private var model: WriteRubyModelInput

    init(view: WriteRubyPresenterOutput) {
        self.view = view
        self.model = WriteRubyModel()
    }
    
    func didTapWriteRubyButton(text: String) {
        print("didTapSearchBuutton")
        
        model.fetchRubySentence(sentence: "今日は良い電気です") { (hiragana) in
            
        }
        
        self.view.showAlert(ruby: text, text: "Text")
    }
}
