//
//  MockDataLoader.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import Foundation

class MockDataLoader: DataLoader {
        
    private let mockData = DataHome(source: [
        [Banner(type: "TitleCell", username: "Thanh Tuyền", userScore: 13, imgBanner: "https://imgcdn.be.com.vn/vehicle/reskin/Banner-Day.png")],
        [Location(type: "InputLocationCell")],
        [
            Service(type: "ServiceCell1", name: "Giao hàng", img: "https://imgcdn.be.com.vn/be-config/services/ic-home-deli2%403x.png"),
            Service(type: "ServiceCell1", name: "Gói hội viên", img: "https://imgcdn.be.com.vn/be-config/services/ic-home-sub2%403x.png"),
            Service(type: "ServiceCell2", name: "Food", img: "https://media-dev.be.com.vn/bizops/image/9ee655a2-2cdc-11ec-8b8b-425fea39ed52/original"),
            Service(type: "ServiceCell2", name: "Bảo hiểm xe", img: "https://media-dev.be.com.vn/bizops/image/8f50eeec-107e-11ec-aef9-0ed28ea87416/original"),
            Service(type: "ServiceCell2", name: "Đi chợ", img: "https://imgcdn.be.com.vn/be-config/services/ic_home_shopDisable%403x.png"),
            Service(type: "ServiceCell2", name: "Vé xe khách", img: "https://imgcdn.be.com.vn/be-config/services/ic-home-bus2%403x.png"),
            Service(type: "ServiceCell2", name: "Ưu đãi", img: "https://imgcdn.be.com.vn/be-config/services/ic-home-promo2%403x.png"),
            Service(type: "ServiceCell2", name: "Đổi điểm", img: "https://imgcdn.be.com.vn/be-config/services/ic-home-exchange%403x.png"),
            Service(type: "ServiceCell2", name: "Vé máy bay", img: "https://imgcdn.be.com.vn/be-config/services/ic_home_plane%403x.png"),
            Service(type: "ServiceCell2", name: "Dịch vụ khác", img: "https://imgcdn.be.com.vn/be-config/services/ic_home_plane%403x.png"),
        ]
    ])
    
    func loadData(completion: @escaping (DataHome) -> Void) {
        completion(mockData)
    }
}
