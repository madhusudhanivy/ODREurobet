//
//  EmbeddedGame+Native.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation

extension EmbeddedGame {
  @objc func openEmbeddedGame(_ tagName: NSString,
                              webServerPort: NSNumber,
                              gameLaunchUrl: NSString,
                              resolver: @escaping RCTPromiseResolveBlock,
                              rejecter: @escaping RCTPromiseRejectBlock) {
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

extension ViewBuildManager {
  func gameEmbeddedVegas() -> NativeGame {
    let vc = NativeGame()
    vc.modalPresentationStyle = .fullScreen
    return vc
  }
}