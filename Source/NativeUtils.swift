//
//  NativeUtils.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 10/05/21.
//

import Foundation

typealias ThrowsCallback<T> = (() throws -> (T)) -> Void

public class NativeUtils: NSObject {
    public static func presentNative(_ vc: UIViewController, from parent: UIViewController? = nil, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      let parent = parent ?? UIApplication.shared.windows.first?.rootViewController
      parent?.present(vc, animated: false, completion: completion)
    }
  }

    public static func closeAll() {
    let parent = UIApplication.shared.windows.first?.rootViewController
    parent?.navigationController?.popToRootViewController(animated: true)
  }

    public static func closeFirst() {
    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
  }

}
