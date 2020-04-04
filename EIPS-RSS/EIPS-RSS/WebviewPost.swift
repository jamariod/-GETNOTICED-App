//
//  WebviewPost.swift
//  EIPS-RSS
//
//  Created by Jamario Davis on 10/29/19.
//  Copyright © 2019 KAYCAM. All rights reserved.
//

import UIKit
import WebKit

class WebviewPost: UIViewController, WKNavigationDelegate {

   var webView: WKWebView!
       var blogPostURL: URL!
       
       override func viewDidLoad() {
           webView = WKWebView()
           webView.navigationDelegate = self
           view = webView
           _ = URLRequest(url: blogPostURL!)
           webView.load(URLRequest(url: blogPostURL!))
           webView.sizeToFit()
   }
     
}
