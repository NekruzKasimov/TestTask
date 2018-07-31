//
//  PostsViewController.swift
//  TestTask
//
//  Created by Niko on 7/31/18.
//  Copyright © 2018 Niko. All rights reserved.
//

import UIKit
import SafariServices

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    var data = Array<AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        ServerManager.shared.getPosts(completion: { (posts) in
            var shufledPosts = posts
            shufledPosts.shuffle()
            self.data = Array(shufledPosts.prefix(upTo: 10)) as [AnyObject]
            ServerManager.shared.getWeather(completion: { (weather) in
                self.data.append(contentsOf: weather)
                self.data.shuffle()
                self.tableView.reloadData()
            }, error: { (message) in
                self.showErrorAlert(message: message)
            })
        }) { (message) in
            self.showErrorAlert(message: message)
        }
        
    }
}

// MARK: TableView Configuration
extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = data[indexPath.row]
        if item is Weather {
            let weather = item as! Weather
            cell?.textLabel?.text = weather.name
            cell?.detailTextLabel?.text = "\(weather.main?.temp ?? 0) °C"
        } else {
            let post = item as! Post
            cell?.textLabel?.text = post.title
            cell?.detailTextLabel?.text = post.body
        }
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        if item is Weather {
            if let url = URL(string: "http://o.kg") {
                let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                present(vc, animated: true)
            }
        } else {
            let post = item as! Post
            let storyboard = UIStoryboard(name: "Posts", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
            vc.postsId = post.id
            self.navigationController?.show(vc, sender: self)
        }
    }
}
