//
//  PopoverViewController.swift
//  RSSFeed
//
//  Created by PS on 4/2/17.
//  Copyright © 2017 PrabhdeepSingh. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var lblMessage: UILabel!
    
    
    
    @IBAction func showPublishDate(sender: AnyObject) {
        let popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idPopoverViewController") as? PopoverViewController
        
        popoverViewController?.modalPresentationStyle = UIModalPresentationStyle.popover
        
      //  popoverViewController?.popoverPresentationController!.delegate = self  // commented out
        
        self.present(popoverViewController!, animated: true, completion: nil)
        
        
        
        //  popoverViewController?.popoverPresentationController?.barButtonItem = pubDateButtonItem // commented out

        popoverViewController?.popoverPresentationController?.permittedArrowDirections = .any
        popoverViewController?.preferredContentSize = CGSize(width : 200.0,height : 80.0)
        
        popoverViewController?.lblMessage.text = "Publish Date:\n\(showPublishDate)"
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
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
