//
//  OkashiData.swift
//  MyOkashi
//
//  Created by 石崎汐音 on 2024/04/24.
//

import SwiftUI

struct OkashiItem : Identifiable {
    let id = UUID()
    let name :String
    let link : URL
    let image : URL
    
    
}



@Observable class OkashiData {
    
    struct ResultJson : Codable {
        
        struct item : Codable {
            let name : String?
            let url : URL?
            let image : URL?
        }
        
        let item : [item]?
        
    }
    
    var okashiList: [OkashiItem] = []
    
    var okashiLink : URL?
    
    
    
    
    
    func seachOkashi(keyword: String){
        
        print("seachOkashiメソッドで受けとった値：\(keyword)")
        
        
        Task{
            
            await seach(keyword:keyword)
        }
        
        
    }
    
    
    @MainActor
    
    private func seach(keyword : String) async {

        
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }
        
        guard let req_url = URL(string:"https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
            
        }
        print(req_url)
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: req_url)
            let decoder = JSONDecoder()
            let json = try decoder.decode(ResultJson.self, from:data)
            
            
            
         //   print(json)
            
            guard let items = json.item else { return }
            okashiList.removeAll()
            
            
            for item in items {
                
                if let name = item.name,
                   let link = item.url,
                   let image = item.image{
                    
                    
                    let okashi = OkashiItem (name:name , link :link , image : image )
                    okashiList.append(okashi)
                    
                }
                
            }
            
            
        } catch{
            
            print("エラーがでました")
            
        }
        
        
        
    }
    
    
    
    
    
    
}
