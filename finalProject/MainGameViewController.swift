//
//  MainGameViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 16.12.2020.
//

import UIKit

class MainGameViewController: UIViewController {
    var user: User!
    
    var fetchedCountry = [Country]()
    
    @IBAction func sortCapitalsBtn(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CapitalCardsViewController") as? CapitalCardsViewController else {
            return
        }
        vc.user = user
        vc.fetchedCountry = fetchedCountry
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sortFlagsBtn(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FlagCardsViewController") as? FlagCardsViewController else {
            return
        }
        vc.user = user
        vc.fetchedCountry = fetchedCountry
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func CountryFlagGame(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FlagGameViewController") as? FlagGameViewController else {
            return
        }
        vc.user = user
        vc.fetchedCountry = fetchedCountry
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func CountryCapitalGame(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "GameViewController") as? GameViewController else {
            return
        }
        vc.user = user
        vc.fetchedCountry = fetchedCountry
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
   }
    
    func parseData(){
        
        self.fetchedCountry = []
        
        let url = "https://restcountries.eu/rest/v2/all"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if (error != nil){
                print("Error")
            }else{
                do{
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    
                    for eachFetchedCountry in fetchedData {
                        let newCountry = Country()
                        
                        let eachCountry = eachFetchedCountry as! [String: Any]
                        newCountry.country = eachCountry["name"] as! String
                        newCountry.capital = eachCountry["capital"] as! String
                        newCountry.flag = eachCountry["flag"] as! String
                        newCountry.region = eachCountry["region"] as! String
                        newCountry.subregion = eachCountry["subregion"] as! String
                        newCountry.population = eachCountry["population"] as! Int
                        if (eachCountry["area"] as Any) as! NSObject == NSNull(){
                            print("AAAAAAAAAA")
                            newCountry.area = 0.0
                        }else{
                            let numStr = (eachCountry["area"] as! NSNumber).doubleValue
                            print("gggggggggggggggg")
                            newCountry.area = numStr
                            print(numStr)
                            print(type(of: numStr))
                        }
                        newCountry.nativeName = eachCountry["nativeName"] as! String
                        
                        self.fetchedCountry.append(newCountry)
                    }
                    print(self.fetchedCountry.count)
                }
                catch{
                    print("ERRor 2")
                }
            }
        }
        task.resume()
    }
}
