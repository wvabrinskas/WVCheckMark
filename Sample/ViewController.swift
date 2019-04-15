//
//  ViewController.swift
//  Sample
//
//  Created by Alex Bartis on 15/04/2019.
//  Copyright © 2019 William Vabrinskas. All rights reserved.
//

import UIKit
import WVCheckMark

class ViewController: UIViewController {

    @IBOutlet weak private var checkView: WVCheckMark!
    @IBOutlet weak private var checkLabel: UILabel!
    
    @IBOutlet weak private var checkXView: WVCheckMark!
    @IBOutlet weak private var checkXLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkLabel.text = "Loading"
        checkXLabel.text = "Loading"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkView.start { () in
            self.checkLabel.text = "Done 🤙"
        }
        
        checkXView.startX { () in
            self.checkXLabel.text = "No 😎"
        }
    }

}

