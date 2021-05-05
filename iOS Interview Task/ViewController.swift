//
//  ViewController.swift
//  iOS Interview Task
//
//  Created by developer on 04/05/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var usersListTblVew: UITableView!
    
    var dataArray = [[String:Any]]()
    var array = [[String]]()
    var celllayoutDictionary  = [String:AnyObject]()
    let cornerRadius: CGFloat = 6.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.usersListTblVew.register(UsersTableViewCellClass.self, forCellReuseIdentifier: "UserCell")
         
        var request = URLRequest(url: URL(string: "https://reqres.in/api/users")!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil else {
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
               
                dataArray = json["data"] as! [[String : Any]]
                print(dataArray)
                DispatchQueue.main.async {
                    self.usersListTblVew.reloadData()
                }
            }
            catch let error as NSError {
                print(error)
            }
            
        }
        task.resume()
        
}
    //MARK: - TABLEVIEW DELEGATE AND DATASOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dataArray.count",dataArray.count)
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.usersListTblVew.dequeueReusableCell(withIdentifier: "UserCell") as! UsersTableViewCellClass
        var dict  = dataArray[indexPath.row]
      
        
      //  Creating layout dictionary :
        
        //Background view
        celllayoutDictionary["userView"] = cell.userView
        cell.userView.translatesAutoresizingMaskIntoConstraints = false
        cell.userView.backgroundColor = .white
        cell.addSubview(cell.userView)
        cell.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[userView]-(20)-|" , options: [], metrics: nil, views: celllayoutDictionary))
        cell.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[userView]-(20)-|", options: [], metrics: nil, views: celllayoutDictionary))
        cell.userView.dropShadow()
        
        //Profile Image view
        celllayoutDictionary["userImageView"] = cell.userImageView
        cell.userImageView.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(cell.userImageView)
        let url = URL(string: dict["avatar"] as! String)
         let data = try? Data(contentsOf: url!)
        cell.userImageView.image = UIImage(data: data!)
        cell.userImageView.layer.cornerRadius = 50
        cell.userImageView.clipsToBounds = true
        
        
        //Fullname label
        celllayoutDictionary["userNameLbl"] = cell.userNameLbl
        cell.userNameLbl.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(cell.userNameLbl)
        self.lblProperties(label: cell.userNameLbl, text: "\(dict["first_name"]!) \(dict["last_name"]!)", color: UIColor.orange, alignment: .left, font: UIFont.systemFont(ofSize: 18))
        cell.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[userImageView(100)]-(10)-[userNameLbl]-(10)-|" , options: [], metrics: nil, views: celllayoutDictionary))
        cell.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(10)-[userImageView(100)]", options: [], metrics: nil, views: celllayoutDictionary))
        cell.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(10)-[userNameLbl(40)]", options: [], metrics: nil, views: celllayoutDictionary))
        
        //Email label
        celllayoutDictionary["userEmail"] = cell.userEmail
        cell.userEmail.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(cell.userEmail)
        cell.userEmail.text = dict["email"] as! String
        cell.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[userImageView]-(10)-[userEmail]-(10)-|" , options: [], metrics: nil, views: celllayoutDictionary))
        cell.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[userNameLbl]-(10)-[userEmail(40)]", options: [], metrics: nil, views: celllayoutDictionary))
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetsilsSegue", sender: dataArray[indexPath.row])
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
     }
    
    func lblProperties(label:UILabel,text:String,color:UIColor,alignment:NSTextAlignment,font:UIFont)  {
        label.text = text
        label.textColor = color
        label.textAlignment = alignment
        label.font = font
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier  == "DetsilsSegue" ){
            let vc = segue.destination as! UsersDetailsViewController
            vc.items = sender as! NSDictionary
            print("vc.items",vc.items)
        }
        
    }
}

// Shadow view
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 0.3
        self.layer.shadowOpacity = 0.5
    }
}
