//
//  EventsCell.swift
//  AssesmentApp
//
//  Created by Irfan Saeed on 26/10/2022.
//

import UIKit

class EventsCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
    func populateData(objData: Events) {
        if let name = objData.artiste {
            lblArtist.text = name
        }
        
        if let city = objData.city {
            lblCity.text = city
        }
        
        if let price = objData.price {
            lblPrice.text = price.description
        }
    }
}
