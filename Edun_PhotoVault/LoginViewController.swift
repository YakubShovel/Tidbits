//
//  LoginViewController.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/10/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit
import SmileLock
import KeychainSwift
import Lottie


class LoginViewController: UIViewController {
    
    //MARK: IBOutlets from LoginPage
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var loginRequestText: UILabel!
    
    
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 4
    
    let keychain = KeychainSwift()
    
    var firstPassTry: Bool = true
    var secondTry: Bool = false
    var tempPass: String?
    //var secondPassTry: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let animationView = LOTAnimationView(name: "fidget_spinner")
            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFill
            
            view.addSubview(animationView)
            
            animationView.play()
            animationView.loopAnimation = true*/
        
        
        
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        passwordContainerView.deleteButtonLocalizedTitle = "Delete"
        
        //customize password UI
        passwordContainerView.tintColor = UIColor.gray
        passwordContainerView.highlightedColor = UIColor.gray
        
        //If you already have a password
        if let password = UserDefaults.standard.string(forKey: "password") {
            loginRequestText.text = "Enter Your Password"
            firstPassTry = false
            secondTry = false
        }
        
        //If it's your first time in the app
        if firstPassTry {
            loginRequestText.text = "Enter Your New Password"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LoginViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        
        if firstPassTry == false && secondTry == false {
            if let password = UserDefaults.standard.string(forKey: "password") {
                if validation(input) {
                    validationSuccess()
                } else {
                    validationFail()
                }
            }
        }
        
        if secondTry {
            if input == tempPass {
                UserDefaults.standard.set(input, forKey: "password")
                validationSuccess()
            }
            else {
                validationFail()
                loginRequestText.text = "Incorrect Password. Reconfirm Your Password"
            }
        }
        
        if firstPassTry {
            tempPass = input
            loginRequestText.text = "Confirm Your Password"
            passwordContainerView.clearInput()
            firstPassTry = false
            secondTry = true
        }
        
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        }
        else {
            passwordContainerView.clearInput()
        }
    }
}

private extension LoginViewController {
    func validation(_ input: String) -> Bool {
        return input == UserDefaults.standard.string(forKey: "password")!
    }
    
    func validationSuccess() {
        print("*️⃣ success!")
        //dismiss(animated: true, completion: nil)
        
//        //instantiating an instance of mainVC and presenting it
//        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
//        self.present(homeVC!, animated: true, completion: nil)
        
        //calling a sgue I created in storyboard
        self.performSegue(withIdentifier: "navToMainVC", sender: nil)
    }
    
    func validationFail() {
        print("*️⃣ failure!")
        passwordContainerView.clearInput()
        passwordContainerView.wrongPassword()
    }
}

