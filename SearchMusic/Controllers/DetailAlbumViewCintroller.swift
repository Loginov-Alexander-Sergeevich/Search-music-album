//
//  DetailAlbumViewCintroller.swift
//  SearchMusic
//
//  Created by Александр Логинов on 19.12.2021.
//

import Foundation
import UIKit
import Moya

class DetailAlbumViewCintroller: UIViewController {
    
    let provider = MoyaProvider<AlbumItunesAPI>()
    
    let albumImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemRed
        image.clipsToBounds = true
        return image
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "albumNameLabel"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "artistNameLabel"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "10 tracks"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let albumReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "10.10.2000"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var tracksTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MusicAlbumDetailsCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var albums: ResultsAlbums?
    
    var  songsModel: [Results] = []
    
    
    var albumDetailStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView()
        configurationConstraints()
        configurationContent()
        
    }
    
    /// Получи песни
    /// - Parameter idSong: Идентефикатор
    func getSongs(idSong: Int) {
        
        provider.request(.lookup(id: idSong)) { [unowned self] result in
            switch result {
                
            case .success(let response):
                do {
                    let song = try response.map(SongsModel.self).results
                    self.songsModel.append(contentsOf: song)
                    self.tracksTableView.reloadData()
                } catch {
                    print("Error - Не получилось распарсить данные")
                }
            case .failure(_):
                print("Ошидка запроса JSON")
            }
        }
    }
    
    /// Контент для отображение
    private func configurationContent() {
        guard let albums = albums else { return }
        
        let url = URL(string: albums.artworkUrl100!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.albumImage.image = UIImage(data: data!)
            }
        }
        
        albumNameLabel.text = albums.collectionName
        artistNameLabel.text = albums.artistName
        trackCountLabel.text = "\(String(describing: albums.trackCount!)) tracks:"
        getSongs(idSong: albums.collectionId)
        
        
        
    }
    
    /// Размести элементы на view
    func configurationView() {
        view.backgroundColor = .white
        
        albumDetailStackView = UIStackView(arrangedSubviews: [albumNameLabel,
                                                              artistNameLabel,
                                                              albumReleaseDateLabel,
                                                              trackCountLabel],
                                           axis: .vertical,
                                           spacing: 10,
                                           distribution: .fillEqually)
        
        view.addSubviews(views: [albumImage, albumDetailStackView, tracksTableView])
    }
    
    /// Установи ограничения
    private func configurationConstraints() {
        let imageSize: CGFloat = 100
        
        albumImage.snp.makeConstraints { make in
            make.size.equalTo(imageSize)
            make.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(100)
        }
        
        albumDetailStackView.snp.makeConstraints { make in
            make.leading.equalTo(albumImage.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalTo(albumImage.snp.top)
        }
        
        tracksTableView.snp.makeConstraints { make in
            make.top.equalTo(albumImage.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension DetailAlbumViewCintroller: UITableViewDelegate {
}

extension DetailAlbumViewCintroller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicAlbumDetailsCell
        let song = songsModel[indexPath.item]
        cell.configurationContent(song)
        return cell
    }
}
