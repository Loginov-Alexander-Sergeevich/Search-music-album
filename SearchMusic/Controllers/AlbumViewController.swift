//
//  AlbumViewController.swift
//  TestJSON
//
//  Created by Александр Логинов on 15.12.2021.
//

import Foundation
import UIKit
import SnapKit
import Moya


class AlbumViewController: UIViewController {
    
    let provider = MoyaProvider<AlbumItunesAPI>()
    
    var resultsAlbums: [ResultsAlbums] = []
    
    var timer: Timer?
    
    lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.delegate = self
        return search
    }()
    
    
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
        
        getAlbums(albumName: "Scorpions")
        albumTableView.reloadData()
        configurationConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
    }
}

extension AlbumViewController {
    
    /// Установи ограничения
    func configurationConstraints() {
        view.addSubview(albumTableView)
        albumTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /// Запроси данные
    /// - Parameter albumName: Данные которые необходимы
    func getAlbums(albumName: String) {
        
        // Запрс
        provider.request(.search(path: albumName)) { [unowned self] result in
            
            switch result {
            case .success(let response):
                // Получи данные JSON и распарси
                do {
                    let results = try response.map(Albums.self).results?.sorted(by: { firstItem, secondItem in
                        return firstItem.collectionName?.compare(secondItem.collectionName!) == ComparisonResult.orderedAscending
                    })
                    // Добави полученные данне в resultsAlbums
                    self.resultsAlbums.append(contentsOf: results!)
                    // Обнови таблицу как получиш данные
                    self.albumTableView.reloadData()
                } catch {
                    print("Error - Не получилось распарсить данные")
                }
            case .failure(_):
                print("Ошибка запроса JSON")
            }
        }
    }
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumViewCell
        let albums = resultsAlbums[indexPath.row]
        cell.configurationContent(albums)
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    
    // Переход на DetailAlbumViewCintroller при нажатии на ячейку и передача данных
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAlbumViewCintroller = DetailAlbumViewCintroller()
        let albums = resultsAlbums[indexPath.row]
        detailAlbumViewCintroller.albums = albums
        detailAlbumViewCintroller.title = albums.artistName
        navigationController?.pushViewController(detailAlbumViewCintroller, animated: true)
    }
    
}

extension AlbumViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Если строка поиска не пустая
        if searchText != "" {
            // Останови таймер
            timer?.invalidate()
            // Таймер при вводе названия в строку поиска
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] _ in
                // Запрос искомых данных
                self?.getAlbums(albumName: searchText)
                self?.albumTableView.reloadData()
            })
        }
    }
}
