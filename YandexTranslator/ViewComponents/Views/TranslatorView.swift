//
//  TranslatorView.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 25.01.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

extension UIButton {
    func setCornerRadius(isRounded: Bool) {
        layer.cornerRadius = isRounded ? frame.size.height / 2 : 0
        layer.masksToBounds = isRounded
    }
}

enum SendButtonState {
    case record
    case wait
    case send
}

class ViewStyle {
    var name: String
    var color: UIColor
    required init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}

enum LanguageState {
    case active
    case passive
    case any
}
class TranslatorView: UIView, StateControl {
    let styleMap: [LanguageState : ViewStyle ] = [.active : ViewStyle(name: "Русский", color: UIColor.red),
                                                           .passive : ViewStyle(name: "Английский", color: UIColor.blue) ]
    
    var possibleStates: (LanguageState, LanguageState) = (.any, .any) {
        willSet {
            //ui changes
            if let style = styleMap[possibleStates.1] {
                resetViewStyle(languageStyle: style)
            }
        }
    }
    
    private func resetViewStyle(languageStyle: ViewStyle) {
        textView.text = languageStyle.name
        contentView.tintColor = languageStyle.color
    }
    
    func resetState() {
        let (activeLang, passiveLang) = possibleStates
        possibleStates = (passiveLang, activeLang)
        let isEnabled = leftLanguageButton.isUserInteractionEnabled
        if isEnabled {
            leftLanguageButton.animateButton(with: rightLanguageButton)
        }
        else {
            rightLanguageButton.animateButton(with: leftLanguageButton)
        }
        leftLanguageButton.isUserInteractionEnabled = !isEnabled
        rightLanguageButton.isUserInteractionEnabled = isEnabled
    }
    
    //Layout constraints
    static let subviewMargin: CGFloat = 5.0;
    
    @IBOutlet var contentView: UIView!
    
    var leftLanguageButton: LanguageButton! {
        didSet {
            leftLanguageButton.setCornerRadius(isRounded: true)
        }
    }
    
    var rightLanguageButton: LanguageButton! {
        didSet {
            rightLanguageButton.setCornerRadius(isRounded: true)
        }
    }
    
    var textView: UITextView!
    
    var controlButton: UIButton! {
        didSet {
            controlButton.setCornerRadius(isRounded: true)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = frame.size.height / 2
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    let mainColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TranslatorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addSubviews()

    }
    
    private func addSubviews() {
        calculateConstraintsForSubviews()
        //add subviews
        contentView.addSubview(leftLanguageButton)
        contentView.addSubview(rightLanguageButton)
        contentView.addSubview(textView)
        contentView.addSubview(controlButton)
    }
    
    //todo: fix using special file with configures
    private func calculateConstraintsForSubviews() {
        let viewWidth = contentView.bounds.width
        let viewHeight = contentView.bounds.height
        
        let buttonDiameter = viewHeight - TranslatorView.subviewMargin * 2
        let centerY = viewHeight / 2
        
        let startPoint = CGPoint(x: 0, y: 0)
        let buttonSize = CGSize(width: buttonDiameter, height: buttonDiameter)
        let buttonFrame = CGRect(origin: startPoint, size: buttonSize)
        
        leftLanguageButton = LanguageButton(frame: buttonFrame, borderWidth: TranslatorView.subviewMargin / 2, borderColor: mainColor.cgColor, background: UIImage(named: "RusIcon")!, viewControl: self, isEnabled: true)
        
        leftLanguageButton.center = CGPoint(x: buttonDiameter / 2 + TranslatorView.subviewMargin, y: centerY)
        
        rightLanguageButton = LanguageButton(frame: buttonFrame, borderWidth: TranslatorView.subviewMargin / 2, borderColor: mainColor.cgColor, background: UIImage(named: "EngIcon")!, viewControl: self, isEnabled: false)
        
        rightLanguageButton.center = CGPoint(x: leftLanguageButton.center.x + buttonDiameter / 4, y: centerY)
        
        //configure z position for buttons
        rightLanguageButton.layer.zPosition = 1
        
        //controlButton
        controlButton = UIButton(frame: buttonFrame)
        controlButton.center = CGPoint(x: viewWidth - TranslatorView.subviewMargin - buttonDiameter / 2, y: centerY)
        
        //textfield configures
        let textViewWidth = viewWidth - (TranslatorView.subviewMargin * 8 + buttonDiameter * 2 + buttonDiameter / 4)
        let textViewHeight = viewHeight - TranslatorView.subviewMargin * 4
        textView = UITextView(frame: CGRect(origin: startPoint, size: CGSize(width: textViewWidth, height: textViewHeight)))
        textView.center = CGPoint(x: viewWidth / 2, y: centerY)
        
        textView.contentSize = CGSize(width: textViewWidth, height: textViewHeight)
        textView.textColor = mainColor
        textView.backgroundColor = UIColor.black
    }
    
    private func resetStateButton() {
        
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
