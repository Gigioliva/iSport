//
//  CellNewsTableViewCell.swift
//  iSport
//
//  Created by Gianluigi Oliva on 13/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookShare

class CellNews: UITableViewCell {

    @IBOutlet weak var Immagine: CustomImageView!
    @IBOutlet weak var Anteprima: UITextView!
    @IBOutlet weak var Conteiner: UIView!
    @IBOutlet weak var SitoURL: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var Favorite: UIBarButtonItem!
    
    var delegate: UIViewController?
    var urlNotizia: String?
    var contenuto: Article?{
        
        didSet{
            Anteprima.text = contenuto!.title
            urlImmagine = contenuto!.urlToImage
            urlNotizia = contenuto!.url
            SitoURL.text = URL(string: urlNotizia!)!.host
        }
    }
    
    var urlImmagine: String? {
        didSet{
            if let url = urlImmagine{
                Immagine.loadImageUsingUrlString(urlString: url)
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        Conteiner.layer.cornerRadius = 3
        Anteprima.isUserInteractionEnabled = false
    }
    
    @IBAction func ShareButton(_ sender: Any) {
        if AccessToken.current != nil {
            let temp = URL(string: urlNotizia!)
            let content = LinkShareContent(url: temp!)
            do{
                try ShareDialog.show(from: delegate!, content: content)
            }catch let errore{
                print(errore)
            }
            
        }else {
            ApriAlert()
        }
        
    }
    
    func ApriAlert (){
        let alert = UIAlertController(title: "Not Logged In", message: "Please login to continue", preferredStyle: UIAlertController.Style.alert)
        let OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(OK)
        delegate!.present(alert, animated: true, completion: nil)
    }

    @IBAction func SaveFavorite(_ sender: Any) {
        if let view = delegate as? NewsDelegate {
            APICoreData.ModNews(notizia: contenuto!)
            view.reloadTable()
        }
    }
    
}


protocol NewsDelegate: AnyObject {
    func reloadTable()
}
