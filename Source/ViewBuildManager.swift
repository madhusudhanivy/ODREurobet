//
//  ViewBuildManager.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation

public class ViewBuildManager {
  
  // MARK: - Singleton
  public init() {}
    public static var shared = ViewBuildManager()
  
  
  // MARK: - Methods
  public func loading() -> LoadingScreenViewController {
    let vc = LoadingScreenViewController()
    vc.modalPresentationStyle = .fullScreen
    return vc
  }
}

extension ViewBuildManager {
  public func gameEmbeddedVegas() -> NativeGame {
    let vc = NativeGame()
    vc.modalPresentationStyle = .fullScreen
    return vc
  }
}
