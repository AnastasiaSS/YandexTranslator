//
//  MessageTableViewCell.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 2/7/19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

let colorReceive: UIColor = UIColor.red
let colorSend: UIColor = UIColor.blue

class MessageCell: UITableViewCell {
    let inputText = UILabel()
    let outputText = UILabel()
    let bubbleBackgroundView = UIView()
    
    var isSending = true {
        didSet {
            bubbleBackgroundView.backgroundColor = isSending ? colorReceive : colorSend
            
            bubbleBackgroundView.clipsToBounds = true
            bubbleBackgroundView.layer.cornerRadius = 10
            
            if isSending { //sending
                bubbleBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
            }
            else { //receiving
                bubbleBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    func initViews() {
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bubbleBackgroundView)
        
        self.addSubview(inputText)
        self.addSubview(outputText)
        
        inputText.numberOfLines = 0
        outputText.numberOfLines = 0
        
        //Constraints for input Label
        let constraints = [inputText.topAnchor.constraint(equalTo: topAnchor, constant: 32.0),
                           inputText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 32.0),
                           inputText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32.0),
                           //inputText.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: <#T##CGFloat#>)],
            inputText.widthAnchor.constraint(lessThanOrEqualToConstant: self.indentationWidth - 100),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: inputText.topAnchor, constant: -16.0),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: inputText.leadingAnchor, constant: -16.0),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 16.0),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: inputText.trailingAnchor, constant: 16.0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
