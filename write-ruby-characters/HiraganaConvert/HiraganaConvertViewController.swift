import UIKit
import NVActivityIndicatorView

class HiraganaConvertViewController: UIViewController {
    var textView: UITextView!
    var clearButton: UIButton!
    var convertButton: UIButton!
    var indicator: NVActivityIndicatorView!

    var presenter: HiraganaConvertPresenterInput!
    
    func inject(presenter: HiraganaConvertPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundGray")
        navigationController?.navigationBar.barTintColor = UIColor(named: "baseOrange")

        textView = UITextView()
        textView.backgroundColor = .white
        textView.delegate = self
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.textColor = UIColor.gray
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.autocorrectionType = .no
        view.addSubview(textView)
        
        clearButton = UIButton()
        clearButton.setTitle("クリア", for: .normal)
        clearButton.backgroundColor = UIColor(named: "buttonDisableGray")
        clearButton.isEnabled = false
        clearButton.addTarget(self, action: #selector(didClearButtonTap), for: .touchUpInside)
        clearButton.layer.cornerRadius = 16
        clearButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(clearButton)
        
        convertButton = UIButton()
        convertButton.setTitle("ひらがな変換", for: .normal)
        convertButton.backgroundColor = UIColor(named: "buttonDisableGray")
        convertButton.isEnabled = false
        convertButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        convertButton.layer.cornerRadius = 16
        convertButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(convertButton)
        
        indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 120, height: 120), type: .ballClipRotateMultiple, color: UIColor(named: "baseOrange"), padding: 0)
        view.addSubview(indicator)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
        let topSafeAreaHeight = view.safeAreaInsets.top
        let textViewHeight: CGFloat = 200
        let rubyButtonHeight: CGFloat = 60
        let margin: CGFloat = 16
        
        textView.frame = CGRect(x: 0, y: topSafeAreaHeight, width: width, height: textViewHeight)
        clearButton.frame = CGRect(x: margin, y: topSafeAreaHeight + textViewHeight + margin, width: width / 2 - margin * 2, height: rubyButtonHeight)
        convertButton.frame = CGRect(x: width / 2 + margin, y: topSafeAreaHeight + textViewHeight + margin, width: width / 2 - margin * 2, height: rubyButtonHeight)
        indicator.center = view.center
    }
    
    @objc private func didClearButtonTap() {
        presenter.didTapClearButton()
    }
    
    @objc private func didButtonTap() {
        guard let text = textView.text else {
            return
        }
        presenter.didTapConvertButton(text: text)
    }
}

extension HiraganaConvertViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else {
            return
        }
        presenter.textViewDidChange(text: text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return presenter.textViewReplacementText(text: text)
    }
}

extension HiraganaConvertViewController: HiraganaConvertPresenterOutput {

    func hideKeyBoard() {
        textView.resignFirstResponder()
    }
    
    func updateClearButtonEnabled(isEnabled: Bool) {
        if isEnabled {
            clearButton.isEnabled = true
            clearButton.backgroundColor = UIColor(named: "baseOrange")
        } else {
            clearButton.isEnabled = false
            clearButton.backgroundColor = UIColor(named: "buttonDisableGray")
        }
    }
    
    func updateConvertButtonEnabled(isEnabled: Bool) {
        if isEnabled {
            convertButton.isEnabled = true
            convertButton.backgroundColor = UIColor(named: "baseOrange")
        } else {
            convertButton.isEnabled = false
            convertButton.backgroundColor = UIColor(named: "buttonDisableGray")
        }
    }
    
    func updateTextViewText(text: String) {
        textView.text = text
    }
    
    func updateIndicatorAnimating(isStart: Bool) {
        if isStart {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
    
    func presentToRubyAlertViewController(hiragana: String ) {
        let rubyAlertViewController = HiraganaAlertViewController(hiragana: hiragana)
        rubyAlertViewController.modalPresentationStyle = .overCurrentContext
        rubyAlertViewController.modalTransitionStyle = .crossDissolve
        present(rubyAlertViewController, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "エラー", message: "ふりがなへの変換に失敗しました。", preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true)
    }
}

