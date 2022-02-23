//
//  WordPopOverViewController.swift
//  Aphasia
//
//  Created by 唐烁 on 2022/2/15.
//

import UIKit

class WordPopOverViewController: UIViewController {
    
    var word:String = ""
    var pos:Int = 0
    var colorIndex = 0

    weak var delegate:PopOverDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func tapCopyBtn(_ sender: Any) {
        delegate.insertWord(word: word, colorIndex: colorIndex, pos: pos + 1)
        print("word is " + word)
        print(colorIndex)
        print(pos)
        self.dismiss(animated: true)
    }
    
    @IBAction func tapDeleteBtn(_ sender: Any) {
        delegate.deleteWord(pos: pos)
        print(pos)
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
