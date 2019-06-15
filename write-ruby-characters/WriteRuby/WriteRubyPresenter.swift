import UIKit

protocol WriteRubyPresenterInput {
    func didTapWriteRubyButton(text: String)
}

protocol WriteRubyPresenterOutput {
    func showAlert(ruby: String, text: String)
}

class WriteRubyPresenter: WriteRubyPresenterInput {
    
    private var view: WriteRubyPresenterOutput!

    init(view: WriteRubyPresenterOutput) {
        self.view = view
    }
    
    func didTapWriteRubyButton(text: String) {
        print("didTapSearchBuutton")
        self.view.showAlert(ruby: text, text: "Text")
    }
}
