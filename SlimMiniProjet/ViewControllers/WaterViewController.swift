//
//  WaterViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 25/11/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import RealmSwift
class WaterViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bg(colorone: .blue, colorTwo: .red)
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func count(_ sender: UIStepper) {
stepperValue.text = Int(sender.value).description
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
