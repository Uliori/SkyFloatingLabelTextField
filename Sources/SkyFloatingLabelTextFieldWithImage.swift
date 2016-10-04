//
//  SkyFloatingLabelTextWithImage.swift
//  SkyFloatingLabelTextField
//
//  Created by El Mehdi KHALLOUKI on 7/21/16.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

/**
 A beautiful and flexible textfield implementation with support for icon, title label, error message and placeholder.
 */
open class SkyFloatingLabelTextFieldWithImage: RLSkyFloatingLabelTextField {
    
    /// A UILabel value that identifies the label used to display the icon
    open var imageView:UIImageView!
    
    /// A String value that determines the text used when displaying the icon
    @IBInspectable
    open var image:UIImage? {
        didSet {
            self.imageView?.image = image
        }
    }
    
    /// A float value that determines the width of the icon
    @IBInspectable open var imageWidth:CGFloat = 20 {
        didSet {
            self.updateFrame()
        }
    }
    
    // MARK: Initializers
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.createLeftImage()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createLeftImage()
    }
    
    // MARK: Creating the icon label
    
    /// Creates the icon label
    fileprivate func createLeftImage() {
        imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .center
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.addSubview(imageView)
    }
    
    // MARK: Handling the icon color
    
    /// Update the colors for the control. Override to customize colors.
    override open func updateColors() {
        super.updateColors()
    }
    
    // MARK: Custom layout overrides
    
    /**
     Calculate the bounds for the textfield component of the control. Override to create a custom size textbox in the control.
     - parameter bounds: The current bounds of the textfield component
     - returns: The rectangle that the textfield component should render in
     */
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(imageWidth)
        } else {
            rect.origin.x -= CGFloat(imageWidth)
        }
        rect.size.width -= CGFloat(imageWidth)
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(imageWidth)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(imageWidth)
        return rect
    }
    
    /**
     Calculates the bounds for the placeholder component of the control. Override to create a custom size textbox in the control.
     - parameter bounds: The current bounds of the placeholder component
     - returns: The rectangle that the placeholder component should render in
     */
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(imageWidth)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(imageWidth)
        return rect
    }
    
    /// Invoked by layoutIfNeeded automatically
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
    
    fileprivate func updateFrame() {
        let textHeight = self.textHeight()
        let textWidth:CGFloat = self.bounds.size.width
        if isLTRLanguage {
            self.imageView.frame = CGRect(x: 0, y: self.bounds.origin.y, width: imageWidth, height: self.bounds.size.height)
        } else {
            self.imageView.frame = CGRect(x: textWidth - imageWidth , y: self.bounds.size.height - textHeight, width: imageWidth, height: textHeight)
        }
    }
}
