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
        
        let width = view.frame.width
        let height = view.frame.height
        
        let label = UITextView()
        label.frame = CGRect(x: 0, y: 0, width: width * 0.8, height: 0)
        label.backgroundColor = .white
        label.text = rubySentense
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
    }
    
    @objc func didViewTap() {
        dismiss(animated: true, completion: nil)
    }
}
