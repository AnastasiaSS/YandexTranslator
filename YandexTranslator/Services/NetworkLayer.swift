//
//  NetworkLayer.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 03.02.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import Foundation
import Moya

enum YandexServerAPI {
    case getLangs(ui: String)
    case detect(text: String, hint: [String])
    case translate(text: String, lang: String)
}

extension YandexServerAPI: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL { return URL(string: "https://translate.yandex.net/api/v1.5/tr.json")! }
    
    var path: String {
        switch self {
        case .getLangs:
            return "/getLangs"
        case .detect:
            return "/detect"
        case .translate:
            return "/translate"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String: Any]? {
        switch self {
        case YandexServerAPI.getLangs(let value):
            return ["ui" : value]
        case YandexServerAPI.detect(_, let value):
            return ["hint" : value.joined(separator: ",")]
        case YandexServerAPI.translate(_, let value):
            return ["lang" : value]
        }
    }
    
    var task: Task {
        switch self {
        case .getLangs:
            return .requestParameters(parameters: ["key" : NetworkManager.YandexAPIKey], encoding: URLEncoding.default)
        case .detect(let text, _), .translate(let text, _):
            return .requestParameters(parameters: ["key" : NetworkManager.YandexAPIKey, "text" : text], encoding: URLEncoding.default)
        }
    }
    //use for unit tests - unit tests in progress
    var sampleData: Data {
        return Data()
    }
}

protocol Networkable {
    var provider: MoyaProvider<YandexServerAPI> { get }
    func getLangList(langCode ui: Language, completion: @escaping ([String: String]) -> Void)
    func detectLang(text: String, possibleLangsList hint: [String], completion: @escaping (DetectedLang) -> Void)
    func translateText(text: String, to lang: Language, completion: @escaping (TranslatedText) -> Void)
}

struct NetworkManager: Networkable {
    static let errorMap: [Int : String] = [
        401 : "Invalid API key",
        402 : "API key is locked",
        404 : "Daily limit on translated text exceeded",
        413 : "Maximum text size exceeded",
        422 : "Text cannot be translated",
        501 : "Specified translation direction is not supported"
    ]
    static let YandexAPIKey = "trnsl.1.1.20190202T191857Z.5ad2a1996820660f.0c3cd412939e9a9883739d26088ae0af1abf76f9"
    
    var provider: MoyaProvider<YandexServerAPI> = MoyaProvider<YandexServerAPI>()
    
    func getLangList(langCode ui: Language, completion: @escaping ([String : String]) -> Void) {
        provider.request(.getLangs(ui: ui.rawValue)) { result in
            switch result {
                case .success(let response):
                    if let json = try? response.mapJSON(),
                        let possibleLangs = json as? [String: String] {
                        completion(possibleLangs)
                    }
                    break;
            case .failure(let error):
                print("Response error: \(String(describing: error.errorDescription))")
                break;
            }
        }
    }
    
    func detectLang(text: String, possibleLangsList hint: [String], completion: @escaping (DetectedLang) -> Void) {
        provider.request(.detect(text: text, hint: hint)) { result in
            switch result {
            case .success(let response):
                if let detectedLang = try? response.map(DetectedLang.self) {
                    completion(detectedLang)
                }
                break;
            case .failure(let error):
                print("Response error: \(String(describing: error.errorDescription))")
                break;
            }
        }
    }
    
    func translateText(text: String, to lang: Language, completion: @escaping (TranslatedText) -> Void) {
        provider.request(.translate(text: text, lang: lang.rawValue)) { result in
            switch result {
            case .success(let response):
                if let translatedText = try? response.map(TranslatedText.self) {
                    completion(translatedText)
                }
                break;
            case .failure(let error):
                print("Response error: \(String(describing: error.errorDescription))")
                break;
            }
        }
    }
}
