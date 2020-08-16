//
//  VideoViewController.swift
//  SlimMiniProjet
//
//  Created by Yafet Shil on 13/12/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import WebKit


class VideoViewController: UIViewController {
    var video:Video = Video()

    
    @IBOutlet weak var videoviewer: WKWebView!
    @IBOutlet weak var VideoTitre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      VideoTitre.text = video.Title
        getVideo(videoKey: video.Key)
        
        // Do any additional setup after loading the view.
    }
    
    func getVideo(videoKey:String) {
        
        let url = URL(string: "https://www.youtube.com/embed/\(videoKey)")
//        let url = URL(string: "https://www.youtube.com/watch?v=T0mhPjbfSc8")
        videoviewer.load(URLRequest(url: url!))
        
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
