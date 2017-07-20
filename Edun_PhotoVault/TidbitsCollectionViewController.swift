//
//  TidbitsCollectionViewController.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/13/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit
import Alamofire
import BouncyLayout


class TidbitsCollectionViewController: UICollectionViewController {
    
    var documents: [Document] = []

    lazy var bouncyLayout = BouncyLayout(style: .regular)
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        Alamofire.request("https://tidbits-57ae3.firebaseio.com/documents.json", method: .get, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            
            self.documents = []
            
            if let json = response.result.value as? [String: AnyObject] {
                
                for (key, value) in json {
                    if let documentDictionary = value as? [String: AnyObject] {
                        let document = Document(json: documentDictionary)
                        document?.key = key
                        if document?.identifier == "Tidbit" {
                            self.documents.append(document!)
                        }
                    }
                }
                self.collectionView?.reloadData()
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - 2) / 3.5
        //collectionView?.collectionViewLayout = bouncyLayout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    
    //MARK: Number of sections and number of items in section
    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return documents.count }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tidbitCell", for: indexPath) as! TidbitCollectionViewCell
        
        cell.tidbitText?.text = documents[indexPath.row].text

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navToEditFromCollectionCell" {
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView?.indexPath(for: cell)
            let selectedDocument = documents[(indexPath?.row)!]
            
            let documentNavController = segue.destination as! UINavigationController
            let documentVC = documentNavController.topViewController as! NewDocumentViewController
            documentVC.document = selectedDocument

        }
    }
    
}



        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    

        // Do any additional setup after loading the view.


//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    // MARK: UICollectionViewDataSource
//
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TidbitCollectionViewCell
//    
//        // Configure the cell
//    
//        return cell
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */


