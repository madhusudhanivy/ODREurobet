//
//  NativeGame+WebView.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation
import WebKit

extension NativeGame {
  func getWKWebView() -> WKWebView {
    
    if let alreadyInstatiated = wkWebView {
      return alreadyInstatiated
    }
    
    return buildWKWebView()
  }
  
  fileprivate func buildWKWebView() -> WKWebView {
    
    let configuration = WKWebViewConfiguration()
    configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
    configuration.allowsInlineMediaPlayback = true
    configuration.userContentController.addUserScript(buildUserScript())
    configuration.userContentController.add(self, name: eventName)
    
    print(layerView)
    
    let wkWebView = WKWebView(frame: self.view.frame, configuration: configuration)
    wkWebView.scrollView.showsVerticalScrollIndicator = false
    wkWebView.scrollView.showsHorizontalScrollIndicator = false
    wkWebView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(wkWebView)
    fitIntoWebView(wkWebView)
    self.wkWebView = wkWebView
    
    self.wkWebView.backgroundColor = UIColor.blue
    
    return wkWebView
  }
  
  fileprivate func buildUserScript() -> WKUserScript {
    
    let jScript = """
      window.open = function (open){
        return function(url, name, features){
          var message = function(obj){
          window.webkit.messageHandlers.\(eventName).postMessage(JSON.stringify(obj),'*')
          };

          url.lastIndexOf('close-game') > 0 ? message({type: 'closeGame'}) : message({type: 'openUrl', data: {url: url}});
          return window;
        };
      } (window.open)
    """
    
    return WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
  }
}


//MARK: - Private Helpers
extension NativeGame {
  fileprivate func fitIntoWebView(_ wkWebView: WKWebView) {
    NSLayoutConstraint.activate([
        wkWebView.topAnchor.constraint(equalTo: self.view.topAnchor),
        wkWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        wkWebView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        wkWebView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ])
  }
  
  func removeCacheData() {
    getWKWebView().configuration.userContentController.removeScriptMessageHandler(forName: eventName)
    
    wkWebView = nil;
    
    HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
    
    WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
      records.forEach { record in
        WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
      }
    }
  }

}
