//
//  EmbededManager.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 18/05/21.
//

import Foundation

public class EmbededCommunicatorManager {
    
    // MARK: - Singleton
    public static let shared = EmbededCommunicatorManager()

    let game = GameManager.shared
    let view = ViewBuildManager.shared
    
    public func getGamesCore(_ resolver: @escaping RCTTempPromiseResolveBlock, rejecter: @escaping RCTTempPromiseRejectBlock) {
        
        game.requestUnzippedResource("GamesCore") { throwable in
          if let path = try? throwable() {
            resolver(path)
          } else {
            rejecter("-1", nil, nil)
          }
        }
    }
    
    public func openEmbeddedGame(_ tagName: NSString,
                                webServerPort: NSNumber,
                                gameLaunchUrl: NSString,
                                resolver: @escaping RCTTempPromiseResolveBlock,
                                rejecter: @escaping RCTTempPromiseRejectBlock) {
      game.currentGame = tagName as String?
      game.webServerPort = UInt(truncating: webServerPort)
      game.queryString = gameLaunchUrl as String?
      game.webServerIndexFile = nil
      
      game.rctRejecter = rejecter
      game.rctResolver = resolver
      
      DispatchQueue.main.async {
        let vc = self.view.loading()
        vc.loadingDidFinish = {
          DispatchQueue.main.async {
            NativeUtils.presentNative(self.view.gameEmbeddedVegas(), from: vc)
          }
        }
        NativeUtils.presentNative(vc)
      }
    }
    
}
