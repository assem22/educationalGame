//
//  GameViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 15.12.2020.
//

import UIKit
import SVGKit

class GameViewController: UIViewController {
    
    var user: User!
    
    var fetchedCountry = [Country]()

    @IBOutlet weak var countryField: UILabel!
    @IBOutlet weak var capitalField: UILabel!
    @IBOutlet weak var inputCapitalField: UITextField!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var flagField: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    
    @IBAction func nextBtn(_ sender: UIButton) {
        game()
    }
    @IBAction func SeeAnswerBtn(_ sender: UIButton) {
        self.capitalField.isHidden = false
        self.inputCapitalField.text = self.capitalField.text
        nextButton.isHidden = false
        checkBtn.isHidden = true
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let input = inputCapitalField.text else {
            return
        }
        let checkCapital = self.capitalField.text
        if (checkCapital!.caseInsensitiveCompare(input) == .orderedSame) {
            self.capitalField.isHidden = false
            self.answer.text = "Correct! Congratulations!"
            self.answer.textColor = .green
            self.answer.isHidden = false
            self.checkBtn.isHidden = true
            self.nextButton.isHidden = false
        }else{
            self.answer.text = "Incorrect! Try again"
            self.answer.textColor = .red
            self.answer.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        game()
    }

    func game() {
        self.checkBtn.isHidden = false
        self.nextButton.isHidden = true
        self.capitalField.isHidden = true
        self.answer.isHidden = true
        self.inputCapitalField.text = ""
        print(self.fetchedCountry.count)
        let lenght = fetchedCountry.count
        let randomCountry = fetchedCountry[Int.random(in: 0...lenght)]
        for test in self.user.capitals {
            if test.country == randomCountry.country {
                print("AHAHHAHAHAHAHAHAHAHAHAHAH")
                game()
            }
        }
        if randomCountry.capital == "" {
            game()
        }
        self.countryField.text = randomCountry.country
        self.capitalField.text = randomCountry.capital
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
