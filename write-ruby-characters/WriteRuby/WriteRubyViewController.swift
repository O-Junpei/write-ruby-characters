import UIKit

class WriteRubyViewController: UIViewController {
    var textView: UITextView!
    var writeRubyButton: UIButton!

    var presenter: WriteRubyPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WriteRubyPresenter(view: self)

        view.backgroundColor = .white

        textView = UITextView()
        textView.backgroundColor = .red
        textView.delegate = self
        view.addSubview(textView)

        writeRubyButton = UIButton()
        writeRubyButton.backgroundColor = .blue
        writeRubyButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        view.addSubview(writeRubyButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let width = view.frame.width
        let heigth = view.frame.height
        textView.frame = CGRect(x: width * 0.1, y: heigth * 0.2, width: width * 0.8, height: heigth * 0.2)
        writeRubyButton.frame = CGRect(x: width * 0.1, y: heigth * 0.5, width: width * 0.8, height: heigth * 0.1)
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
    func showAlert(ruby: String, text: String) {
        print(ruby, text)
    }
}

