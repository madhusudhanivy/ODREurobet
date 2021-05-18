//
//  GameManager.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation

public typealias ThrowableCallback<T> = (() throws -> (T)) -> Void

public typealias RCTTempResponseSenderBlock = (NSArray?) -> Void
public typealias RCTTempResponseErrorBlock = (NSError?) -> Void
public typealias RCTTempPromiseResolveBlock = (Any?) -> Void
public typealias RCTTempPromiseRejectBlock = (String?, String?, Error?) -> Void

public class GameManager: NSObject {
    
    enum CustomErrors: Error {
        case genericError
        case networkError
        case notFoundError
    }
        
    // MARK: - Singleton
    public static var shared = GameManager()
    override private init() {
        super.init()
    }
    
    
    // MARK: - Properties
    var odr = ODRManager.shared
    var zip = ZipManager.shared
    var web = WebServerManager.shared
    
    public var currentGame: String?
    public var webServerIndexFile: String? {didSet{web.webServerIndexFile=webServerIndexFile}}
    public var webServerPort: UInt? {didSet{web.port=webServerPort ?? 8080}}
    public var queryString: String?
    public var isForReal: Bool?
    
    public var rctResolver: RCTTempPromiseResolveBlock?
    public var rctRejecter: RCTTempPromiseRejectBlock?
    
    
    // MARK: - Methods
    public func requestUnzippedResource(_ tag: String, resolver: @escaping ThrowableCallback<String>) {
        
        // check if resource is already unzipped
        if let resourceUnzippedPath = zip.resourceExists(tag) {
            resolver({ return resourceUnzippedPath })
            return
        }
        
        // Request resource with odr
        odr.requestResourceWith(tag) { zipPathThrowable in
            if let zipPath = try? zipPathThrowable() {
                self.zip.extractGame(zipPath, resolver: resolver)
                return
            }
            
            resolver({ throw GameManager.CustomErrors.genericError })
        }
    }
    
    
    func getCurrentGameUrl() -> String? {
        guard let _ = currentGame, let _ = webServerPort, let gameLaunchUrl = queryString else { return nil }
        return gameLaunchUrl
    }
}


// MARK: - F***ing GamesCore is unzipped as ProjectTemplate
extension GameManager {
  func requestGamesCore(resolver: @escaping ThrowableCallback<String>) {
    
    // check if resource is already unzipped
    if let resourceUnzippedPath = zip.gamesCoreExists() {
      resolver({ return resourceUnzippedPath })
      return
    }
    
    // Request resource with odr
    odr.requestResourceWith("GamesCore") { zipPathThrowable in
      if let zipPath = try? zipPathThrowable() {
        self.zip.extractGame(zipPath, resolver: resolver)
        return
      }
      
      resolver({ throw GameManager.CustomErrors.genericError })
    }
  }
}
