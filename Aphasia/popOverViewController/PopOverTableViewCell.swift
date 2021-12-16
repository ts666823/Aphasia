//
//  PopOverTableViewCell.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/9/1.
//

import UIKit

protocol PopOverDelegate:NSObjectProtocol {
    func addWord(words:[String],colorIndex:Int)
}

protocol CollectionDelegate:NSObjectProtocol {
    func addSelect(word:String)
}


class PopOverTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    weak var collectionDelegate:CollectionDelegate?
    
    var colorIndex:Int = 0
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popOverCollectionCell", for: indexPath) as? PopOverCollectionViewCell else {
            fatalError()
        }
        cell.imageView.image = UIImage(named: images[indexPath.item])
        cell.label.text=images[indexPath.item]
        cell.label.backgroundColor = labelColor[colorIndex]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        collectionDelegate?.addSelect(word: images[indexPath.item])
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(title:String, images:[String],delegate:CollectionDelegate,colorIndex:Int){
        self.label.text = title
        self.images = images
        self.collectionView.reloadData()
        self.collectionDelegate = delegate
        self.colorIndex = colorIndex
    }

}
