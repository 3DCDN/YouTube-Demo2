//
//  ViewController.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-12.
//

import UIKit

class ViewController: UIViewController, ModelDelegate  {

    
    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    var videos = [Video] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the delegate for the tableView as itself
        tableView.delegate = self
        tableView.dataSource = self
        // Set the delegate for the model as itself
        model.delegate = self
        // Do any additional setup after loading the view.
        model.getVideos()
        
    }
    func videosFetched(_ videos: [Video]) {
        // Set the returned videos to the videos property
        self.videos = videos
        // Refresh the tableview
        tableView.reloadData()
    }
    
    

}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.video_cell_id, for: indexPath)
        
        // Configure the cell with the data
        // Get the title for the video selected
        let title = self.videos[indexPath.row].title
        cell.textLabel?.text = title
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selection \(indexPath.row)")
    }
}
