//
//  TestUIView.swift
//  iSport
//
//  Created by Gianluigi Oliva on 19/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import WebKit

class WebViewNews: UIView {
    
    var WebView: WKWebView!
    var urlNews: String?{
        
        didSet{
            if let url = URL(string: urlNews!) {
                let request = URLRequest(url: url)
                WebView.load(request)
            }
        }
    }
    
    var topAnchorAnimated: NSLayoutConstraint?
    var constraintHeight: NSLayoutConstraint?
    var dismissButton: UIBarButtonItem?
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        self.addSubview(navBar)
        let barItem = UINavigationItem(title: "Top")
        dismissButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissWebView))
        barItem.leftBarButtonItem = dismissButton
        navBar.setItems([barItem], animated: false);
        
        
        WebView = WKWebView()
        self.addSubview(WebView)
        
        WebView.translatesAutoresizingMaskIntoConstraints = false
        WebView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0).isActive = true
        WebView.bottomAnchor.constraint(equalTo: WebView.superview!.bottomAnchor, constant: 0).isActive = true
        WebView.leadingAnchor.constraint(equalTo: WebView.superview!.leadingAnchor, constant: 0).isActive = true
        WebView.trailingAnchor.constraint(equalTo: WebView.superview!.trailingAnchor, constant: 0).isActive = true
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: navBar.superview!.topAnchor, constant: 0).isActive = true
        navBar.leadingAnchor.constraint(equalTo: navBar.superview!.leadingAnchor, constant: 0).isActive = true
        navBar.trailingAnchor.constraint(equalTo: navBar.superview!.trailingAnchor, constant: 0).isActive = true
    }
    
    
    
    
    @objc func dismissWebView(){
        self.superview!.layoutIfNeeded()
        
        self.topAnchorAnimated!.isActive=false
        self.constraintHeight!.isActive=true
        
        
        UIView.animate(withDuration: 1, animations: {
            self.superview!.layoutIfNeeded()
        }, completion: { (animazioneFinita) in
            self.removeFromSuperview()
            })

    }

}
