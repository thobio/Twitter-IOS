//
//  ConversationsController.swift
//  Twitter IOS
//
//  Created by Coding Crackers on 08/05/20.
//  Copyright © 2020 Coding Crackers. All rights reserved.
//

import UIKit

class ConversationsController: UIViewController {
    
    //MARK:- Properties
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}
