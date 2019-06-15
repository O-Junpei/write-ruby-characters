import UIKit

class WriteRubyViewController: UIViewController {
    var textView: UITextView!
    var clearButton: UIButton!
    var writeRubyButton: UIButton!

    var presenter: WriteRubyPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WriteRubyPresenter(view: self)

        view.backgroundColor = UIColor(named: "backgroundGray")
        navigationController?.navigationBar.barTintColor = UIColor(named: "baseOrange")

        textView = UITextView()
        textView.backgroundColor = .white
        textView.delegate = self
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.textColor = UIColor.gray
        textView.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(textView)
        
        clearButton = UIButton()
        clearButton.setTitle("クリア", for: .normal)
        clearButton.backgroundColor = UIColor(named: "baseOrange")
        clearButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        clearButton.layer.cornerRadius = 16
        clearButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(clearButton)
        
        writeRubyButton = UIButton()
        writeRubyButton.setTitle("ひらがな変換", for: .normal)
        writeRubyButton.backgroundColor = UIColor(named: "baseOrange")
        writeRubyButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        writeRubyButton.layer.cornerRadius = 16
        writeRubyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(writeRubyButton)
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
        writeRubyButton.frame = CGRect(x: width / 2 + margin, y: topSafeAreaHeight + textViewHeight + margin, width: width / 2 - margin * 2, height: rubyButtonHeight)
    }
    
    @objc private func didButtonTap() {
        guard let text = textView.text else {
            return
        }
        textView.resignFirstResponder()
        presenter.didTapWriteRubyButton(text: text)
    }
}

extension WriteRubyViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
    }
}



extension WriteRubyViewController: WriteRubyPresenterOutput {
    func showRubyAlert(sentences: String, rubySentense: String ) {
        let rubyAlertViewController = RubyAlertViewController(rubySentense: rubySentense)
        rubyAlertViewController.modalPresentationStyle = .overCurrentContext
        rubyAlertViewController.modalTransitionStyle = .crossDissolve
        present(rubyAlertViewController, animated: true, completion: nil)
    }
}

