import UIKit

protocol WriteRubyPresenterInput {
    func didTapWriteRubyButton(text: String)
}

protocol WriteRubyPresenterOutput {
    func showRubyAlert(sentences: String, rubySentense: String)
}

class WriteRubyPresenter: WriteRubyPresenterInput {
    
    private var view: WriteRubyPresenterOutput!
    private var model: WriteRubyModelInput

    init(view: WriteRubyPresenterOutput) {
        self.view = view
        self.model = WriteRubyModel()
    }
    
    func didTapWriteRubyButton(text: String) {
        model.fetchRubySentence(sentence: text) { (rubySentense) in
            self.view.showRubyAlert(sentences: text,  rubySentense: rubySentense)
        }
    }
}
