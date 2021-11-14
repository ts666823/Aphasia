//
//  PopOverViewController.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/9/1.
//

import UIKit

struct PopOverViewData{
    var title:String
    var images:[String]
}

class PopOverViewController: UIViewController {

    let datas = [
        PopOverViewData(title: "指代", images: ["me","me","me","me","me","me","me","me","me","me","me","me","me","me","me"]),
        PopOverViewData(title: "人际关系", images: ["me","me","me","me","me","me","me","me","me","me","me","me","me","me","me"])
    ]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var titleText:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        titleLabel.text = titleText
        // Do any additional setup after loading the view.
    }
}

extension PopOverViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopOverTableViewCell", for: indexPath) as? PopOverTableViewCell else {
            fatalError()
        }
        
        cell.reloadData(title: datas[indexPath.row].title, images: datas[indexPath.row].images)
        
        
        return cell
    }
}


