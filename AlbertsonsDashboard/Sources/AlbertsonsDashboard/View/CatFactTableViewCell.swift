//
//  CatFactTableViewCell.swift
//  
//
//  Created by Durgesh Lal on 1/26/23.
//

import Foundation
import UIKit

class CatFactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catFactLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catFactLabel.text = nil
    }
}

extension CatFactTableViewCell {
    func updateCatFact(_ text: String?) {
        self.catFactLabel.text = text
    }
}
