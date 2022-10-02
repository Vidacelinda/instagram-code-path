//
//  loginViewController.swift
//  instagram
//
//  Created by Carlo Leiva on 9/30/22.
//
import Parse
import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func onSignIn(_ sender: Any) {//c
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password){(user,error)in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")//print("Error: \(error?.localizedDescription)")
            }
            
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {//c
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackground{(success,error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")//print("Error: \(error?.localizedDescription)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
