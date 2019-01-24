//
//  CellNewsTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

class CellNews: UITableViewCell {

    @IBOutlet weak var Immagine: CustomImageView!
    @IBOutlet weak var TipoSport: UILabel!
    @IBOutlet weak var Anteprima: UITextView!
    @IBOutlet weak var Conteiner: UIView!
    
    
    var urlImmagine: String? {
        didSet{
            if let url = urlImmagine{
                Immagine.loadImageUsingUrlString(urlString: url)
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonInit(){
        backgroundColor = UIColor.clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        Conteiner.backgroundColor = UIColor.white
        Conteiner.layer.cornerRadius = 3
    }


        

}
