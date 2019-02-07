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
    func refreshData(newViewInput text: String)
}

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

class TranslatorViewController: UIViewController, ITranslatorViperViewInput, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let cellReuseIdentifier = "MessageCell"
    
    var messageList: [Message] = [Message(input: "Test Input", output: "Test Output", isSending: true)]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MessageCell
        let message = messageList[indexPath.row]
        
        cell.inputText.text = message.input
        cell.outputText.text = message.output
        cell.isSending = !message.isSending
        
        return cell
    }
    
    private(set) var output: TranslatorViperViewOutput!
    
    @IBOutlet weak var translatorView: TranslatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    func config(with output: TranslatorViperViewOutput) {
        self.output = output
    }
    
    func refreshUI() {
        let newMessage = "Test Message For translate"
        output.refreshData(newViewInput: newMessage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

