//
//  ViewController.swift
//  ODREurobet
//
//  Created by madhusudhanivy on 05/10/2021.
//  Copyright (c) 2021 madhusudhanivy. All rights reserved.
//

import UIKit
import ODREurobet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewBuildManager = ViewBuildManager.shared
        let vc = viewBuildManager.loading()

        DispatchQueue.main.async {
//          vc.loadingDidFinish = {
//            DispatchQueue.main.async {
//              NativeUtils.presentNative(viewBuildManager.gameEmbeddedVegas(), from: vc)
//            }
//          }
          NativeUtils.presentNative(vc)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

