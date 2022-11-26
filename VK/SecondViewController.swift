//
//  SecondViewController.swift
//  VK
//
//  Created by Semen Vinnikov on 22.06.2022.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    @IBAction func SecondViewNextButton(_ sender: Any) {
        
        performSegue(withIdentifier: "SecondNext", sender: nil)
    }
    

}
