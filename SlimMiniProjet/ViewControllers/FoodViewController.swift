//
//  FoodViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 25/11/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    let backgroundImageView = UIImageView()

    @IBOutlet weak var plan: UITextField!
    @IBOutlet weak var calories: UITextField!
    @IBOutlet weak var dietType: UITextField!
    @IBOutlet weak var vegan: UISwitch!
    @IBOutlet weak var vegetarian: UISwitch!
    @IBOutlet weak var glutenfree: UISwitch!
    @IBOutlet weak var dairyfree: UISwitch!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var Next: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.bg(colorone: .blue, colorTwo: .red)
        
    setBackground()
    }
    
    
    @IBAction func ResetButton(_ sender: Any) {
        
        
        plan.text = ""
        calories.text = ""
        vegan.isOn = false
        vegetarian.isOn = false
        glutenfree.isOn = false
        dairyfree.isOn = false
        
        
        
    }
    @IBAction func NextButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "toDiet") {
         let controller = segue.destination as! DietViewController
//         controller.dietFocus = dietFocusGroups[DietFocusPicker.selectedRow(inComponent: 0)]
//         controller.dietName = plan.text ?? ""
//         controller.calorieGoal = calories.text ?? ""
//         controller.isVegetarian = vegetarian.isOn
//         controller.isVegan = vegan.isOn
//         controller.isGlutenFree = glutenfree.isOn
//         controller.isDairyFree = dairyfree.isOn
        }}

    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "vg")
        view.sendSubviewToBack(backgroundImageView)
    }

}
