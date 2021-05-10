//
//  GameViewController.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 10/05/21.
//

import Foundation

@objc(MainViewController)
class GameViewController: NSObject {
  
  enum CustomErrors: Error {
    case genericError
    case networkError
    case notFoundError
  }
  
  
  // MARK: - Properties
  @objc var tagName :NSString?
  @objc var port :NSNumber?
  @objc var gameLaunchUrl :NSString?
  private var views = ViewBuildManager.shared
  private var game = GameManager.shared
  
  
  // MARK: - Methods
  @objc func getGamesCore() {
    game.requestUnzippedResource("GamesCore") { throwable in }
  }
  
  @objc func openEmbeddedGame(_ tagName: NSString, webServerPort: NSNumber, gameLaunchUrl: NSString, resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    game.currentGame = tagName as String?
    game.webServerPort = UInt(truncating: port ?? 8080)
    game.queryString = gameLaunchUrl as String?
    game.rctRejecter = rejecter
    game.rctResolver = resolver
    
    NativeUtils.presentNative(views.loading())
  }
}
