//
//  ViewController.swift
//  ApiCall
//
//  Created by Narasimha on 24/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let albumManager = AlbumManager()
    
    var albums:[Albums] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
   }
}


extension ViewController{
    
    func initial(){
        tableView.delegate = self
        tableView.dataSource = self
        albumManager.getAlbums { result in
            switch result {
            case .success(let albums):
                DispatchQueue.main.async {
                    self.albums = albums
                    self.tableView.reloadData()
                }
            case .failure(let error):
           
                print(error.localizedDescription)
            }
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.userId.text = "\(albums[indexPath.row].userId)"
        cell.id.text = "\(albums[indexPath.row].id)"
        cell.title.text = (albums[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


