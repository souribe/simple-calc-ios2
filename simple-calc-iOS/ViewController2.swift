//
//  ViewController2.swift
//  simple-calc-iOS
//
//  Created by Benny on 1/31/18.
//  Copyright © 2018 Benny Souriyadeth. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var wordBank:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if wordBank.count > 0 {
            for index in 0...wordBank.count - 1 {
                let label = UILabel(frame: CGRect(x: 50, y: index * 25 + 50, width: 300, height: 40))
                label.text = wordBank[index]
                view.addSubview(label)
                scrollView.addSubview(label)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 266, height: 1000)
        scrollView.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view
        //        scrollView.contentSize = CGSizeMake(400, 2300)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let talkView = segue.destination as! ViewController
        talkView.wordBank = wordBank
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
