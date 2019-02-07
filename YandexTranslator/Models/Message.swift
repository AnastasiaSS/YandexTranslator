//
//  Message.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 2/7/19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import Foundation

class Message {
    var input: String
    var output: String
    var isSending: Bool
    
    init(input: String, output: String, isSending: Bool) {
        self.input = input
        self.output = output
        self.isSending = isSending
    }
}
