//
//  LoadingBarView.swift
//  ODREurobet
//
//  Created by Madhusudhan Reddy Putta on 11/05/21.
//

import UIKit

class LoadingBarView: UIView {
    
    // MARK: - Lifecycle
    override init(frame: CGRect) { // Custom View code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // Custom View IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // init here
                
        let nib = UINib(nibName: "LoadingBarView", bundle: Bundle().getBundle())
        contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var frontBar: RoundedBarView!
    @IBOutlet weak var backBar: RoundedBarView! {
        didSet { backBar.layer.borderWidth = 1 }
    }
    @IBOutlet weak var fractionCompletedWidth: NSLayoutConstraint!
    
    
    // MARK: - Properties
    var percentage :Double = 100 {
        didSet {
            DispatchQueue.main.async {
                let width = self.backBar.frame.size.width * CGFloat(self.percentage / 100.0)
                self.fractionCompletedWidth.constant = width
                self.updateConstraints()
            }
        }
    }
    
    @IBInspectable
    var barColor: UIColor? {
        didSet {
            frontBar.backgroundColor = barColor
            backBar.layer.borderColor = barColor?.cgColor
            backBar.layer.borderWidth = 1
        }
    }
    
    
    private var observation: NSKeyValueObservation? = nil
    var progress :Progress = Progress() {
        didSet {
            observation = progress.observe(\.fractionCompleted, options: [.new]) { _, _ in
                self.percentage = self.progress.fractionCompleted * 100
            }
        }
    }
    
    
    // MARK: - Utils
    deinit {
        observation = nil
    }
    
}
