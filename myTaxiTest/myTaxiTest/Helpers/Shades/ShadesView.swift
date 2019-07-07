//
//  ShadesView.swift
//  myTaxiTest
//
//  Created by Waqas Sultan on 7/1/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

import Foundation
import UIKit




/// The base class for Shades views.
@IBDesignable open class ShadesView: UIView {
    
    private func setupValues(){
        self.layer.cornerRadius = self.cornerRadius
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
        
    }
    
    open override func prepareForInterfaceBuilder() {
        self.setupValues()
        
    }
    
    open override func awakeFromNib() {
        self.setupValues()
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable public var borderWidth: CGFloat = 0.0
    @IBInspectable public var borderColor: UIColor = UIColor.color(red: 0, green: 0, blue: 0, alpha: 1.0)
    @IBInspectable public var shadowColor: UIColor = UIColor.color(red: 0, green: 0, blue: 0, alpha: 1.0)
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 4)
    @IBInspectable public var shadowRadius: CGFloat = 23.0
    @IBInspectable public var shadowOpacity: Float = 0.1
}

