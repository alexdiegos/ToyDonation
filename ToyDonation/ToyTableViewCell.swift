//
//  ToyTableViewCell.swift
//  ToyDonation
//
//  Created by Alexandre Silva on 26/07/22.
//  Copyright © 2022 AlexDiegoS. All rights reserved.
//

import UIKit

class ToyTableViewCell: UITableViewCell {
    @IBOutlet weak var toyName: UILabel!
    @IBOutlet weak var toyState: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureWith(_ toy: ToyItem){
        toyName.text = toy.name
        toyState.text = toy.stateText
    }
}
