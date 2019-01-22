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
                Immagine.loadImageUsingUrlString(urlString: url,callback: reloadSize)
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
    
    func reloadSize(){
//        let ratio = Immagine.image!.size.width / Immagine.image!.size.height
//        Immagine.addConstraint(NSLayoutConstraint(item: Immagine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.frame.size.width / ratio))
    }

        

}


/*extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                let ratio = image.size.width / image.size.height
                self.frame.size = CGSize(width: self.frame.size.width, height: self.frame.size.width / ratio)
                print("cose")
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}*/
