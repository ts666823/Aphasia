//
//  SentenceViewController.swift
//  Aphasia
//
//  Created by 唐烁 on 2022/1/26.
//

import UIKit

class SentenceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sentenceCollectionViewCell", for: indexPath) as? SentenceCollectionViewCell else {
            fatalError()
        }
        cell.label.text = "测试"
        return cell
    }
    

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var titleText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.titleLabel.text = titleText
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapOk(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
