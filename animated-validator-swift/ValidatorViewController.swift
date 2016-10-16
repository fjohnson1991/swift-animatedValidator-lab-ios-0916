//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SnapKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    var emailTexFieldIsValid = true
    var emailConfirmationTextFieldIsValid = false
    var phoneTextFieldIsValid = false
    var passwordTextFieldIsValid = false
    var passwordConfirmTextFieldIsValid = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD

        self.emailTextField.delegate = self
        self.emailConfirmationTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
        self.view.addSubview(submitButton)
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).multipliedBy(0.3)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        self.emailConfirmationTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(emailTextField.snp.bottom).multipliedBy(1.1)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        self.phoneTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(emailConfirmationTextField.snp.bottom).multipliedBy(1.1)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(phoneTextField.snp.bottom).multipliedBy(1.1)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        self.passwordConfirmTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).multipliedBy(1.1)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        self.submitButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(100)
        }
        
        self.submitButton.isEnabled = false
    }
    
    func animateSubmitButton() {
//        print("inside animateSubmitButton func")
//        print("emailText \(emailTexFieldIsValid)")
//        print("emailConf \(emailConfirmationTextFieldIsValid)")
//        print("phoneText \(phoneTextFieldIsValid)")
//        print("passwordText \(passwordTextFieldIsValid)")
//        print("passwordConfText \(passwordConfirmTextFieldIsValid)")
        
        if emailTexFieldIsValid == true && emailConfirmationTextFieldIsValid == true && phoneTextFieldIsValid == true && passwordTextFieldIsValid == true && passwordConfirmTextFieldIsValid == true {
            submitButtonChange()
        }
    }

    func submitButtonChange() {
        self.view.layoutIfNeeded()
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: .calculationModeLinear, animations: {
            self.submitButton.isEnabled = true
            self.submitButton.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view.snp.centerX)
                make.centerY.equalTo(self.view.snp.centerY).multipliedBy(1.1)
            })
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func errorMessage(textArea: UITextField) {
        UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3.0, animations: {
                textArea.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                textArea.backgroundColor = UIColor.red
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3.0, relativeDuration: 1/3.0, animations: {
                textArea.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                textArea.backgroundColor = UIColor.red
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2/3.0, relativeDuration: 1/3.0, animations: {
                textArea.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                textArea.backgroundColor = UIColor.red
            })
            
            
        }) { (completion) in
            textArea.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            textArea.backgroundColor = UIColor.white
            self.hideSubmitButton()
        }
    }
    
    func hideSubmitButton() {
        self.submitButton.isEnabled = false
        self.submitButton.snp.remakeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(100)
        })
    }

    @IBAction func editingEnded(_ sender: AnyObject) {
        animateSubmitButton()
        print("inside editing changed func")
        print("emailText \(emailTexFieldIsValid)")
        print("emailConf \(emailConfirmationTextFieldIsValid)")
        print("phoneText \(phoneTextFieldIsValid)")
        print("passwordText \(passwordTextFieldIsValid)")
        print("passwordConfText \(passwordConfirmTextFieldIsValid)")
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case emailTextField:
            if (emailTextField.text?.characters.contains("@"))! && (emailTextField.text?.characters.contains("."))! {
                emailConfirmationTextFieldIsValid = true
            } else {
                self.emailConfirmationTextFieldIsValid = false
                errorMessage(textArea: emailTextField)
            }
            
        case emailConfirmationTextField:
            if emailConfirmationTextField.text == emailTextField.text {
                emailConfirmationTextFieldIsValid = true
            } else {
                errorMessage(textArea: emailConfirmationTextField)
                emailConfirmationTextFieldIsValid = false
            }
            
        case phoneTextField:
            if (phoneTextField.text?.characters.count)! >= 7 && (phoneTextField.text?.isNumber)! {
                phoneTextFieldIsValid = true
            } else {
                errorMessage(textArea: phoneTextField)
                phoneTextFieldIsValid = false
            }
            
        case passwordTextField:
            if (passwordTextField.text?.characters.count)! >= 6 {
                passwordTextFieldIsValid = true
            } else {
                errorMessage(textArea: passwordTextField)
                passwordTextFieldIsValid = false
            }
            
        case passwordConfirmTextField:
            if passwordTextField.text == passwordConfirmTextField.text {
                passwordConfirmTextFieldIsValid = true
            } else {
                errorMessage(textArea: passwordConfirmTextField)
                passwordConfirmTextFieldIsValid = false
            }
            
        default:
            break
        }
        
    }
}



extension String {
    
    var isNumber: Bool {
        let numbers: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: numbers)
        
    }
}

