//
//  LoginViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 27.12.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateTitlesAppearing()
        animateTitleAppearing()
        animateFieldsAppearing()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillhide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
            self.scrollView?.endEditing(true)
        }
    
    @objc func keybordWillShow(notification: Notification) {
        guard let kbsize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbsize.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    @objc func keybordWillhide(notification: Notification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }

}

// MARK: Animation

extension LoginViewController {
    
    func animateTitlesAppearing() {
        let offset = view.bounds.width
        emailLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordLabel.transform = CGAffineTransform(translationX: offset, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
                           self.emailLabel.transform = .identity
                           self.passwordLabel.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateTitleAppearing() {
        self.titleLabel.transform = CGAffineTransform(translationX: 0,
                                                     y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                           self.titleLabel.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        self.emailTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
    }
    
    func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
    }
    
}
