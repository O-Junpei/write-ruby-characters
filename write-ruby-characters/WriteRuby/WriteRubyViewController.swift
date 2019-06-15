import UIKit

class WriteRubyViewController: UIViewController {
    var textView: UITextView!
    var writeRubyButton: UIButton!

    var presenter: WriteRubyPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WriteRubyPresenter(view: self)

        view.backgroundColor = .lightGray

        textView = UITextView()
        textView.backgroundColor = .white
        textView.delegate = self
        view.addSubview(textView)

        writeRubyButton = UIButton()
        writeRubyButton.setTitle("ルビを振る", for: .normal)
        writeRubyButton.backgroundColor = .blue
        writeRubyButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        view.addSubview(writeRubyButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
//        let heigth = view.frame.height
        let topSafeAreaHeight = view.safeAreaInsets.top
        let textViewHeight: CGFloat = 200
        let rubyButtonHeight: CGFloat = 60
        let margin: CGFloat = 32
        
        textView.frame = CGRect(x: 0, y: topSafeAreaHeight, width: width, height: textViewHeight)
        writeRubyButton.frame = CGRect(x: width * 0.1, y: topSafeAreaHeight + textViewHeight + margin, width: width * 0.8, height: rubyButtonHeight)
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

