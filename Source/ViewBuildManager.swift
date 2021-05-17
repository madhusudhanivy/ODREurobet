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
    
    let bundle = Bundle(for: GameManager.self)
    let bundleURL = (bundle.resourceURL?.appendingPathComponent("ODREurobet.bundle"))!
    let vc = LoadingScreenViewController(nibName: "LoadingScreenViewController", bundle: Bundle.init(url: bundleURL))
    vc.modalPresentationStyle = .fullScreen
    return vc
  }
}

extension ViewBuildManager {
  public func gameEmbeddedVegas() -> NativeGame {
    let bundle = Bundle(for: GameManager.self)
    let bundleURL = (bundle.resourceURL?.appendingPathComponent("ODREurobet.bundle"))!
    let vc = NativeGame(nibName: "NativeGame", bundle: Bundle.init(url: bundleURL))
    vc.modalPresentationStyle = .fullScreen
    return vc
  }
}
