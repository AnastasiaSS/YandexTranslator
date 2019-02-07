//
//  MessageView.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 01.02.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

class MessageView: UIView {
    var isSending: Bool = true {
        didSet {
            self.backgroundColor = isSending ? colorReceive : colorSend
            
            self.clipsToBounds = true
            self.layer.cornerRadius = 10
            
            if isSending { //sending
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
            }
            else { //receiving
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }
        }
    }
    
    @IBOutlet weak var inputText: UILabel! {
        didSet {
            inputText.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var outputText: UILabel! {
        didSet {
            outputText.numberOfLines = 0
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
