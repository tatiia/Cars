//
//  ViewController.swift
//  Cars
//
//  Created by Tatia on 22.03.21.
//

import UIKit

enum LoginErrors : Error {
    case notCompletedFilled
    case notEmailFormat
    case shortPassword
    case incorrectPassword
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        design()
    }

    @IBAction func loginBtn(_ sender: UIButton) {
        do {
            try Login()
        } catch LoginErrors.notCompletedFilled {
            myAlert.showAlert(title: "არასრული მონაცემები", message: "გთხოვთ შეავსოთ ყველა ველი", vc: self)
        } catch LoginErrors.notEmailFormat {
            myAlert.showAlert(title: "არასწორი მეილი", message: "შეიყვანეთ მეილი სწორად", vc: self)
        } catch LoginErrors.shortPassword {
            myAlert.showAlert(title: "მოკლე პაროლი", message: "შეიყვანეთ უფრო გრძელი პაროლი", vc: self)
        } catch LoginErrors.incorrectPassword {
            myAlert.showAlert(title: "არასწორი პაროლი", message: "შეიყვანეთ სხვა პაროლი", vc: self)
        } catch {
            myAlert.showAlert(title: "Error", message: "Other Error", vc: self)
        }
        
        let second = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondPageViewController") as! SecondPageViewController
        self.navigationController?.pushViewController(second, animated: true)
    }
    
    func Login() throws {
        let email = emailField.text!
        let password = passwordField.text!
        
        if email.count == 0 || password.count == 0 {
            throw LoginErrors.notCompletedFilled
        }
        
        if !isValidEmail(email: email) {
            throw LoginErrors.notEmailFormat
        }
        
        if password.count < 8 {
            throw LoginErrors.shortPassword
        }
        
        if password != "we_love_ios" {
            throw LoginErrors.incorrectPassword
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func design() {
        loginView.layer.cornerRadius = 25
        loginView.layer.borderColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        loginView.layer.borderWidth = 4
        loginImageView.image = UIImage.init(named: "login")
        loginImageView.image = loginImageView.image?.withRenderingMode(.alwaysTemplate)
        loginImageView.tintColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        imageView.image = UIImage.init(named: "carsLogo")
    }
}

