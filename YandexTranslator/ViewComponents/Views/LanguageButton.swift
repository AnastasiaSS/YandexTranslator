//
//  LanguageButton.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 25.01.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

protocol StateControl {
    var possibleStates: (LanguageState, LanguageState) { get set }
    func resetState()
}

class LanguageButton: UIButton {
    
    private(set) var buttonControl: StateControl?
    
    //override func awakeFromNib() {
    //    super.awakeFromNib()
    //}
    
    required init(frame: CGRect, borderWidth: CGFloat, borderColor: CGColor, background: UIImage, viewControl: StateControl? = nil, isEnabled: Bool = false) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.setup(borderWidth: borderWidth, borderColor: borderColor, background: background)
        
        self.buttonControl = viewControl
        self.isUserInteractionEnabled = isEnabled
        self.addTarget(self, action: #selector(self.touchUpInside), for: UIControl.Event.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(borderWidth: CGFloat, borderColor: CGColor, background: UIImage) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.setBackgroundImage(background, for: UIControl.State.normal)
    }
    
    @objc func touchUpInside() {
        buttonControl?.resetState()
    }
    
    func animateButton(with anotherButton: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            let tempZPozition = self.layer.zPosition
            let tempCenter = self.center
            
            self.layer.zPosition = anotherButton.layer.zPosition
            anotherButton.layer.zPosition = tempZPozition
            
            self.center = anotherButton.center
            anotherButton.center = tempCenter
        })
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
