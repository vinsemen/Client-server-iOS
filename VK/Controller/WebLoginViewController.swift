//
//  WebLoginViewController.swift
//  VK
//
//  Created by Семён Винников on 28.11.2022.
//

import UIKit
import WebKit

class WebLoginViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    let session = Session.shared
    var loginVC: LoginViewController?
    
    let appId = "51396340"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: appId),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        
        let url = urlComponent.url
        if UIApplication.shared.canOpenURL(url!) {
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }
}


extension WebLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()) { res, param in
                
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        
        if let token = params["access_token"] {
            self.session.token = token
            
            loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webLogin") as? LoginViewController
            
            self.view.insertSubview((loginVC?.view)!, at: 9)
        }
        decisionHandler(.cancel)
    }
}
