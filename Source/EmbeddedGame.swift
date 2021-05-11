//
//  EmbeddedGame.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation

typealias EventData = Dictionary<String, Any>

@objc(EmbeddedGameBridge)
class EmbeddedGame: NSObject {
  
  let game = GameManager.shared
  let view = ViewBuildManager.shared
  
  @objc func getGamesCore(_ resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    
    game.requestUnzippedResource("GamesCore") { throwable in
      if let path = try? throwable() {
        resolver(path)
      } else {
        rejecter("-1", nil, nil)
      }
    }
  }
}
