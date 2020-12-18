//
//  FlagGameViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 16.12.2020.
//

import UIKit
import SVGKit

class FlagGameViewController: UIViewController {
    
    var user: User!
    
    var fetchedCountry = [Country]()

    @IBOutlet weak var flagField: UIImageView!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var answerCountryField: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        game()
    }
    
    @IBAction func CheckAnswer(_ sender: UIButton) {
        guard let input = countryField.text else {
            return
        }
        let checkCapital = self.answerCountryField.text
        if (checkCapital!.caseInsensitiveCompare(input) == .orderedSame) {
            self.answerCountryField.isHidden = false
            self.answer.text = "Correct! Congratulations!"
            self.answer.textColor = .green
            self.answer.isHidden = false
            self.checkBtn.isHidden = true
            self.nextBtn.isHidden = false
        }else{
            self.answer.text = "Incorrect! Try again"
            self.answer.textColor = .red
            self.answer.isHidden = false
        }
    }
    @IBAction func showAnswer(_ sender: UIButton) {
        self.answerCountryField.isHidden = false
        self.countryField.text = self.answerCountryField.text
        nextBtn.isHidden = false
        checkBtn.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        game()
    }
    
    func game() {
        self.checkBtn.isHidden = false
        self.nextBtn.isHidden = true
        self.answerCountryField.isHidden = true
        self.answer.isHidden = true
        self.countryField.text = ""
        print(self.fetchedCountry.count)
        let lenght = fetchedCountry.count
        let randomCountry = fetchedCountry[Int.random(in: 0...lenght)]
        for test in self.user.flags {
            if test.country == randomCountry.country {
                print("AHAHHAHAHAHAHAHAHAHAHAHAH")
                game()
            }
        }
        if randomCountry.flag == "" {
            game()
        }
        self.answerCountryField.text = randomCountry.country
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
