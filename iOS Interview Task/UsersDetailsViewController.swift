//
//  UsersDetailsViewController.swift
//  iOS Interview Task
//
//  Created by developer on 05/05/21.
//

import UIKit

class UsersDetailsViewController: UIViewController {
    var items = NSDictionary()
    
    @IBOutlet weak var userDetailImageView: UIImageView!
    
    @IBOutlet weak var userDetailNameLbl: UILabel!
    
    @IBOutlet weak var userDetailEmailLbl: UILabel!
    
    @IBOutlet weak var userDetailIdLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: items["avatar"] as! String)
         let data = try? Data(contentsOf: url!)
        userDetailImageView.image = UIImage(data: data!)
        userDetailImageView.layer.cornerRadius = self.userDetailImageView.frame.size.width / 2;
        userDetailImageView.clipsToBounds = true;
        userDetailNameLbl.text = "\(items["first_name"]!) \(items["last_name"]!)"
        userDetailEmailLbl.text = (items["email"] as? String)
        userDetailIdLbl.text = "\(items["id"]!)"
       
        // Do any additional setup after loading the view.
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
