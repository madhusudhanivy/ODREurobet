//
//  NativeGame.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import UIKit

import WebKit

public class NativeGame: UIViewController {

  
  // MARK: - Properties
  var game = GameManager.shared
  let eventName = "embeddedGameWKHandler"
  var wkWebView :WKWebView! = nil
  
  
  // MARK: - IBOutlets
  @IBOutlet weak var webView :UIView!
  
  
  // MARK: - View Lifecycle
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    game.web.startServer(game.zip.savedGamePath) { serverPath in
      guard let gameUrl = game.getCurrentGameUrl(), let url = URL(string: gameUrl) else {
        game.rctRejecter?("Could not retrieve game url", nil, nil)
        return
      }
      getWKWebView().load(URLRequest(url: url))
      game.rctResolver?(true)
    }
  }
  
  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    removeCacheData()
  }
}
