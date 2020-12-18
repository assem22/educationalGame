//
//  MapViewController.swift
//  finalProject
//
//  Created by Assem Mukhamadi on 16.12.2020.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate {

    @IBAction func searchBtn(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
                searchController.searchBar.delegate = self
                present(searchController, animated: true, completion: nil)
    }
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.isUserInteractionEnabled = false
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true , completion: nil)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
                
                activeSearch.start { (response, error) in
                    
                    activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                    {
                        //Remove annotations
                        let annotations = self.myMap.annotations
                        self.myMap.removeAnnotations(annotations)
                        
                        //Getting data
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        //Create annotation
                        let annotation = MKPointAnnotation()
                        annotation.title = searchBar.text
                        annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.myMap.addAnnotation(annotation)
                        
                        //Zooming in on annotation
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        let region = MKCoordinateRegion(center: coordinate, span: span)
                        self.myMap.setRegion(region, animated: true)
                    }
                }
    }
}
