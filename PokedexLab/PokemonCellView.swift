//
//  PokemonCellView.swift
//  PokedexLab
//
//  Created by David Mrdjenovich on 3/2/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class PokemonCellView: UITableViewCell {

    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonStats: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
