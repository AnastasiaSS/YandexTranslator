//
//  TranslatorViperPresenter.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 30.01.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import Foundation

class TranslatorViperPresenter: TranslatorViperViewOutput, ITranslatorViperInteractorOutput {
    func didLoadData() {
        //code
    }
    
    func didFailLoadData(with error: Error) {
        //code
    }
    
    weak var view: ITranslatorViperViewInput?
    let interactor: ITranslatorViperInteractorInput
    let router: ITranslatorViperRouterBehavior
    
    init(with interactor: ITranslatorViperInteractorInput, router: ITranslatorViperRouterBehavior) {
        self.interactor = interactor
        self.router = router
        
        interactor.configure(with: self)
    }
    
    func refreshData() {
        //
    }
    
    func viewIsReady() {
        //
    }
    
    func configure(with view: ITranslatorViperViewInput) {
        self.view = view
        view.config(with: self)
    }
}
