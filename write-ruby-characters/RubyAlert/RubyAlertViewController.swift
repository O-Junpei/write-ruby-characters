import UIKit

class RubyAlertViewController: UIViewController {
    
    let rubySentense: String
    
    init(rubySentense: String) {
        self.rubySentense = rubySentense
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didViewTap))
        view.addGestureRecognizer(tapGesture)
        
        let effect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = view.frame
        view.addSubview(blurView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let alertWidth = view.frame.width * 0.8
        let closeButtonHeight: CGFloat = 40
        let margin: CGFloat = 24
        
        let baseView = UIView()
        baseView.backgroundColor = .white
        baseView.layer.cornerRadius = 32
        baseView.layer.borderWidth = 1.0
        baseView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(baseView)
        
        let textView = UITextView()
        textView.text = rubySentense
        textView.frame = CGRect(x: margin, y: margin, width: alertWidth - margin * 2, height: 0)
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .gray
        textView.sizeToFit()
        baseView.addSubview(textView)
        
        let textViewHeight = textView.frame.size.height
        
        let closeButton = UIButton()
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        closeButton.setTitle("閉じる", for: .normal)
        closeButton.backgroundColor = UIColor(named: "baseOrange")
        closeButton.frame = CGRect(x: margin, y: textViewHeight + margin * 2, width: alertWidth - margin * 2, height: closeButtonHeight)
        closeButton.layer.cornerRadius = 16
        closeButton.isUserInteractionEnabled = false
        baseView.addSubview(closeButton)
        
        baseView.frame = CGRect(x: 0, y: 0, width: alertWidth, height: textViewHeight + closeButtonHeight + margin * 3)
        baseView.center = view.center
    }
    
    @objc func didViewTap() {
        dismiss(animated: true, completion: nil)
    }
}
