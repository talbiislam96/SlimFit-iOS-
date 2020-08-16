//
//  meViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 05/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class meViewController: UIViewController {
     let backgroundImageView = UIImageView()
    var goal = 1000

    let healthManager = HealthManager()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Steps", image:UIImage(named: "steps"), tag: 2)
    }
    
    @IBOutlet weak var WelcomeDescription: UILabel!
    
    @IBOutlet weak var StepCounter: UILabel!
    
    @IBOutlet weak var Last24h: UILabel!
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = view.center
        //create track layer
        let trackLayer = CAShapeLayer ()
        let circularpath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularpath.cgPath
        trackLayer.strokeColor=UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        
        //let circularpath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularpath.cgPath
        shapeLayer.strokeColor=UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

      setBackground()
    }
    
    public func setProgress(){
    shapeLayer.strokeEnd = 0.5
        return
        var DailySteps = (StepCounter.text as! NSString).intValue
        let percentage = CGFloat(goal) / CGFloat(DailySteps)
        DispatchQueue.main.async {
            self.shapeLayer.strokeEnd = percentage
        }
        
        print(percentage)
        
    }

    @objc private func handleTap(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urBasic")
        setProgress()
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchInformation()
    }

    func fetchInformation() {
        if !healthManager.checkAuth() {
            StepCounter.text = "-"
            WelcomeDescription.text = "API Access Denied"
            Last24h.text = "Device not compatible."
        }
        else {
            WelcomeDescription.text = "You've covered"
            Last24h.text = "steps in the last 24 hours"
            healthManager.fetchStepCount() { steps, success in
                DispatchQueue.main.async {
                    if success {
                        self.StepCounter.text = String(Int(steps))
                    }
                }
            }
        }
    }

    func setBackgroundColor() {
        self.view.backgroundColor = UIColor.blue
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        let lightColor = UIColor.yellow.cgColor
        let darkColor = UIColor.red.cgColor
        gradient.colors = [lightColor, darkColor];
        gradient.locations = [0.25, 0.75]
        gradient.opacity = 0.4
        self.view.layer.addSublayer(gradient)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "stp")
        view.sendSubviewToBack(backgroundImageView)
    }

}
