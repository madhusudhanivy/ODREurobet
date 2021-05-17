//
//  Bundle+xib.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 17/05/21.
//

import Foundation

extension Bundle {
    
    func getBundle() -> Bundle {
        
        let bundle = Bundle(for: GameManager.self)
        let bundleURL = (bundle.resourceURL?.appendingPathComponent("ODREurobet.bundle"))!
        return Bundle.init(url: bundleURL)!
    }
    
}
