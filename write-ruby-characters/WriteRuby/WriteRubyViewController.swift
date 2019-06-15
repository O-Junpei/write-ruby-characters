import UIKit

class WriteRubyViewController: UIViewController {
    var textView: UITextView!
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        textView = UITextView()
        textView.backgroundColor = .red
        view.addSubview(textView)

        button = UIButton()
        button.backgroundColor = .blue
        view.addSubview(button)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let width = view.frame.width
        let heigth = view.frame.height
        textView.frame = CGRect(x: width * 0.1, y: heigth * 0.2, width: width * 0.8, height: heigth * 0.2)
        button.frame = CGRect(x: width * 0.1, y: heigth * 0.5, width: width * 0.8, height: heigth * 0.1)
    }
}

