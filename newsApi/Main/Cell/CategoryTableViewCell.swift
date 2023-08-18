//
//  CategoryTableViewCell.swift
//  newsApi
//
//  Created by Hastomi Riduan Munthe on 18/08/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(text: String) {
        categoryLabel.text = text
    }
}
