//
//  RegisterViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 15.12.2020.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {

    let realm = try! Realm()

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard let fname = self.firstNameField.text else {return}
        guard let lname = self.lastNameField.text else {return}
        guard let email = self.emailField.text else {return}
        guard let password = self.passwordField.text else {return}
        
        let newUser = User()
        newUser.name = fname + " " + lname
        newUser.email = email
        newUser.pasword = password
        
        try! realm.write{
            realm.add(newUser)
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
