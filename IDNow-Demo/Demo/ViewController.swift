//
//  ViewController.swift
//  Demo
//
//  Created by Bilel Selmi on 05.12.19.
//  Copyright © 2019 IDnow. All rights reserved.
//

import UIKit
import IDNowSDKCore

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    
    @IBAction func onTapView(_ sender: Any) {
        tokenTextField.resignFirstResponder()
    }
    
    
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var tokenTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenTextField.delegate = self
        progress.isHidden = true
        progress.stopAnimating()
        
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Disable button confirm at the first
        self.setButtonConfirmEnabled(false)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            
            if tokenTextField.frame.maxY > (keyboardViewEndFrame.origin.y - 80 /*arbitrary value*/) {
                let shift = view.frame.height - tokenTextField.frame.maxY  - keyboardViewEndFrame.height + 160
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                       bottom: shift,
                                                       right: 0)
                
                scrollView.scrollIndicatorInsets = scrollView.contentInset
                scrollView.setContentOffset(CGPoint(x: 0, y: shift), animated: true)
            } else {
                scrollView.contentInset = UIEdgeInsets.zero
                
            }
        }
        
        
        
    }
    
    @IBOutlet weak var buttonConfirm: UIView!
    
    @IBAction func onConfirmButtonClick(_ sender: Any) {
        buttonConfirm.isUserInteractionEnabled = false
        progress.isHidden = false
        progress.startAnimating()
        IDNowSDK.shared.start(token: tokenTextField!.text!, fromViewController: self, listener:{ (result: IDNowSDK.IdentResult, message: String) in
            print ("SDK finished")
            self.buttonConfirm.isUserInteractionEnabled = true
            self.progress.isHidden = true
            self.progress.stopAnimating()
            if result == IDNowSDK.IdentResult.ERROR {
                self.showAlert(text: message)
            } else if result == IDNowSDK.IdentResult.FINISHED {
                // clear the token
                self.setButtonConfirmEnabled(false)
                self.tokenTextField.text = ""
            }
        }
        )
    }
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let textRange = Range(range, in: textField.text!)
        let newText = textField.text?.replacingCharacters(in: textRange!, with: string)
        self.setButtonConfirmEnabled(!(newText?.isEmpty ?? true))
        textField.text = IDNowSDK.shared.autoformatIdentEntry(newContent: newText ?? "", performedReplacement: string)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert(text: String){
        let alert = UIAlertController(title: nil, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setButtonConfirmEnabled(_ enabled: Bool) {
        buttonConfirm.backgroundColor = enabled ? UIColor(red: 249/255, green: 86/255, blue: 2/255, alpha: 1.0): UIColor.gray
        buttonConfirm.isUserInteractionEnabled = enabled
    }
}


