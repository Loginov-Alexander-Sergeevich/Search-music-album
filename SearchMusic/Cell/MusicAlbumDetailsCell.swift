//
//  MusicAlbumDetailsCell.swift
//  SearchMusic
//
//  Created by Александр Логинов on 19.12.2021.
//

import Foundation
import UIKit

class MusicAlbumDetailsCell: UITableViewCell {

    let nameSongLabel: UILabel = {
       let label = UILabel()
        label.text = "Song"
        return label
    }()
    
    let separatorStyleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
        configurationConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Установи элементы в ячейку
    private func setCell() {
        addSubviews(views: [nameSongLabel, separatorStyleView])
    }
   
    /// Усьанови ограничения
    private func configurationConstraints() {

        nameSongLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }

        separatorStyleView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.leading.trailing.equalToSuperview()

        }
    }
    
    /// Конфигурвция контернта
    /// - Parameter songs: Треки пришедшие из JSON
    public func configurationContent(_ songs: Results) {
        self.nameSongLabel.text = songs.trackName
    }
}
