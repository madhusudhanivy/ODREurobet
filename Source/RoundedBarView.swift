//
//  RoundedBarView.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import Foundation

@IBDesignable
open class RoundedBarView: UIView {
  open override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.height / 2
  }
}
