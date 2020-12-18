//
//  FlagCardsViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 17.12.2020.
//

import UIKit
import SVGKit
import RealmSwift

class FlagCardsViewController: UIViewController {
    let realm = try! Realm()
    var user: User!
    var fetchedCountry = [Country]()
    var randomCountry: Country!

    @IBOutlet weak var countryField: UILabel!
    @IBOutlet weak var flagField: UIImageView!
    
    @IBAction func learnBtn(_ sender: UIButton) {
        game()
    }
    
    @IBAction func alreadyKnowBtn(_ sender: UIButton) {
        for test in self.user.flags {
            if test.country == randomCountry.country {
                print("AAAAAAAAAAAAAAAAAAA")
                game()
            }
        }
        try! realm.write{
            self.user.flags.append(randomCountry)
        }
        print(self.user.flags.count)
        game()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game()
    }
    
    func game() {
        print(self.fetchedCountry.count)
        let lenght = fetchedCountry.count
        self.randomCountry = fetchedCountry[Int.random(in: 0...lenght)]
        if randomCountry.flag == "" {
            game()
        }
        self.countryField.text = randomCountry.country
        let svg = URL(string: randomCountry.flag)!
        let data = try? Data(contentsOf: svg)
        let receivedimage: SVGKImage = SVGKImage(data: data)
        flagField.image = receivedimage.uiImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
   }
}
