//
//  ProjectsTableViewController.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/10/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit
import Alamofire

class ProjectsTableViewController: UITableViewController {

    var documents: [Document] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        Alamofire.request("https://tidbits-57ae3.firebaseio.com/documents.json", method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            
            self.documents = []
            
            if let json = response.result.value as? [String: AnyObject] {
                
                for (key, value) in json {
                    if let documentDictionary = value as? [String: AnyObject] {
                        let document = Document(json: documentDictionary)
                        document?.key = key
                        if document?.identifier == "Project" {
                            self.documents.append(document!)
                        }
                    }
                }

                //sort the projects according to the most recently editted
                self.documents.sort { $0.mostRecentEdit! > $1.mostRecentEdit! }
                
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return documents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        cell.textLabel?.text = documents[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "navToEditFromCell" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let selectedDocument = documents[(indexPath?.row)!]
            
            let documentNavController = segue.destination as! UINavigationController
            let documentVC = documentNavController.topViewController as! NewDocumentViewController
            documentVC.document = selectedDocument
        }
        
        // 1. get indexPath 
        // 2. get the selected document
        // segue.destination cast to your view controller
        // set the document
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
