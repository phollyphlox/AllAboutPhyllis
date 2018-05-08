//
//  HobbiesTableView.swift
//  AllAboutPhyllis
//
//  Created by Apple28 on 4/16/18.
//  Copyright © 2018 Apple28. All rights reserved.
//

import UIKit

var hobbies:[hobby] = []

class HobbiesTableView: UITableViewController {
    
    
    var hobbyToPass = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var knit = hobby()
        knit.name = "Knitting"
        knit.description = "Knitting is a textile art that uses 2 pointed needles to form knots in yarn to create fabric."
        knit.imageName = UIImage(named: "knitting.jpg")
        
        var crochet = hobby()
        crochet.name = "Crochet"
        crochet.description = "Crocheting is a textile art that uses a hook to form knots in yarn to create fabric."
        crochet.imageName = UIImage(named: "crochet.jpg")
        
        var read = hobby()
        read.name = "Reading"
        read.description = "Reading is relaxing and fun."
        read.imageName = UIImage(named: "reading.jpg")
        
        var hike = hobby()
        hike.name = "Hiking"
        hike.description = "Hiking is fun and it is good exercise."
        hike.imageName = UIImage(named: "hiking.jpg")
        
        var swim = hobby()
        swim.name = "Swimming"
        swim.description = "Swimming is fun and it is good exercise"
        swim.imageName = UIImage(named: "swimming.jpg")
        
        //prevents the list from being display multiple times after the array has been set up the first time
        //the scene was displayed.
        if hobbies.count == 0 {
            hobbies += [knit, crochet, read, hike, swim]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hobbies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hobbyIdentifier", for: indexPath)

        // Configure the cell...
        let aHobby = hobbies[indexPath.row]
        cell.textLabel?.text = aHobby.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        hobbyIndex = indexPath.row
    }
    
    @IBAction func btnAddHobby(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Hobby", message: "Add a new hobby to list", preferredStyle: UIAlertControllerStyle.alert)
        
        //This line adds a text field to the pop up box where the user can enter the new hobby
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter hobby here:"
        })
        
        //This line adds another text field to the pop up box where the user can enter details about the hobby
        alert.addTextField(configurationHandler: {(detailsField: UITextField!) in
            detailsField.placeholder = "Enter details about your new hobby here: "
        })
        
        //The following lines of code creates a button for the pop up box and tells the program what to do when the button is tapped.
        let addHobby = UIAlertAction(title:"Add Hobby", style: UIAlertActionStyle.destructive) {(UIAlertAction) -> Void in
            
            
            
            //This line will unwrap the data in the text field that the user entered and assign it to a variable of UITextField type. If the user leaves it blank it will not crash the program. It simply will not add a title to their annotation and their new hobby will not be assigned to list of hobbies.
            let textField = alert.textFields![0] as UITextField
            let detailsField = alert.textFields![1] as UITextField
            
            var aNewHobby = hobby()
            aNewHobby.name = textField.text!
            aNewHobby.description = detailsField.text!
            aNewHobby.imageName = UIImage(named: "noImage.png")
            
            if aNewHobby.name != "" {
                hobbies += [aNewHobby]         //adds the new hobby to the list of hobbies
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath.init(row: hobbies.count - 1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }
        }
        
        
        alert.addAction(addHobby) //adds the newly created button to the pop up box
        
        self.present(alert, animated: true, completion:nil) //presents the pop up box
        
        self.tableView.reloadData()
        
        self.tableView.setNeedsDisplay()
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            hobbies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
       /* } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view */
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
