//
//  HomeViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 23/11/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
class HomeViewController: UIViewController {
     let backgroundImageView = UIImageView()
    
    @IBOutlet weak var prenom: UILabel!
    let defaults = UserDefaults.standard

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Home", image:UIImage(named: "hoome"), tag: 1)
    }
    

    @IBAction func back(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  prenom.text = defaults.object(forKey: "user_name") as? String
        //view.bg(colorone: .blue, colorTwo: .red)
        // Do any additional setup after loading the view.
        setBackground()
    }
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "b")
        view.sendSubviewToBack(backgroundImageView)
    }

}
