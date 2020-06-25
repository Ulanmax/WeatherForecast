//
//  CustomButton.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/26.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit

@IBDesignable

@objc open class CustomButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateStyleWithColor(color: self.tintColor);
    }
    
    func updateStyleWithColor (color: UIColor) -> Void {
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.borderColor  = color.cgColor
        self.layer.borderWidth  = 1
        self.layer.borderColor  = color.cgColor
        self.layer.masksToBounds = false
    }
    
    open override var intrinsicContentSize: CGSize {
        var size = self.titleLabel?.intrinsicContentSize;
        size?.width += 50;
        size?.height = 50;
        return size!;
    }
}
