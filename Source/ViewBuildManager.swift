//
//  ViewBuildManager.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation

class ViewBuildManager {
  
  // MARK: - Singleton
  private init() {}
  static var shared = ViewBuildManager()
  
  
  // MARK: - Methods
  func loading() -> LoadingScreenViewController {
    let vc = LoadingScreenViewController()
    vc.modalPresentationStyle = .fullScreen
    return vc
  }
}
