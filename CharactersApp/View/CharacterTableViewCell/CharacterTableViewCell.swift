//
//  CharacterTableViewCell.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 28/11/2024.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        setupBgViewUI()
        setupCharacterImageViewUI()
    }
    
    func setupBgViewUI() {
        bgView.layer.cornerRadius = 16
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        bgView.layer.masksToBounds = true
        bgView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    }
    
    func setupCharacterImageViewUI() {
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 5
    }

    func configure(with character: Character) {
        let placeholderImage = UIImage(named: "placeholder")
        characterImageView.kf.indicatorType = .activity
        characterImageView.kf.setImage(
            with: URL(string: character.image),
            placeholder: placeholderImage
        )
        nameLabel.text = (character.name) 
        speciesLabel.text = character.species
    }
}
