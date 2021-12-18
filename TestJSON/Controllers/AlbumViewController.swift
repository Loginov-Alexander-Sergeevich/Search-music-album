//
//  AlbumViewController.swift
//  TestJSON
//
//  Created by Александр Александров on 15.12.2021.
//

import Foundation
import UIKit
import SnapKit
import Moya


class AlbumViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    let provider = MoyaProvider<AlbumItunesAPI>()
    
    var resultsRequestAlbums: [ResultsRequestAlbums] = []
    
    
    lazy var albumTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(AlbumViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAlbums(albumName: "Scu")
        configurationConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Albums"
    }
}

extension AlbumViewController {
    
    func configurationConstraints() {
        view.addSubview(albumTableView)
        albumTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func getAlbums(albumName: String) {
        
//                if let respon = networkManager.getAlbum(nameAlbum: albumName) {
//                    self.resultsRequestAlbums.append(contentsOf: respon)
//                    self.albumTableView.reloadData()
//                } else {
//                    print("НЕТ ДАННЫХ")
//                }
        provider.request(.search(path: albumName)) { [unowned self]result in
            
            switch result {
            case .success(let response):
                do {
                    //self.resultsRequestAlbums  = try response.map(RequestAlbums.self).results
                    let resp = try response.map(RequestAlbums.self).results!
                    self.resultsRequestAlbums.append(contentsOf: resp)
                    self.albumTableView.reloadData()
                } catch {
                    print("")
                }
            case .failure(_):
                print("Error jsone request")
            }
            
        }
    }
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return resultsRequestAlbums.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumViewCell
        
        let albums = resultsRequestAlbums[indexPath.row]
        cell.configurationContent(albums)
//        cell.albumNameLabel.text = "albumNameLabel"
//        cell.artistNameLabel.text = "artistNameLabel"
//        cell.numberOfTracksLabel.text = "1 tracks"
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    
}
