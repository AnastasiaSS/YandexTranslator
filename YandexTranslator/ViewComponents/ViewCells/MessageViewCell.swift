//
//  MessageViewCell.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 02.02.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

enum MessageType: Int {
    case receive = 0
    case send = 1
}

class MessageViewCell: UICollectionViewCell {
    @IBOutlet weak var inputText: UILabel!
    
    @IBOutlet weak var outputText: UILabel!
    
    var type: Int = MessageType.receive.rawValue {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = 10
            
            switch type {
            case MessageType.receive.rawValue:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                break
            case MessageType.send.rawValue:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
                break
            default:
                break
            }
        }
    }
}

extension UILabel {
    var optimalHeight : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
    }
}

