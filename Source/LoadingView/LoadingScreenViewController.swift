//
//  LoadingScreenViewController.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import UIKit

public class LoadingScreenViewController: UIViewController {
    
    // MARK : -IBOutlets
    @IBOutlet weak var loadingBar :LoadingBarView!
    
    
    // MARK: - Properties
    private var game = GameManager.shared
    private var views = ViewBuildManager.shared
    
    
    // MARK: - Callbacks
    public var loadingDidFinish: (() -> Void)?
    private var loadingHasFailedWith: ((NSError) -> Void)?
    
    
    //MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
        
        guard let tag = game.currentGame else {
            errorHandler("No resource tag passed")
            return
        }
        
        // Test; Search for this comment line and toggle comments below
        //    game.currentGame = tag; loadingDidFinish?(); return
        initializeLoading(tag)
    }
    
    
    // MARK: - Methods
    func initializeLoading(_ tag: String) {
        unzipHandler("GamesCore") { _ in
            self.unzipHandler(tag) { _ in
                self.game.currentGame = tag
                self.loadingDidFinish?()
            }
            self.observeProgress()
        }
    }
    
    
    // MARK: - Utils
    func unzipHandler(_ resourceTag: String, resolve: @escaping (String) -> Void) {
        game.requestUnzippedResource(resourceTag) { pathThrowable in
            guard let resourcePath = try? pathThrowable() else {
                self.errorHandler("couldn't unzip file \(resourceTag)")
                return
            }
            resolve(resourcePath)
        }
    }
    
    func observeProgress() {
        loadingBar.progress = game.odr.currentRequest.progress
    }
    
    func errorHandler(_ errorDescription: String) {
        game.rctRejecter?(errorDescription, nil, nil)
    }
}
