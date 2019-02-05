//
//  TranslatorViperInteractor.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 30.01.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import Foundation

protocol ITranslatorViperInteractorInput: class {
    
    func configure(with output: ITranslatorViperInteractorOutput)
    func startDataLoading()
    
}

protocol ITranslatorViperInteractorOutput: class {
    
    func didLoadData()
    func didFailLoadData(with error: Error)
    
}

class TranslatorViperInteractor: ITranslatorViperInteractorInput {
    func startDataLoading() {
        //code
    }
    
    weak var output: ITranslatorViperInteractorOutput?
    private let translateService: Networkable
    
    init(with translate: Networkable) {
        self.translateService = translate
    }
    
    func configure(with output: ITranslatorViperInteractorOutput) {
        self.output = output
    }
}
