//
//  NewDocumentViewController.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/12/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit
import Alamofire

class NewDocumentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var projectTitle: UITextField!
    @IBOutlet weak var projectText: UITextView!
    @IBOutlet weak var segmentedTypeControl: UISegmentedControl!

    var document: Document?

    var currentTitle: String?
    var currentText: String?
    
    func currentDateFormattedForScreen() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: currentDate)
    }
    
    /*func currentDateFormattedForPosting() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd hh':'mm':'ss"
        return dateFormatter.string(from: currentDate)
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = currentDateFormattedForScreen()
        
        if let doc = self.document {
            // We are editing an existing document
            projectTitle.text = doc.title
            projectText.text = doc.text
            
            self.currentTitle = doc.title
            self.currentText = doc.text
            
            
            if self.document?.identifier == "Tidbit" {
                segmentedTypeControl.selectedSegmentIndex = 0
            }
            else if self.document?.identifier == "Project" {
                segmentedTypeControl.selectedSegmentIndex = 1
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelWasTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveWasTapped(_ sender: Any) {
        if projectTitle.text == "" {
            projectTitle.text = "Untitled - \(currentDateFormattedForScreen())"
        }
        
        var selectedType: String = "Tidbit"
        if segmentedTypeControl.selectedSegmentIndex == 0 {
            selectedType = "Tidbit"
        }
        else if segmentedTypeControl.selectedSegmentIndex == 1 {
            selectedType = "Project"
        }
        
        let newDoc = Document(title: projectTitle.text!, identifier: selectedType, text: projectText.text!, startDate: Date(), mostRecentEdit: Date())
        
        //Updating an existing document
        if let doc = self.document {
            // set docs parameters from view items
            doc.title = projectTitle.text
            doc.text = projectText.text
            doc.identifier = selectedType
            
            if ((self.currentTitle! != doc.title!) || (self.currentText! != doc.text!)) {
                doc.mostRecentEdit = Date()
            }
            
            
            if let key = doc.key {
            Alamofire.request("https://tidbits-57ae3.firebaseio.com/documents/\(key).json", method: .put, parameters: doc.toJSON(), encoding: JSONEncoding.default).responseJSON(completionHandler: {
                response in
                
                switch response.result {
                case .success:
                    self.dismiss(animated: true, completion: nil)
                    break
                    
                case .failure:
                    //TODO: display an error dialog
                    print("Failed to save new document")
                    break
                }
                
            })
            }
        }
        
        else {
        

//        print("Date: ", dateLabel.text)
//        print("Title: ", projectTitle.text)
//        print("Body: ", projectText.text)
        
            Alamofire.request("https://tidbits-57ae3.firebaseio.com/documents.json", method: .post, parameters: newDoc.toJSON(), encoding: JSONEncoding.default).responseJSON(completionHandler: {
                response in
            
                switch response.result {
                case .success:
                    self.dismiss(animated: true, completion: nil)
                    break
                
                case .failure:
                    //TODO: display an error dialog
                    print("Failed to save new document")
                    break
                }
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
