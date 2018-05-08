//
//  HobbyDetails.swift
//  AllAboutPhyllis
//
//  Created by Apple28 on 4/18/18.
//  Copyright © 2018 Apple28. All rights reserved.
//

import UIKit

var hobbyIndex: Int?

class HobbyDetails: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var hobbyDescriptionLabel: UILabel!
     @IBOutlet weak var detailsImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hobbyName = hobbies[hobbyIndex!].name
        if hobbyName != "" {
            self.title = hobbyName
            hobbyDescriptionLabel.text = hobbies[hobbyIndex!].description
            detailsImage.image = hobbies[hobbyIndex!].imageName
        } else {
            self.title = "Error"
            hobbyDescriptionLabel.text = "There was a problem. Please return to the previous menu and try selecting a hobby again."        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseImageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //imagePicker.mediaTypes = [kCIAttributeTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        self.dismiss(animated: true, completion: nil)
        //if (mediaType.isEqual(to: kCIAttributeTypeImage as String)) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        detailsImage.image = image
        hobbies[hobbyIndex!].imageName = image
        //}
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
