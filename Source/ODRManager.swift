//
//  ODRManager.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation

class ODRManager {
  
  // MARK: - Properties
  var currentRequest: NSBundleResourceRequest = NSBundleResourceRequest(tags: [])
  var progress: Progress {
    return currentRequest.progress
  }
  
  
  // MARK: - Singleton
  static let shared = ODRManager()
  private init() { }
  
  
  // MARK: - Methods
  func requestResourceWith(_ tag: String, resolver: @escaping ThrowableCallback<String>) {
    // So just go like this:
    // Test; Search for this comment line and toggle comments below
//    local(tag, resolver: resolver); return;
    download(tag, resolver: resolver)
  }
  
  func local(_ tag: String, resolver: @escaping ThrowableCallback<String>) {
    resolver({ return Bundle.main.path(forResource: tag, ofType: "zip")! });
  }
}


// MARK: - ODR Download Logic
extension ODRManager {
  func download(_ tag: String, resolver: @escaping ThrowableCallback<String>) {
    currentRequest = NSBundleResourceRequest(tags: [tag])
    
    currentRequest.beginAccessingResources { error in
      if let _ = error {
        resolver({ throw GameViewController.CustomErrors.networkError })
        return
      }
      
      guard let resourcePath = self.currentRequest.bundle.path(forResource: tag, ofType: "zip") else {
        resolver({ throw GameViewController.CustomErrors.notFoundError })
        return
      }
      resolver({ return resourcePath })
      self.currentRequest.endAccessingResources()
    }
  }
}
