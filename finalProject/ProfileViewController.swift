//
//  ProfileViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 15.12.2020.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!

    @IBOutlet weak var profilePhotoField: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    
    @IBAction func showMyFlags(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CardsViewController") as? CardsViewController else {
            return
        }
        vc.user = user
        print("ooooooooooo")
        print(self.user.flags.count)
        vc.incomingData.append(objectsIn: user.flags)
        vc.checker = "flag"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showMyCapitals(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CardsViewController") as? CardsViewController else {
            return
        }
        vc.user = user
        print("CAPITAL")
        print(self.user.capitals.count)
        vc.incomingData.append(objectsIn: user.capitals)
        vc.checker = "capital"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "EditProfileViewController") as? EditProfileViewController else {
            return
        }
        vc.incomingData = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
        viewLoadSetup()
    }
    func viewLoadSetup(){
        self.nameField.text = user.name
        self.emailField.text = user.email
        if let profImage = user.profileImage {
            self.profilePhotoField.image = UIImage(data: profImage as Data)
        }
        print("CCCCCCCCCCC")
        print(type(of: user.flags))
    }

    @IBAction func logOut(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
