//
//  Models.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 03.02.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import Foundation

struct DetectedLang: Codable {
    var code: Int
    var lang: String
}

struct TranslatedText: Codable {
    var code: Int
    var lang: String
    var text: [String]
}

struct Error: Codable {
    var code: Int
    var message: String
}
