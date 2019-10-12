//
//  LoginVC.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit
import CoreData

class LoginVC: SIViewController, UITextFieldDelegate {

    @IBOutlet var txtEmail:UnderLineTextField!
    @IBOutlet var txtPassword:UnderLineTextField!
    
    let login = "http://techcronus.com/staging/sheers/api/login"
    var isView = false
    var strTextFieldSelected = ""
    var deviceToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        deviceToken = getValueFromDefault(key: kdeviceToken) as! String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        
        self.view.shiftHeightAsDodgeViewForMLInputDodger = 25.0;
        self.view.registerAsDodgeViewForMLInputDodger()
    }
    
//MARK:- UIStatusBar Light
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
//MARK:- TextField Delegate Methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtEmail{
            strTextFieldSelected = "txtEmail"
        }else if textField == txtPassword{
            strTextFieldSelected = "txtPassword"
        }
        textField.inputAccessoryView = toolbarInit()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//MARK:- UITextField Toolbar and Methods
    func toolbarInit() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.barTintColor = ThemeYellow
        toolBar.tintColor = UIColor.white
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("String3", comment: "done"), style: UIBarButtonItem.Style.done, target: self, action: #selector(resignKeyboard))
        let previousButton:UIBarButtonItem! = UIBarButtonItem()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        previousButton.customView = self.prevNextSegment()
        toolBar.setItems([previousButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar;
    }
    
    func prevNextSegment() -> UISegmentedControl {
        let prevNextSegment = UISegmentedControl()
        prevNextSegment.isMomentary = true
        prevNextSegment.tintColor = UIColor.white
        let barbuttonFont = UIFont(name: ThemeFont.Regular, size: 15) ?? UIFont.systemFont(ofSize: 15)
        prevNextSegment.setTitleTextAttributes([NSAttributedString.Key.font: barbuttonFont, NSAttributedString.Key.foregroundColor:UIColor.white], for: UIControl.State.disabled)
        prevNextSegment.frame = CGRect(x: 0, y: 0, width: 130, height: 35)
        prevNextSegment.insertSegment(withTitle:  NSLocalizedString("String4", comment: ""), at: 0, animated: false)
        prevNextSegment.insertSegment(withTitle:  NSLocalizedString("String5", comment: ""), at: 1, animated: false)
        prevNextSegment.addTarget(self, action: #selector(prevOrNext), for: UIControl.Event.valueChanged)
        return prevNextSegment;
    }
    
    @objc func prevOrNext(_ segm: UISegmentedControl) {
        if (segm.selectedSegmentIndex == 1){
            if (strTextFieldSelected == "txtEmail"){
                _ = txtEmail.resignFirstResponder()
                _ = txtPassword.becomeFirstResponder()
            }
        }
        else{
            if (strTextFieldSelected == "txtPassword"){
                _ = txtPassword.resignFirstResponder()
                _ = txtEmail.becomeFirstResponder()
            }
        }
    }
    
    @objc func resignKeyboard() {
        _ = self.txtEmail.resignFirstResponder()
        _ = self.txtPassword.resignFirstResponder()
    }
    
//MARK:- UIAction Events
    @IBAction func TapLogin(_ sender:AnyObject) {
        if !(txtEmail.text?.emailValidation())! {
            appDelegateShared.showToastMessage( NSLocalizedString("String1", comment: ""))
        }else if !(txtPassword.text?.passwordValidation())! {
            appDelegateShared.showToastMessage( NSLocalizedString("String2", comment: ""))
        }else {
            self.resignKeyboard()
            createLogin()
        }
    }
    
    @IBAction func TapViewPassword(_ sender:AnyObject) {
        if isView{
            isView = false
            txtPassword.isSecureTextEntry = true
        }else{
            isView = true
            txtPassword.isSecureTextEntry = false
        }
    }
    
//MARK:- Login
    func createLogin() {
        
        let parameters = [kemail:txtEmail.text!,
                          kpassword:txtPassword.text!
                         ] as NSDictionary
        
        appDelegateShared.showHudder()
        getAPIdata(requestType: kPOST, url: login, parameter: parameters, contentType: appJson, isHudShow: true) { (json, status) in
            appDelegateShared.hideHudder()
            if status == 1{
                do{
                    let objResponse = try JSONDecoder().decode(newCommonData.self, from: json)
                    if objResponse.status == true{
                        appDelegateShared.showToastMessage("Logged in successfully")
                        print(objResponse.data!)
                    }else{
                        appDelegateShared.showToastMessage("Please try again")
                    }
                }catch{
                    appDelegateShared.showToastMessage("Please try again")
                }
            }else{
                appDelegateShared.showToastMessage("Please try again")
            }
        }
    }
}

