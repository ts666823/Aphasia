//
//  PopOverBtnViewController.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/9/2.
//

import UIKit

class PopOverBtnViewController: UIViewController,CollectionDelegate{
    
    func addSelect(word: String) {
        choosedData.append(word)
    }
    
    func deleteSelect(word: String){
        if let index = choosedData.firstIndex(of: word){
            choosedData.remove(at: index)
        }
    }
    
    weak var delegate:PopOverDelegate!
    

    var datas = [
        PopOverViewData(title: "指代", images: ["me","me","me","me","me","me","me","me","me","me","me","me","me","me","me"]),
        PopOverViewData(title: "人际关系", images: ["/1/101/你","me","me","me","me","me","me","me","me","me","me","me","me","me","me"])
    ]
    
    var choosedData:[String] = []
    
    var colorIndex = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
        
    var titleText:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        titleLabel.text = processTitle(title: titleText)
        // popoverPresentationController?.popoverLayoutMargins = .init(top: 0, left: 100, bottom: 200, right: 100)
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate.setBtnState()
    }
    func processTitle(title:String) -> String{
        let subStr = title.suffix(3)
        if subStr == "Btn"{
            return String(title.prefix(2))
        }
        return title
    }
    @IBAction func tapCancelBtn(_ sender: Any) {
        choosedData.removeAll()
        self.dismiss(animated: true)
    }
    @IBAction func tapConfirmBtn(_ sender: Any) {
        delegate.addWord(words: choosedData, colorIndex: colorIndex)
        self.dismiss(animated: true)
    }
}

extension PopOverBtnViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopOverTableViewCell", for: indexPath) as? PopOverTableViewCell else {
            fatalError()
        }
        cell.collectionView.frame.size.height = CGFloat(161*(datas[indexPath.row].images.count/8 + 1)+80)
        cell.reloadData(title: datas[indexPath.row].title, images: datas[indexPath.row].images,delegate: self,colorIndex: colorIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(161*(datas[indexPath.row].images.count/8 + 1)+80)
    }
}



