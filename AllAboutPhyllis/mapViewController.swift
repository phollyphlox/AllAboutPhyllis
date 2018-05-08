//
//  mapViewController.swift
//  AllAboutPhyllis
//
//  Created by Apple28 on 4/20/18.
//  Copyright © 2018 Apple28. All rights reserved.
//

import UIKit
import MapKit

var mapPins:[MKPointAnnotation] = []

class mapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userPoint = UILongPressGestureRecognizer(target: self, action: #selector(mapViewController.addPin(_:)))
        userPoint.minimumPressDuration = 2.0
        
        myMap.addGestureRecognizer(userPoint)
        
        let italy = MKPointAnnotation()
        italy.coordinate = CLLocationCoordinate2DMake(41.8947400, 12.4839000)
        italy.title = "Rome, Italy"
        
        let england = MKPointAnnotation()
        england.coordinate = CLLocationCoordinate2DMake(51.5085300, -0.1257400)
        england.title = "London, England"
        
        let norway = MKPointAnnotation()
        norway.coordinate = CLLocationCoordinate2DMake(59.914225, 10.75256)
        norway.title = "Oslo, Norway"
        
        let spain = MKPointAnnotation()
        spain.coordinate = CLLocationCoordinate2DMake(40.41694, -3.70081)
        spain.title = "Madrid, Spain"
        
        // to prevent the above annotations from being added to the list every time you switch from the list to the map you must test to see if they have already been added. This will make sure they are only added when the app starts
        if (mapPins.isEmpty){
            mapPins = [italy, england, norway, spain]
        }
        
        myMap.addAnnotations(mapPins)
        
        var myRegion = MKCoordinateRegionMakeWithDistance(italy.coordinate, 5500000, 5500000)
        myMap.setRegion(myRegion, animated: true)
        
        func mapView(_ mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinIdentifier")
            return pin
        }    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addPin(_ gestureRecognizer: UIGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: self.myMap)
        let newCoordinate:CLLocationCoordinate2D = myMap.convert(touchPoint, toCoordinateFrom: self.myMap)
        
        //The following code will create a pop up box when the app recognizes a long press on the map
        let alert = UIAlertController(title: "New Place", message: "Enter name for place", preferredStyle: UIAlertControllerStyle.alert)
        
        //This line adds a text field to the pop up box where the user can enter data
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter place name:"
        })
        
        //The following lines of code creates a button for the pop up box and tells the program what to do when the button is tapped.
        let addLocation = UIAlertAction(title:"Add Location", style: UIAlertActionStyle.destructive) {(UIAlertAction) -> Void in
            
            let newAnnotation = MKPointAnnotation()
            
            //This line will unwrap the data in the text field that the user entered and assign it to a variable of UITextField type. If the user leaves it blank it will not crash the program. It simply will not add a title to their annotation and their new place will not be assigned to list of countries.
            let textField = alert.textFields![0] as UITextField
            
            newAnnotation.coordinate = newCoordinate //coordinate where user long pressed
            newAnnotation.title = textField.text     //the text the user entered in the text box
            self.myMap.addAnnotation(newAnnotation)//adds a pin to map where the user long pressed
            locations.append((newAnnotation.title)!)    //adds the title of the new location to the countries list
            mapPins.append(newAnnotation)          //adds the new annotation to the list of locations
            
            
        }
        
        alert.addAction(addLocation) //adds the newly created button to the pop up box
        
        self.present(alert, animated: true, completion:nil) //presents the pop up box
        
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
