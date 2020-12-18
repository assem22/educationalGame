//
//  AllCountriesViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 16.12.2020.
//

import UIKit
import SVGKit

class AllCountriesViewController: UIViewController {
    var fetchedCountry = [Country]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        parseData()
        searchBar()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "firstTableViewCell", bundle: nil), forCellReuseIdentifier: "simpleCell")
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
//                        let test = eachCountry["area"] as Any
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
                    self.tableView.reloadData()
                }
                catch{
                    print("ERRor 2")
                }
            }
        }
        task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension AllCountriesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(fetchedCountry.count)
        return fetchedCountry.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath) as! firstTableViewCell
        cell.view.layer.cornerRadius = cell.view.frame.height / 2
        cell.flagField.layer.cornerRadius = cell.flagField.frame.height / 2
        cell.countryName.text = fetchedCountry[indexPath.row].country
        cell.capitalField.text = fetchedCountry[indexPath.row].capital
        let svg = URL(string: fetchedCountry[indexPath.row].flag)!
        let data = try? Data(contentsOf: svg)
        let receivedimage: SVGKImage = SVGKImage(data: data)
        cell.flagField.image = receivedimage.uiImage
        
        return cell
    }
    
    func tableView(_ collectionView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = fetchedCountry[indexPath.item]

        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CountryDetailViewController") as? CountryDetailViewController{
            vc.country = object
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func searchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        searchBar.scopeButtonTitles = ["Country", "Capital"]
        self.tableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            parseData()
        }else{
            if searchBar.selectedScopeButtonIndex == 0 {
                
                fetchedCountry = fetchedCountry.filter({ (country) -> Bool in
                    return country.country.lowercased().contains(searchText.lowercased())
                })
                
            }else{
                
                fetchedCountry = fetchedCountry.filter({ (country) -> Bool in
                    
                    return country.capital.lowercased().contains(searchText.lowercased())
                })
                
            }
        }
        self.tableView.reloadData()
    }
}
