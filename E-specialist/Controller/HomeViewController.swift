//
//  ViewController.swift
//  E-specialist
//
//  Created by YhamIVan on 2020/11/13.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var studyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studyButton.layer.cornerRadius = 25.0
    }
    
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }        
    
}

