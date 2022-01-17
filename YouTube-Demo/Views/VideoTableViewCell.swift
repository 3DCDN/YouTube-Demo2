//
//  VideoTableViewCell.swift
//  YouTube-Demo
//
//  Created by Richard St. Onge on 2022-01-17.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    var video:Video?
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setVideoCell(vid: Video) {
        self.video = vid
        //Ensure that we have a video object
        guard self.video != nil else {
            return
        }
        
        // Set the title
        self.titleLabel.text = vid.title
        
        // create a dateformatter object and set the date label
        let dateformat = DateFormatter()
        dateformat.dateStyle = .long
        self.dateLabel.text = dateformat.string(from: video!.published)
        
        //set the thumbnail (Image)
        guard self.video!.thumbnail != "" else {
            return
        }
        // Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(url: self.video!.thumbnail) {
            // Set the thumbnail ImageView
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return // Don't want the rest of the code to run to re-download the image
        }
        
        // Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //Get the shared url session object
        let session = URLSession.shared
        
        // Create the data task for the url session
        let dataTask = session.dataTask(with: url!) { imageData, response, error in
            // Check that the downloaded url matches the video thumbnail that this cell is currently set to display
            if error == nil && imageData != nil {
                // Save the data into cache to prevent the need to download again
                CacheManager.setVideoCache(url: url!.absoluteString, data: imageData)
                if url?.absoluteString != self.video?.thumbnail {
                    // Video cell has been recycled for another video and no longer matches the video that was downloaded
                    return
                }
                // Create image object
                let image = UIImage(data: imageData!)
                
                // Update ImageView
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        } // Start the data task
        dataTask.resume()
    }

}
