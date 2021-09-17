//
//  ViewController.swift
//  Dorothy
//
//  Created by Adarsh Raj on 30/08/21.
//

import UIKit
import SDWebImage
import SideMenuSwift

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension UIViewController
{
    // Back Button calling
    func backBtn()
    {
        navigationController?.popViewController(animated: true)
    }
    
    // Cart page Calling
    func cartBtn()
    {
        let cartVC = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    // Home Page Calling
    func homePage()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //Search Page Calling
    func searchBtn()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    // Internet Reachability
    func checkInternet()
    {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")

            showAlertWithOK(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", view: self, actionHandler: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    // Gradient Color
    func setGradientBackground(view:UIView)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
          UIColor(red: 1, green: 0.89, blue: 0.02, alpha: 1).cgColor,
          UIColor(red: 1, green: 0.373, blue: 0.02, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0,1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.3, y: 1.0)
        gradientLayer.frame = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
       view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func cartBadgeIcon(qty:String)
    {
        // badge label
          let label = UILabel(frame: CGRect(x: 10, y: -10, width: 15, height: 15))
          label.layer.borderColor = UIColor.clear.cgColor
          label.layer.borderWidth = 2
          label.layer.cornerRadius = label.bounds.size.height / 2
          label.textAlignment = .center
          label.layer.masksToBounds = true
          label.font = UIFont(name: "Poppins-SemiBold", size: 10)
          label.textColor = .white
          label.backgroundColor = .red
          label.text = qty

          // button
          let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
          rightButton.setBackgroundImage(UIImage(named: "empty_cart"), for: .normal)
          rightButton.addTarget(self, action: #selector(cartBtnAction), for: .touchUpInside)
          rightButton.addSubview(label)

          // Bar button item
          let rightBarButtomItem = UIBarButtonItem(customView: rightButton)

          navigationItem.rightBarButtonItem = rightBarButtomItem
    }
    @objc func cartBtnAction() {
        cartBtn()
    }
        
}

//MARK:- CODE FOR CUSTOM TOAST
extension UIViewController
{
    func showToast(message : String, seconds: Double)
    {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet
        )
        let itemView = UIView(frame:CGRect(x:0, y:0, width: UIScreen.main.bounds.size.width - 40, height:50))
        itemView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        itemView.contentMode = .center
        itemView.layer.cornerRadius = 10
        let label = UILabel()
       
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        itemView.addSubview(label)
        alert.view.addSubview(itemView)
        alert.view.alpha = 0.8
        label.centerYAnchor.constraint(equalTo: itemView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: itemView.centerXAnchor).isActive = true
        alert.view.layer.cornerRadius = 10
        
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width - 40)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

//MARK:- CODE FOR SIDE MENU GRADIENT
extension UIView
{
    func setGradientBackground1() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
          UIColor(red: 1, green: 0.89, blue: 0.02, alpha: 1).cgColor,
          UIColor(red: 1, green: 0.373, blue: 0.02, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0,1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.2, y: 1.2)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }

}

//MARK:- Validations on text field
extension UIViewController
{
    // Email Validation
    func validateEmailID(emailID:String) -> Bool {
        let emailString = emailID.replacingOccurrences(of: " ", with: "")
        if emailString.count == emailID.count {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }else
        {
            return false
        }
    }
    
    // Mobile Validation
    func validateNumber(_ number: String) -> Bool {
      let usernameRegEx = "^[0-9]+$"
      let usernameValidator = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
      return usernameValidator.evaluate(with: number)
  }
}

//Animations : https://github.com/marcosgriselli/ViewAnimator



