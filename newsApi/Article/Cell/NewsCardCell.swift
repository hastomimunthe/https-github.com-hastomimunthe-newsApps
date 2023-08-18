//
//  NewsCardCell.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import UIKit
import Kingfisher

class NewsCardCell: UITableViewCell {
    
    @IBOutlet weak var newsImages: UIImageView!
    @IBOutlet weak var labelPublished: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        selectionStyle = .none
        newsImages.contentMode = .scaleAspectFill
        newsImages.layer.cornerRadius = 8
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(title: String?, publishedAt: String?, urlToImage: String?){
        labelPublished.text = publishedAt
        labelTitle.text = title
        if let url = URL(string: urlToImage ?? "") {
            newsImages.kf.setImage(with: url)
        }
        
        
    }
}
