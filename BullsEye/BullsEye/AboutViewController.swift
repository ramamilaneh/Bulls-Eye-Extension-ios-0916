//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Rama Milaneh on 9/15/16.
//  Copyright © 2016 RAMA. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated : true, completion: nil)
    }
    
    override func viewDidLoad() { super.viewDidLoad()
        if let htmlFile = Bundle.main.path(forResource: "BullsEye", ofType: "html") {
            if let htmlData = NSData(contentsOfFile: htmlFile) {
                let baseURL = NSURL(fileURLWithPath:Bundle.main.bundlePath)
                webView.load(htmlData as Data, mimeType: "text/html",
                        textEncodingName: "UTF-8", baseURL: baseURL as URL)
            } }
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
