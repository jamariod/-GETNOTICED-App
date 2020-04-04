//
//  AboutViewController.swift
//  EIPS-RSS
//
//  Created by Jamario Davis on 10/29/19.
//  Copyright © 2019 KAYCAM. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        tabBarItem.selectedImage = UIImage(named: "info")!.withRenderingMode(.alwaysOriginal);
        tabBarItem.image = UIImage(named: "info");
    }
    
    @IBAction func emailBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Email us", message: "GETNOTICED!", preferredStyle: .alert)
               let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
               let openEmail = UIAlertAction(title: "Open Email", style: .default, handler: { (actionSheetController) -> Void in _ = "info@teiaacker.com"
               let url = NSURL(string: "mailto:\("info@teiaacker.com")")
                UIApplication.shared.open(url! as URL)})
               alertController.addAction(openEmail)
               alertController.addAction(cancel)
               self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func bookBtn(_ sender: UIButton) {
        openUrl(urlStr: "https://www.barnesandnoble.com/w/let-there-be-business-mbabs-teia-a-acker/1127113458?ean=9781973718383")
    }
 
    
    @IBAction func webBtn(_ sender: UIButton) {
        openUrl(urlStr: "https://www.teiaacker.com/")
    }
    func openUrl(urlStr:String!) {
            
            if let url = NSURL(string:urlStr) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
                
            }
    }

}
    

