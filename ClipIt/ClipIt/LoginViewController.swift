//
//  LoginViewController.swift
//  ClipIt
//
//  Created by Alex Rodriguez on 5/22/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var rootURL = "http://127.0.0.1:5000"
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loggingIn: UIActivityIndicatorView!
    
    private let networkingClient = NetworkingClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        loggingIn.isHidden = true
        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        loggingIn.isHidden = false
        loggingIn.startAnimating()
        guard let uname = username.text else { return }
        guard let pword = password.text else { return }
        
        networkingClient.log_in(username: uname, password: pword) { (json, error) in
            self.loggingIn.stopAnimating()
            if let error = error {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error.localizedDescription
                print(error.localizedDescription)
            } else if let json = json {
                if json == "invalid_user" {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "Invalid user"
                } else if json == "incorrect-password" {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "Incorrect password"
                } else {
                    print("succesfuly authenticated with auth token \(json)")
                    self.loggingIn.isHidden = true
                    self.navigationController?.navigationBar.isHidden = false
                    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
                    vc.token = json
                    self.navigationController?.pushViewController(vc, animated: true)
//                    Save user defaults for the auth token
                }
                
            }
            
        }
        
        
    }
    @IBAction func signUp(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
