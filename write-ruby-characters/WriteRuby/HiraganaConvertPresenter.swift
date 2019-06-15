import UIKit

protocol HiraganaConvertPresenterInput {
    func didTapClearButton()
    func didTapConvertButton(text: String)
    func textViewDidChange(text: String)
    func textViewReplacementText(text: String) -> Bool
}

protocol HiraganaConvertPresenterOutput {
    func hideKeyBoard()
    func updateClearButtonEnabled(isEnabled: Bool)
    func updateConvertButtonEnabled(isEnabled: Bool)
    func updateTextViewText(text: String)
    func presentToRubyAlertViewController(hiragana: String)
    func showErrorAlert()
}

class HiraganaConvertPresenter: HiraganaConvertPresenterInput {

    private var view: HiraganaConvertPresenterOutput!
    private var model: HiraganaConvertModelInput

    init(view: HiraganaConvertPresenterOutput) {
        self.view = view
        self.model = HiraganaConvertModel()
    }
    
    func didTapClearButton() {
        view.updateTextViewText(text: "")
        view.updateClearButtonEnabled(isEnabled: false)
        view.updateConvertButtonEnabled(isEnabled: false)
    }
    
    func didTapConvertButton(text: String) {
        model.fetchRubySentence(sentence: text) { (rubySentense) in
            self.view.hideKeyBoard()
            guard let rubySentense = rubySentense else {
                self.view.showErrorAlert()
                return
            }
            self.view.presentToRubyAlertViewController(hiragana: rubySentense)
        }
    }
    
    func textViewDidChange(text: String) {
        if text.isEmpty {
            view.updateClearButtonEnabled(isEnabled: false)
            view.updateConvertButtonEnabled(isEnabled: false)
        } else {
            view.updateClearButtonEnabled(isEnabled: true)
            view.updateConvertButtonEnabled(isEnabled: true)
        }
    }
    
    func textViewReplacementText(text: String) -> Bool {
        if text == "\n" {
            view.hideKeyBoard()
            return false
        }
        return true
    }
}
