//
//  SendOtpViewController.swift
//  Dorothy
//
//  Created by Adarsh Raj on 30/07/21.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SendOtpViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var mobileTextField: MDCOutlinedTextField!
    @IBOutlet weak var sendOtpScrollView: UIScrollView!
    @IBOutlet weak var sendOtpBtn: UIButton!
    var country_code:String = "+91"
    var mobile:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDesign()
        setGradientBackground(view: backView)
        sectionView.layer.cornerRadius = 60
        sectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        sendOtpScrollView.delegate = self
        sendOtpBtn.layer.cornerRadius = 30
    }
    func textFieldDesign()
    {
        mobileTextField.label.text = "Enter Mobile Number"
        mobileTextField.containerRadius = 30.0
        mobileTextField.leadingEdgePaddingOverride = 100.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
    @IBAction func countryCodeBtnAction(_ sender: UIButton) {
        country_code = sender.titleLabel!.text!
    }
    @IBAction func sendOtpBtnAction(_ sender: Any) {
        let mobile = validateNumber(mobileTextField.text!)
        
        if mobileTextField.text! == ""
        {
            Alert.showError(title: "Error", message: "Enter mobile number", vc: self)
        }else if mobile == false || mobileTextField.text?.count != 10
        {
            Alert.showError(title: "Error", message: "Invalid mobile", vc: self)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOtpViewController") as! VerifyOtpViewController
            vc.mobile = mobileTextField.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        }
    @IBAction func backBtn(_ sender: UIButton) {
       backBtn()
    }
    
}
