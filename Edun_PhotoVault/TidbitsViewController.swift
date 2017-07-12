//
//  TidbitsViewController.swift
//  Edun_PhotoVault
//
//  Created by Jacob Shavel on 7/12/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit

class TidbitsViewController: UIViewController {
    
    //MARK: View Making methods
    func makeButtonWithText(text:String) -> UIButton {
        let myButton = UIButton(type: UIButtonType.system)
        myButton.frame = CGRect(x: 30, y: 30, width: 150, height: 150)
        myButton.titleLabel?.text = "haaaaaaaay"
        myButton.backgroundColor = UIColor.blue
        return myButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        view.addSubview(makeButtonWithText(text: "PracticeButton"))

        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
