//
//  WorkoutViewController.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 25/11/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  var videos:[Video] = []
    var video:Video = Video()
    



    override func viewDidLoad() {
        super.viewDidLoad()

        let video = Video()
        video.Key = "XzLojq_iKVk"
        video.Title = "10 Minute Abdominal Workout"
        videos.append(video)
        
        let video2 = Video()
        video2.Key = "rJV9xByEPho"
        video2.Title = "15 Min Abs 6 Pack Workout"
        videos.append(video2)
        
        let video3 = Video()
        video3.Key = "BQc8aH38qc8"
        video3.Title = "30 Minute Standing Cardio"
        videos.append(video3)
        
        
        
        let video5 = Video()
        video5.Key = "4o3iAH_ddBQ"
        video5.Title = "30 Minute Fat Burning HIIT Cardio Workout "
        videos.append(video5)
        
        let video6 = Video()
        video6.Key = "0y6fWeF6Gbo"
        video6.Title = "Cardio Home Workout without Equipment"
        videos.append(video6)
        
        let video7 = Video()
        video7.Key = "pvIjsG5Svck"
        video7.Title = "Plank Exercice"
        videos.append(video7)
        
        let video8 = Video()
        video8.Key = "UBnfm4s7CRA"
        video8.Title = "Abs Workout"
        videos.append(video8)
    }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return videos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellVideoViewCell
            
            cell.VideoTitle.text = videos[indexPath.row].Title
            let url = "https://img.youtube.com/vi/\(videos[indexPath.row].Key)/0.jpg"
            cell.VideoImage.downloaded(from: url)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let vi = videos[indexPath.row]
            self.video = vi
            
            
          performSegue(withIdentifier: "toVideo", sender: nil)
        }
        
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toVideo" {

               let vc = segue.destination as! VideoViewController
              vc.video = self.video

          }
       }
        
    }

    class Video{
        var Key:String = ""
        var Title:String = ""
    }

    extension UIImageView {
        func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                }
                }.resume()
        }
        func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


