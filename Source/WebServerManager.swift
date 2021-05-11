//
//  WebServerManager.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation
import WebKit

@objc(WebServerManager)
class WebServerManager: NSObject {
  
  
  // MARK: - Properties
  private enum ServerState {
    case Stopped
    case Running
  }
  private var webServer: GCDWebServer = GCDWebServer()

  var port: UInt = 8080
  var webServerIndexFile: String?
  private var serverRunning: ServerState = .Stopped {
    didSet {
      switch serverRunning {
      case .Running:
        webServer.start(withPort: port, bonjourName:"RN Web Server")
        break;
      case .Stopped:
        webServer.stop()
        break;
      }
    }
  }
  var serverUrl :String? {
    get {
      return webServer.serverURL?.absoluteString
    }
  }
  
  
  
  // MARK: - Singleton
  static var shared = WebServerManager()
  private override init(){
    super.init()
  }
  
//  @objc static func requiresMainQueueSetup() -> Bool {
//    return true
//  }
  
  
  // MARK: - Methods
  public func stopServer() -> Void {
    if serverRunning == .Running {
      serverRunning = .Stopped
    }
  }
  
  public func startServer(_ rootDir: String, resolve: (String?) -> Void) {
    guard serverRunning == .Stopped else {
      resolve(serverUrl)
      return
    }
    
    configRoutes(rootDir)
    serverRunning = .Running
    resolve(serverUrl)
  }
  
  
  // MARK: - Utils
  private func configRoutes(_ rootDir: String) {
    
//    print("\n\n\n\n\n\n [Server web] serving directory: \(rootDir) \n\n\n\n\n\n")
    webServer.addGETHandler(forBasePath: "/", directoryPath: rootDir, indexFilename: webServerIndexFile, cacheAge: 3600, allowRangeRequests: true)
  }
}
