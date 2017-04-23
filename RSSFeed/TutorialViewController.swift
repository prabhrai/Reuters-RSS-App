//
//  TutorialViewController.swift
//  RSSFeed
//
//  Created by PS on 3/27/17.
//  Copyright © 2017 PrabhdeepSingh. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController  , UIPopoverPresentationControllerDelegate{
    
    var tutorialURL : NSURL!
    var tutorialsButtonItem : UIBarButtonItem!
    
    var publishDate : String!
  //
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webview.isHidden = true
        toolbar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: Selector(("handleFirstViewControllerDisplayModeChangeWithNotification:")), name: NSNotification.Name(rawValue: "PrimaryVCDisplayModeChangeNotification"), object: nil)
        
        tutorialsButtonItem = UIBarButtonItem(title: "Tutorials", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TutorialViewController.showTutorialsViewController))
        
        // Do any additional setup after loading the view.
    }


    
    func showTutorialsViewController(){
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if tutorialURL != nil {
            let request : NSURLRequest = NSURLRequest(url: tutorialURL as URL)
            webview.loadRequest(request as URLRequest)
            
            if webview.isHidden {
                webview.isHidden = false
                toolbar.isHidden = false
            }
        }
        
        if tutorialURL != nil {
            if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact{
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem, at: 0)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        
        return true
    }
    
    
    

    @IBAction func showPublishDate(sender: AnyObject) {
    }
    
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification){
        let displayModeObject = notification.object as? NSNumber
        let nextDisplayMode = displayModeObject?.intValue
        
        if toolbar.items?.count == 3{
            toolbar.items?.remove(at: 0)
        }
        
        if nextDisplayMode == UISplitViewControllerDisplayMode.primaryHidden.rawValue {
            toolbar.items?.insert(tutorialsButtonItem, at: 0)
        }
        else{
            toolbar.items?.insert(splitViewController!.displayModeButtonItem, at: 0)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.compact{
            let firstItem = (toolbar.items?[0])! as UIBarButtonItem
            
            if firstItem.title == "Tutorials"{
                toolbar.items?.remove(at : 0)
            }
        }
        else if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.regular{
            if toolbar.items?.count == 3{
                toolbar.items?.remove(at : 0)
            }
            
            if splitViewController?.displayMode == UISplitViewControllerDisplayMode.primaryHidden {
                toolbar.items?.insert(tutorialsButtonItem, at: 0)
            }
            else{
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem, at: 0)
            }
        }
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self)
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
