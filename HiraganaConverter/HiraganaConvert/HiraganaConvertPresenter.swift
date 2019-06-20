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
    func updateIndicatorAnimating(isStart: Bool)
    func presentToRubyAlertViewController(hiragana: String)
    func showErrorAlert()
}

class HiraganaConvertPresenter: HiraganaConvertPresenterInput {

    private var view: HiraganaConvertPresenterOutput!
    private var model: HiraganaConvertModelInput

    init(view: HiraganaConvertPresenterOutput, model: HiraganaConvertModel) {
        self.view = view
        self.model = model
    }
    
    func didTapClearButton() {
        view.updateTextViewText(text: "")
        view.updateClearButtonEnabled(isEnabled: false)
        view.updateConvertButtonEnabled(isEnabled: false)
    }
    
    func didTapConvertButton(text: String) {
        view.updateIndicatorAnimating(isStart: true)
        model.fetchRubySentence(sentence: text) { (rubySentense) in
            self.view.hideKeyBoard()
            self.view.updateIndicatorAnimating(isStart: false)
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
