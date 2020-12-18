//
//  CountryDetailViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 16.12.2020.
//

import UIKit
import SVGKit

class CountryDetailViewController: UIViewController {

    var country: Country!
    
    @IBOutlet weak var flagField: UIImageView!
    @IBOutlet weak var countryNameField: UILabel!
    @IBOutlet weak var capitalField: UILabel!
    @IBOutlet weak var regionField: UILabel!
    @IBOutlet weak var subRegionField: UILabel!
    @IBOutlet weak var populationField: UILabel!
    @IBOutlet weak var areaField: UILabel!
    @IBOutlet weak var nativeNameField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let svg = URL(string: country.flag)!
        let data = try? Data(contentsOf: svg)
        let receivedimage: SVGKImage = SVGKImage(data: data)
        flagField.image = receivedimage.uiImage
        countryNameField.text = country.country
        capitalField.text = "Capital: " + country.capital
        regionField.text = "Region: " + country.region
        subRegionField.text = "Subregion: " + country.subregion
        populationField.text = "Population: " + country.population.description
        areaField.text = "Area: " + country.area.description
        nativeNameField.text = "Native name: " + country.nativeName

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
   }

}
