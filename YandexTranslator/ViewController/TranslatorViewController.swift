//
//  ViewController.swift
//  YandexTranslator
//
//  Created by Анастасия Соколан on 23.01.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

protocol ITranslatorViperViewInput: class {
    
    func config(with output: TranslatorViperViewOutput)
    func refreshUI()
    
}

protocol TranslatorViperViewOutput: class {
    
    //var elements: [IRepositoryCellViewModel] { get }
    
    func refreshData()
    func viewIsReady()
    
}

class TranslatorViewController: UIViewController, ITranslatorViperViewInput {
    
    private(set) var output: TranslatorViperViewOutput!
    
    @IBOutlet weak var translatorView: TranslatorView!
    
    func config(with output: TranslatorViperViewOutput) {
        self.output = output
    }
    
    func refreshUI() {
        //code here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

