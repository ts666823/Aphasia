//
//  ViewController.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/8/24.
//

import UIKit

class ViewController: UIViewController {
    
    //视图控件
    @IBOutlet var selectView: UIView!
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var chooseCollectionView: UICollectionView!
    @IBOutlet weak var resultView: UIView!
    

    @IBOutlet weak var chooseShadowBtn: UIButton!
    @IBOutlet weak var toneBtn: UIButton!
    @IBOutlet weak var decoretionBtn: UIButton!
    @IBOutlet weak var relationBtn: UIButton!
    @IBOutlet weak var sportBtn: UIButton!
    @IBOutlet var wordCollectionView: UICollectionView!
    //chooseCollectionView数据
    let chooseData = ["人物与指代","地点","服饰","饮食","医疗健康","身体部位","生活用品","家居","动植物","交通工具","时间","天气"]
    
    let choosedData = ["i", "park", "think", "go", "walk"]
    
    var chooseRow:Int = 0
    
    var center: CGPoint = CGPoint(x: 10,y: 10){
        didSet{
            selectView.center = center
            print("center has changed:"+center.debugDescription)
            print("selectView center is"+selectView.center.debugDescription)
            performSegue(withIdentifier: "toPopOver", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //collectionView数据与初始化
        chooseCollectionView.dataSource = self
        chooseCollectionView.delegate = self
        wordCollectionView.dataSource = self
        wordCollectionView.delegate = self
        
        //设置边框属性
        setBorder()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toPopOver"{
            let controller = segue.destination as! PopOverViewController
            controller.titleText = chooseData[chooseRow]
         }
    }

    func setBorder(){
        //设置背景圆角
        backGroundView.layer.cornerRadius = backGroundView.frame.height/32
        backGroundView.layer.masksToBounds = true
        //设置tipLabel边框 左上方Label
        tipLabel.layer.cornerRadius = tipLabel.frame.height/4
        tipLabel.layer.masksToBounds = true
        tipLabel.layer.maskedCorners = CACornerMask(rawValue: CACornerMask.layerMaxXMinYCorner.rawValue | CACornerMask.layerMinXMinYCorner.rawValue | CACornerMask.layerMaxXMaxYCorner.rawValue)
        //设置选词边框圆角
        chooseCollectionView.layer.cornerRadius = chooseCollectionView.frame.height/8
        chooseCollectionView.layer.masksToBounds = true
        //选择结果框紫色边框
        resultView.layer.borderWidth = 3
        resultView.layer.borderColor = #colorLiteral(red: 0.431372549, green: 0.4156862745, blue: 0.8745098039, alpha: 0.8980392157)
        //选择结果框圆角
        resultView.layer.cornerRadius = resultView.frame.height/8
        resultView.layer.masksToBounds = true
        //设置word边框圆角及阴影
        wordCollectionView.layer.cornerRadius = wordCollectionView.frame.height/16
        //设置按钮的阴影
        sportBtn.addShadow(color: .gray, offset: CGSize.zero, opacity: 0.2)
        decoretionBtn.addShadow(color: .gray, offset: CGSize.zero, opacity: 0.2)
        relationBtn.addShadow(color: .gray, offset: CGSize.zero, opacity: 0.2)
        toneBtn.addShadow(color: .gray, offset: CGSize.zero, opacity: 0.2)
        chooseShadowBtn.addShadow(color: .gray, offset: CGSize.zero, opacity: 0.2)
    }
    
    @IBAction func leftBtn(_ sender: Any) {
        chooseCollectionView.scrollToItem(at: IndexPath(row: chooseCollectionView.indexPathsForVisibleItems.startIndex - 3 < 0 ? 0 :chooseCollectionView.indexPathsForVisibleItems.startIndex - 3 , section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func rightBtn(_ sender: Any) {
        chooseCollectionView.scrollToItem(at: IndexPath(row: chooseCollectionView.indexPathsForVisibleItems.endIndex + 3 > chooseData.count - 1 ? chooseData.count - 1:chooseCollectionView.indexPathsForVisibleItems.endIndex + 3 , section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wordCollectionView{
            return choosedData.count
        }
        else{
            return chooseData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        chooseRow = indexPath.row
        
        center = cell!.center
        
        print(center)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wordCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as? WordCollectionViewCell else {
                fatalError()
            }
            cell.imageView.frame.size = cell.frame.size
            cell.imageView.image = UIImage(named: choosedData[indexPath.row])
            
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooseCell", for: indexPath) as? ChooseCollectionViewCell else {
                fatalError()
            }
            cell.imageView.frame.size = cell.frame.size
            cell.imageView.image = UIImage(named: chooseData[indexPath.row])
            
            return cell
        }
        
    }
}

