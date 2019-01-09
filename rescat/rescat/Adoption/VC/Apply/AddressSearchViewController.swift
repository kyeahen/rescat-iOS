//
//  AddressSearchViewController.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import UIKit
import WebKit

class AddressSearchViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    
    var webView: WKWebView?
    
    let indicator = UIActivityIndicatorView(style: .gray)
    var address = ""
    let unwind = "unwind"
    
    override func loadView() {
        super.loadView()
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: .zero, configuration: config)
        self.view = self.webView!
        self.webView?.navigationDelegate = self
        
        self.webView?.addSubview(indicator)
        indicator.center.x = UIScreen.main.bounds.width/2
        indicator.center.y = UIScreen.main.bounds.height/2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        
        guard
            let url = URL(string: "https://trilliwon.github.io/postcode/"),
            let webView = webView else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        self.webView?.navigationDelegate = self
        indicator.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == unwind {
            if let destination = segue.destination as? ApplyAdoptViewController{
                destination.mainAddressTextField.text = address
            }
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let postCodData = message.body as? [String: Any] {
            address = postCodData["addr"] as? String ?? ""
        }
        
        performSegue(withIdentifier: unwind, sender: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        indicator.stopAnimating()
    }
}
