//
//  CustomImage.swift
//  IChat
//
//  Created by Alper on 8.11.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import UIKit

class CustomImage: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        
    }

}
