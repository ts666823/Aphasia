//
//  ViewController.swift
//  Aphasia
//
//  Created by 唐烁 on 2021/8/24.
//

import UIKit
import AVFoundation
import MediaPlayer

class Word{
    var str:String?
    var colorIndex:Int?
}

let labelColor = [#colorLiteral(red: 0.431372549, green: 0.4156862745, blue: 0.8745098039, alpha: 1),
                  #colorLiteral(red: 0.9803921569, green: 0.6196078431, blue: 0.4196078431, alpha: 1),
                  #colorLiteral(red: 0.8470588235, green: 0.4117647059, blue: 1, alpha: 1),
                  #colorLiteral(red: 0.4588235294, green: 0.7803921569, blue: 0.7137254902, alpha: 1),
                  #colorLiteral(red: 0.5019607843, green: 0.7411764706, blue: 0.9764705882, alpha: 1)]

let backgroudColor = [#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9764705882, alpha: 1),
                      #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9411764706, alpha: 1),
                      #colorLiteral(red: 0.9921568627, green: 0.9764705882, blue: 1, alpha: 1),
                      #colorLiteral(red: 0.9647058824, green: 1, blue: 0.9921568627, alpha: 1),
                      #colorLiteral(red: 0.9647058824, green: 0.9843137255, blue: 1, alpha: 1)]

class ViewController: UIViewController,PopOverDelegate, AVSpeechSynthesizerDelegate {
    func addWord(words: [String], colorIndex: Int) {
        for word in words {
            choosedData.append(word)
            choosedColor.append(colorIndex)
        }
        len4Choosed += words.count
        wordCollectionView.reloadData()
    }
    
    //视图控件
    @IBOutlet var selectView: UIView!
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var chooseCollectionView: UICollectionView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var btnSelected: UIView!
    // 按钮控件
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    
    @IBOutlet weak var chooseShadowBtn: UIButton!
    @IBOutlet weak var toneBtn: UIButton!
    @IBOutlet weak var decoretionBtn: UIButton!
    @IBOutlet weak var relationBtn: UIButton!
    @IBOutlet weak var sportBtn: UIButton!
    @IBOutlet var wordCollectionView: UICollectionView!
    //chooseCollectionView数据
    let chooseData = ["人物与指代","地点","服饰","饮食","医疗健康","身体部位","生活用品","家居","动植物","交通工具","时间词","天气"]
    var choosedData = ["我"]
    var choosedColor = [0]
    
    let chooseDataRows = [["人称代词","数量指代","人际关系","职业"],["所处指代","室内","户外"],["服装","鞋与配饰"],
                          ["生活用品","电子产品"],["病症","药品","医疗器材与手段"],["身体部位"],["家具","家用电器"],
                          ["主食与糕点","饮品","蔬果","荤肉","水产"],["动物","植物"],["交通工具"],["时间"],["天气"],
                          ["动作","想法与能力","活动"],["数目","颜色","状态","范围","程度","度量"],["连接词","语气与情形","时间与频率","介词"],["语气词"]]
    let btnTitle = ["人物与指代","地点","服饰","饮食","医疗健康","身体部位","生活用品","家居","动植物","交通工具","时间","天气","活动","修饰","关联性","语气词"]
    let images=[[["你","你们","他","他们","它","她","她们","我","我们"],
                 ["那个","那些","全部","这个","这些"],
                 ["儿子","父亲","姑父","姑姑","家人","姐妹","舅舅","舅妈","老人","邻居","母亲","奶奶","男孩"
                  ,"男人","年轻人","女儿","女孩","女人","朋友","妻子","婶婶","同学","外公","外婆","外甥","外甥女"
                  ,"维修工","小孩","兄弟","学生","爷爷","姨父","姨妈","丈夫","侄儿","侄女"],
                 ["保姆","服务员","护工","护士","快递员","老师","理疗师","清洁工","社工","售货员","司机","外卖员","维修工","医生"]
                ],
                [["那边","那儿","那里","这边","这儿","这里","这边","这儿","这里"],
                 ["厨房","窗边","电梯","家","客厅","楼梯","门口","卫生间","卧室","阳台","浴室"],
                 ["菜市场","公园","广场","护理中心","郊外","街","路","商店","书店","停车场","学校","药店","医院","银行"]
                ],
                [["背心","衬衣","大衣","短裤","毛衣","内衣","秋衣","裙子","睡衣","外套","卫衣","袖子","长裤","T恤"],
                 ["背包","发箍","发卡","口袋","口罩","凉鞋","领带","帽子","墨镜","皮鞋","手套","头绳","拖鞋","袜子"
                  ,"围巾","鞋带","胸罩","袖子","靴子","眼镜","运动鞋"]
                ],
                [["杯子","被子","笔","笔记本","餐巾","叉子","茶壶","床单","刀子","肥皂","花瓶","口红","筷子","脸盆"
                  ,"毛巾","毛毯","沐浴露","钱","平底锅","勺子","手写板","碗","洗发露","洗脚盆","洗面奶","牙膏","牙刷",
                  "枕头","纸","纸巾","煮锅"],
                 ["笔记本电脑","充电器","电脑","耳机","平板电脑","手机","剃须刀","电影","密码","遥控器","音乐"]
                ],
                [["发烧","感冒","咳嗽","肌张力高","喷嚏","瘙痒","头痛","头晕","胃痛","淤青","生病"],
                 ["胶囊","开塞露","药","药膏","药片","中药"],
                 ["按摩","矫正板","康复训练","口罩","轮椅","血糖仪","血压仪"]
                ],
                [["背","鼻子","脖子","大腿","耳朵","腹部","胳膊","肩膀","脚","脚跟","脚踝","脸","屁股","手","手腕"
                  ,"手指","手肘","头","头发","腿","膝盖","下巴","小腿","胸","牙齿","眼睛","腰","指甲","嘴巴","身体"]
                ],
                [["茶几","抽屉","窗户","床","地板","地毯","灯","柜子","镜子","马桶","门","墙壁","沙发","书架"
                  ,"洗手池","椅子","浴缸","桌子"],
                 ["冰箱","吹风机","电视机","风扇","空调","微波炉","洗衣机"]
                ],
                [["包子","饼","饼干","蛋糕","饺子","馒头","米饭","面包","面条","巧克力","糖果","通心粉","香肠","菜单","食物"],
                 ["茶","果汁","酒","咖啡","可乐","牛奶","汽水","水","酸奶"],
                 ["白菜","白萝卜","菠菜","菠萝","橙子","豆角","番茄","胡萝卜","黄瓜","火龙果","茄子","梨","芒果","蘑菇",
                  "南瓜","柠檬","牛油果","苹果","葡萄","青菜","青椒","生姜","土豆","西瓜","西兰花","香菜","香蕉",
                  "洋葱","樱桃","玉米"],
                 ["蛋黄","鸡蛋","鸡肉","牛肉","香肠","鸭肉","羊肉","猪肉"],
                 ["螃蟹","扇贝","虾","鱼肉"]
                ],
                [["苍蝇","虫","狗","老鼠","蚂蚁","猫","鸟","蚊子","鱼","蟑螂"],
                 ["草","花","树","树干","树林","树枝","叶子"]
                ],
                [["车","出租车","飞机","公共汽车","火车","火车","救护车","轮椅","自行车"]
                ],
                [["春季","冬季","分钟","季节","秒钟","年","秋季","上午","晚上","下午","夏季","小时","星期","月","中午","时间"]
                ],
                [["风","雷电","晴天","台风","太阳","天空","雾","星星","雪","阴天","雨","雨天","月亮","云"]
                ],
                [["按","抱","擦","插","尝","唱","吃","吹","打","低头","蹲下","发现","感觉","给","关","喝","呼吸",
                  "画","捡","剪","进","嚼","开","看","哭","来","买","拿","挠","跑","敲","去","扔","睡觉","说",
                  "撕","躺下","踢","跳","听","吐","推","吞","闻","问","吸","洗","笑","写","摇","咬","站","抓",
                  "转身","走","clap","帮","切","选"],
                 ["不是","不喜欢","没有","是","喜欢","想","用","有","抱歉","同意","谢谢","知道"],
                 ["乘车","吃饭","吃药","出门","穿鞋","穿衣服","打电话","等待","锻炼","工作","喝水","回家","看电视",
                  "看书","理发","起床","去医院","上厕所","上楼","视频","刷牙","睡觉","说话","脱鞋","脱衣服","玩手机",
                  "午睡","洗脸","洗头","洗澡","下楼","休息","学习","打针","挂号","检查","拍照"]
                ],
                [["零","一","二","三","四","五","六","七","八","九","十","许多","一些","全部","多","少","多少","再"],
                 ["白色","彩色","橙色","粉色","黑色","红色","黄色","灰色","金色","蓝色","绿色","透明","银色","紫色",
                 "棕色"],
                 ["好","坏","冷","暖","热","冰","温","一般","快","慢","累","困","饿","舒服","难受","疼","长",
                  "短","中等","大","小","贵","伤心","生气"],
                 ["只有","一起","都"],
                 ["很","最","太","更","比较","相当","一下","特别","别的"],
                 ["张","座","个","条","顶","棵","只","条","辆","本","件","首","两","斤","公斤","米","寸","勺","盘"
                  ,"碗","桶","盆","杯","瓶","箱","袋","篮","年","月","日","点","周","天","分","秒","岁","粒","幢"
                  ,"堆","条","根","片","面","块"]
                ],
                [["和","虽然","尽管","即使","再说","无论","都","只有","只要","甚至","而且","就","于是","却","但是","不过"
                  ,"不然","原来","为了","因为","所以","因此","除了","包括","或者","不是","就是","如果","要是","像","比",
                  "似乎","不如"],
                 ["一定","却","就","难道","幸亏","反正","也许","大约","好像","几乎","还是"],
                 ["刚","将要","总是","已经","正在","马上","一直","忽然","有时"],
                 ["从","向","以","对","被","让","把"]
                ],
                [["呢","吧","啊","吗"]
                ]
                
    ]
    
    var chooseRow:Int = 0
    var len4Choosed:Int = 0{
        didSet{
            setBtnOutlet(able: (len4Choosed != 0))
        }
    }
    
    let synth = AVSpeechSynthesizer() //TTS对象
    let audioSession = AVAudioSession.sharedInstance() //语音引擎
    
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
        //collectionView数据与初始化
        chooseCollectionView.dataSource = self
        chooseCollectionView.delegate = self
        wordCollectionView.dataSource = self
        wordCollectionView.delegate = self
        //设置边框属性
        setBorder()
        synth.delegate = self
        len4Choosed = choosedData.count
        clearBtn.setBackgroundImage(UIImage(named: "clear-disabled"), for: .disabled)
        playBtn.setBackgroundImage(UIImage(named: "play-disabled"), for: .disabled)
        deleteBtn.setBackgroundImage(UIImage(named: "return-disabled"), for: .disabled)
        // popoverPresentationController?.popoverLayoutMargins = .init(top: 0, left: 100, bottom: 100, right: 100)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toPopOver"{
             let controller = segue.destination as! PopOverViewController
             controller.titleText = chooseData[chooseRow]
             var data:[PopOverViewData] = []
             for i in 0..<chooseDataRows[chooseRow].count
             {
                 data.append(PopOverViewData(title: chooseDataRows[chooseRow][i], images: images[chooseRow][i]))
             }
             controller.datas = data
             controller.delegate = self
             controller.colorIndex = colorIndex(wordClass: chooseRow)
         }
        if segue.identifier == "btnToPop"{
            let controller = segue.destination as! PopOverViewController
            controller.titleText = btnTitle[chooseRow]
            var data:[PopOverViewData] = []
            for i in 0..<chooseDataRows[chooseRow].count
            {
                data.append(PopOverViewData(title: chooseDataRows[chooseRow][i], images: images[chooseRow][i]))
            }
            controller.datas = data
            controller.delegate = self
            controller.colorIndex = colorIndex(wordClass: chooseRow)
        }
    }
    
    func colorIndex(wordClass:Int) -> Int{
        if(wordClass<=11){
            return 0
        }
        else if(wordClass == 12){
            return 1
        }
        else if(wordClass >= 13){
            return 2
        }
        return 0
    }
    
    // 设置失效与否
    func setBtnOutlet(able:Bool){
        clearBtn.isEnabled = able
        playBtn.isEnabled = able
        deleteBtn.isEnabled = able
    }
    
    func speechMessage(message:String){
        if !message.isEmpty {
            do {
                // 设置语音环境，保证能朗读出声音（特别是刚做过语音识别，这句话必加，不然没声音）
                try audioSession.setCategory(AVAudioSession.Category.ambient)
            }catch let error as NSError{
                print(error.code)
            }
            //需要转的文本
            let utterance = AVSpeechUtterance.init(string: message)
            //设置语言，这里是中文
            utterance.voice = AVSpeechSynthesisVoice.init(language: "zh_CN")
            //设置声音大小
            utterance.volume = 1
            //设置音频
            utterance.pitchMultiplier = 1.1
            //开始朗读
            synth.speak(utterance)
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
}


///- Button
extension ViewController{
    @IBAction func leftBtn(_ sender: Any) {
        chooseCollectionView.scrollToItem(at: IndexPath(row: chooseCollectionView.indexPathsForVisibleItems.startIndex - 3 < 0 ? 0 :chooseCollectionView.indexPathsForVisibleItems.startIndex - 3 , section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func rightBtn(_ sender: Any) {
        chooseCollectionView.scrollToItem(at: IndexPath(row: chooseCollectionView.indexPathsForVisibleItems.endIndex + 3 > chooseData.count - 1 ? chooseData.count - 1:chooseCollectionView.indexPathsForVisibleItems.endIndex + 3 , section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func sportTap(_ sender: Any) {
        chooseRow = 12
        btnSelected.center = sportBtn.center
        performSegue(withIdentifier: "btnToPop", sender: self)
    }
    @IBAction func relationTap(_ sender: Any) {
        chooseRow = 14
        btnSelected.center = relationBtn.center
        performSegue(withIdentifier: "btnToPop", sender: self)
    }
    @IBAction func decorationTap(_ sender: Any) {
        chooseRow = 13
        btnSelected.center = decoretionBtn.center
        performSegue(withIdentifier: "btnToPop", sender: self)
    }
    @IBAction func toneTap(_ sender: Any) {
        chooseRow = 15
        btnSelected.center = toneBtn.center
        performSegue(withIdentifier: "btnToPop", sender: self)
    }
    @IBAction func playBtn(_ sender: Any) {
        let message = choosedData.joined(separator: "")
        speechMessage(message: message)
    }
    @IBAction func deleteBtn(_ sender: Any) {
        choosedData.removeLast()
        choosedColor.removeLast()
        len4Choosed -= 1;
        wordCollectionView.reloadData()
    }
    @IBAction func clearBtn(_ sender: Any) {
        choosedData.removeAll()
        choosedColor.removeAll()
        len4Choosed = 0;
        wordCollectionView.reloadData()
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
        if collectionView == wordCollectionView{
            
        }
        else{
            let cell = collectionView.cellForItem(at: indexPath)
            chooseRow = indexPath.row
            center = cell!.center
            center.x = center.x - collectionView.contentOffset.x
            print(center)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wordCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as? WordCollectionViewCell else {
                fatalError()
            }
            cell.imageView.image = UIImage(named: choosedData[indexPath.row])
            cell.label.text=choosedData[indexPath.row]
            cell.label.backgroundColor = labelColor[choosedColor[indexPath.row]]
            cell.backgroundColor = backgroudColor[choosedColor[indexPath.row]]
            
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

