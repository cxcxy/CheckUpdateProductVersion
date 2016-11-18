//
//  ViewController.swift
//  CheckUpdate
//
//  Created by 陈旭 on 2016/11/4.
//  Copyright © 2016年 陈旭. All rights reserved.
//

import UIKit

public let Itunes_Url:String = "https://itunes.apple.com/cn/app/qq-2011/id444934666?mt=8"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        WOWCheckUpdate.checkUpdateWithDevice {[weak self] (isUpdate) in
            if let strongSelf = self{
            if isUpdate ?? false {
                
                strongSelf.goToUpdateVersion()
            }
        }
        }
    }
    func goToUpdateVersion()  {
        let alert = UIAlertController(title: "提示", message: "版本有更新", preferredStyle: .alert)
        let action_sure = UIAlertAction(title: "更新", style: .default) { (action) in
            let url = NSURL(string: Itunes_Url)
            UIApplication.shared.openURL(url! as URL)
            //                UIApplication.shared.open(url! as URL, options: nil, completionHandler: nil)
        }
        let action_cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action_sure)
        alert.addAction(action_cancel)
        
        present(alert, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


