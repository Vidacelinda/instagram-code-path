//
//  feedViewController.swift
//  instagram
//
//  Created by Carlo Leiva on 9/30/22.
//NOTE
//<key>NSAppTransportSecurity</key>
//<dict>
//    <key>NSAllowsArbitraryLoads</key><true/>
//</dict>

import UIKit
import Parse
import AlamofireImage

class feedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Post")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground{(posts,error)in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlSting = imageFile.url!
        let url = URL(string: urlSting)!
        
        cell.photoView.af.setImage(withURL: url)
        
        return cell
    }
}
