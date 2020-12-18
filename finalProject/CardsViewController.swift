//
//  CardsViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 17.12.2020.
//

import UIKit
import RealmSwift
import SVGKit

class CardsViewController: UIViewController {
    
    var user: User!
    var incomingData = List<Country>()
    var checker: String!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
   }
}
extension CardsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardTableViewCell
        if !incomingData.isEmpty {
            cell.flagField.layer.cornerRadius = cell.flagField.frame.height / 2
            cell.countryField.text = incomingData[indexPath.row].country
            let svg = URL(string: incomingData[indexPath.row].flag)!
            let data = try? Data(contentsOf: svg)
            let receivedimage: SVGKImage = SVGKImage(data: data)
            cell.flagField.image = receivedimage.uiImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
                        
            let realm = try! Realm()
                try! realm.write {
                    if self.checker == "flag"{
                        self.user.flags.remove(at: indexPath.item)
                    }else if self.checker == "capital"{
                        self.user.capitals.remove(at: indexPath.item)
                    }
                    self.incomingData.remove(at: indexPath.item)
                }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
}
