//
//  ViewController.swift
//  TextViewDemo
//
//  Created by AdBox on 6/5/17.
//  Copyright © 2017 myth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lb_count: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTexView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTexView(notification:)), name: Notification.Name.UIKeyboardWillHide , object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // this way can be apply if you have multiple textview.
        //textView.endEditing(true)
        textView.resignFirstResponder()
    }
    
    
    //Adjust textview text when keyboard appear and keep typing
    func updateTexView(notification: Notification) {
    
        let userinfo = notification.userInfo!
        
        let keyboardEndFrameScreenCoordinates = (userinfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardframe = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
        
            textView.contentInset = UIEdgeInsets.zero
        }
        else {
        
            // set bottom insets when keyboard apper
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardframe.height, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
        
    }
}

extension ViewController : UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        textView.textColor = UIColor.yellow
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        lb_count.text = "\(textView.text.characters.count)"
        
        return textView.text.characters.count + (text.characters.count - range.length) <= 1000
    }
}

